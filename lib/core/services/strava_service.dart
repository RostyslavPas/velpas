import 'dart:math';

import 'package:dio/dio.dart';
import '../utils/formatters.dart';
import '../../data/repositories/ride_repository.dart';
import '../../data/repositories/bike_repository.dart';
import '../../data/models/ride_models.dart';
import '../../data/models/bike_models.dart';
import '../models/strava_models.dart';
import 'secure_storage_service.dart';
import 'strava_api_client.dart';
import 'strava_token_service.dart';

class SyncResult {
  SyncResult({required this.added, required this.totalDistanceKm});

  final int added;
  final int totalDistanceKm;

  String summary() => '${Formatters.km(totalDistanceKm)} km';
}

class BikeImportResult {
  BikeImportResult({
    required this.added,
    required this.linked,
    required this.skipped,
  });

  final int added;
  final int linked;
  final int skipped;
}

enum StravaAuthError { notConnected, expired }

class StravaAuthException implements Exception {
  StravaAuthException(this.error);

  final StravaAuthError error;
}

abstract class StravaService {
  Future<SyncResult> syncBike(int bikeId, {bool fullSync = false});
  Future<BikeImportResult> importBikes();
}

class RealStravaService implements StravaService {
  RealStravaService({
    required this.apiClient,
    required this.rideRepository,
    required this.bikeRepository,
    required this.storage,
    required this.tokenService,
  });

  final StravaApiClient apiClient;
  final RideRepository rideRepository;
  final BikeRepository bikeRepository;
  final SecureStorageService storage;
  final StravaTokenService tokenService;

  @override
  Future<SyncResult> syncBike(int bikeId, {bool fullSync = false}) async {
    final tokens = await storage.getStravaTokens();
    if (tokens == null) {
      throw StravaAuthException(StravaAuthError.notConnected);
    }
    var activeTokens = tokens;
    if (activeTokens.isExpired) {
      activeTokens = await _refreshTokens(activeTokens);
    }

    if (fullSync) {
      await rideRepository.deleteBySource('strava');
    }
    final after = fullSync ? null : await storage.getLastSyncAt();
    final activities = await _fetchActivities(activeTokens, after);

    final gearMap = await bikeRepository.fetchStravaBikeMap();
    final imports = <RideImportInput>[];
    for (final activity in activities) {
      final gearId = activity.gearId;
      if (gearId == null) continue;
      final mappedBikeId = gearMap[gearId];
      if (mappedBikeId == null) continue;
      imports.add(
        RideImportInput(
          id: 'strava_${activity.id}',
          bikeId: mappedBikeId,
          distanceKm: max(0, (activity.distanceMeters / 1000).floor()),
          dateTime: activity.startDate,
          source: 'strava',
        ),
      );
    }

    final result = imports.isEmpty
        ? RideInsertResult(added: 0, totalDistanceKm: 0)
        : await rideRepository.insertActivities(imports);
    await _syncStravaBikeTotals(activeTokens);
    return SyncResult(added: result.added, totalDistanceKm: result.totalDistanceKm);
  }

  @override
  Future<BikeImportResult> importBikes() async {
    final tokens = await storage.getStravaTokens();
    if (tokens == null) {
      throw StravaAuthException(StravaAuthError.notConnected);
    }
    var activeTokens = tokens;
    if (activeTokens.isExpired) {
      activeTokens = await _refreshTokens(activeTokens);
    }

    var stravaBikes = await apiClient.fetchBikes(
      accessToken: activeTokens.accessToken,
    );
    final fallbackBikes = await _inferBikesFromActivities(activeTokens);
    if (fallbackBikes.isNotEmpty) {
      final merged = <String, StravaBike>{};
      for (final bike in stravaBikes) {
        merged[bike.gearId] = bike;
      }
      for (final bike in fallbackBikes) {
        final existing = merged[bike.gearId];
        if (existing == null ||
            (existing.distanceKm == 0 && bike.distanceKm > 0)) {
          merged[bike.gearId] = bike;
        }
      }
      stravaBikes = merged.values.toList();
    }
    if (stravaBikes.isEmpty) {
      return BikeImportResult(added: 0, linked: 0, skipped: 0);
    }

    final localBikes = await bikeRepository.fetchAllBikes();
    var added = 0;
    var linked = 0;
    var skipped = 0;

    for (final stravaBike in stravaBikes) {
      final existingByGear = localBikes
          .where((bike) => bike.stravaGearId == stravaBike.gearId)
          .toList();
      if (existingByGear.isNotEmpty) {
        final existing = existingByGear.first;
        skipped += 1;
        continue;
      }

      final targetName = stravaBike.name.trim().toLowerCase();
      Bike? nameMatch;
      for (final bike in localBikes) {
        if (bike.stravaGearId == null &&
            bike.name.trim().toLowerCase() == targetName) {
          nameMatch = bike;
          break;
        }
      }

      if (nameMatch != null) {
        await bikeRepository.updateStravaGearId(
          nameMatch.id,
          stravaBike.gearId,
        );
        final index = localBikes.indexOf(nameMatch);
        if (index != -1) {
          localBikes[index] = Bike(
            id: nameMatch.id,
            name: nameMatch.name,
            manualKm: nameMatch.manualKm,
            createdAt: nameMatch.createdAt,
            purchasePrice: nameMatch.purchasePrice,
            photoPath: nameMatch.photoPath,
            stravaGearId: stravaBike.gearId,
          );
        }
        linked += 1;
        continue;
      }

      final newId = await bikeRepository.addBike(
        name: stravaBike.name,
        stravaGearId: stravaBike.gearId,
        manualKm: 0,
      );
      localBikes.add(
        Bike(
          id: newId,
          name: stravaBike.name,
          manualKm: 0,
          createdAt: DateTime.now(),
          stravaGearId: stravaBike.gearId,
        ),
      );
      added += 1;
    }

    return BikeImportResult(added: added, linked: linked, skipped: skipped);
  }

  Future<List<StravaBike>> _inferBikesFromActivities(StravaTokens tokens) async {
    try {
      final activities = await apiClient.fetchActivities(
        accessToken: tokens.accessToken,
        after: null,
        perPage: 200,
      );
      final gearIds = <String>{};
      for (final activity in activities) {
        final gearId = activity.gearId;
        if (gearId != null && gearId.isNotEmpty) {
          gearIds.add(gearId);
        }
      }
      if (gearIds.isEmpty) return [];
      final bikes = <StravaBike>[];
      for (final gearId in gearIds) {
        try {
          final bike = await apiClient.fetchGear(
            accessToken: tokens.accessToken,
            gearId: gearId,
          );
          if (bike != null) {
            bikes.add(bike);
          } else {
            bikes.add(
              StravaBike(
                gearId: gearId,
                name: 'Strava bike $gearId',
                distanceKm: 0,
              ),
            );
          }
        } on DioException {
          bikes.add(
            StravaBike(
              gearId: gearId,
              name: 'Strava bike $gearId',
              distanceKm: 0,
            ),
          );
        }
      }
      return bikes;
    } on DioException {
      return [];
    }
  }

  Future<void> _syncStravaBikeTotals(StravaTokens tokens) async {
    final stravaBikes = await apiClient.fetchBikes(
      accessToken: tokens.accessToken,
    );
    if (stravaBikes.isEmpty) return;
    final localBikes = await bikeRepository.fetchAllBikes();
    final localByGear = <String, Bike>{};
    for (final bike in localBikes) {
      final gearId = bike.stravaGearId;
      if (gearId != null && gearId.isNotEmpty) {
        localByGear[gearId] = bike;
      }
    }
    for (final stravaBike in stravaBikes) {
      final local = localByGear[stravaBike.gearId];
      if (local == null) continue;
      final ridesKm = await rideRepository.sumDistanceByBike(local.id);
      final manualKm = stravaBike.distanceKm - ridesKm;
      await bikeRepository.updateManualKm(local.id, manualKm);
    }
  }

  Future<List<StravaActivity>> _fetchActivities(StravaTokens tokens, DateTime? after) async {
    try {
      return await _fetchAllActivities(tokens, after);
    } on DioException catch (error) {
      final status = error.response?.statusCode ?? 0;
      if (status == 401 || status == 403) {
        final refreshed = await _refreshTokens(tokens);
        return _fetchAllActivities(refreshed, after);
      }
      rethrow;
    }
  }

  Future<List<StravaActivity>> _fetchAllActivities(
    StravaTokens tokens,
    DateTime? after,
  ) async {
    const perPage = 200;
    const maxPages = 20;
    final all = <StravaActivity>[];
    for (var page = 1; page <= maxPages; page += 1) {
      final batch = await apiClient.fetchActivities(
        accessToken: tokens.accessToken,
        after: after,
        perPage: perPage,
        page: page,
      );
      if (batch.isEmpty) break;
      all.addAll(batch);
      if (batch.length < perPage) break;
    }
    return all;
  }

  Future<StravaTokens> _refreshTokens(StravaTokens tokens) async {
    try {
      final refreshed = await tokenService.refresh(tokens.refreshToken);
      await storage.setStravaTokens(refreshed);
      return refreshed;
    } catch (_) {
      await storage.clearStravaTokens();
      throw StravaAuthException(StravaAuthError.expired);
    }
  }
}

class MockStravaService implements StravaService {
  MockStravaService(this._rideRepository);

  final RideRepository _rideRepository;

  @override
  Future<SyncResult> syncBike(int bikeId, {bool fullSync = false}) async {
    final random = Random();
    final count = random.nextInt(3) + 1;
    final now = DateTime.now();
    final imports = List.generate(count, (index) {
      final distance = 20 + random.nextInt(101);
      final date = now.subtract(Duration(days: random.nextInt(14)));
      return RideImportInput(
        id: 'mock_${date.millisecondsSinceEpoch}_$index',
        bikeId: bikeId,
        distanceKm: distance,
        dateTime: date,
        source: 'mock_strava',
      );
    });

    final result = await _rideRepository.insertActivities(imports);
    return SyncResult(added: result.added, totalDistanceKm: result.totalDistanceKm);
  }

  @override
  Future<BikeImportResult> importBikes() async {
    return BikeImportResult(added: 0, linked: 0, skipped: 0);
  }
}
