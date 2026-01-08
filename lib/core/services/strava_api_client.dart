import 'package:dio/dio.dart';
import '../models/strava_models.dart';

class StravaApiClient {
  StravaApiClient(this._dio);

  final Dio _dio;

  Future<List<StravaActivity>> fetchActivities({
    required String accessToken,
    DateTime? after,
    int perPage = 50,
    int page = 1,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/athlete/activities',
      queryParameters: {
        'per_page': perPage,
        'page': page,
        if (after != null) 'after': after.millisecondsSinceEpoch ~/ 1000,
      },
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );
    final data = response.data ?? [];
    final activities = <StravaActivity>[];
    for (final item in data) {
      if (item is Map) {
        final map = item.map((key, value) => MapEntry(key.toString(), value));
        final activity = _mapActivity(map);
        if (activity != null) {
          activities.add(activity);
        }
      }
    }
    return activities;
  }

  Future<List<StravaBike>> fetchBikes({
    required String accessToken,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/athlete',
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );
    final data = response.data ?? {};
    final bikesRaw = data['bikes'];
    if (bikesRaw is! List) return [];
    final bikes = <StravaBike>[];
    for (final item in bikesRaw) {
      if (item is Map) {
        final map = item.map((key, value) => MapEntry(key.toString(), value));
        final bike = _mapBike(map);
        if (bike != null) {
          bikes.add(bike);
        }
      }
    }
    return bikes;
  }

  Future<StravaBike?> fetchGear({
    required String accessToken,
    required String gearId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/gear/$gearId',
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );
    final data = response.data ?? {};
    final bike = _mapBike(data);
    return bike;
  }

  StravaActivity? _mapActivity(Map<String, dynamic> data) {
    final id = data['id'];
    final distance = data['distance'];
    final startDate = data['start_date'];
    if (id is! int || distance is! num || startDate is! String) {
      return null;
    }
    final parsedDate = DateTime.tryParse(startDate);
    if (parsedDate == null) return null;
    return StravaActivity(
      id: id,
      distanceMeters: distance.toDouble(),
      startDate: parsedDate,
      gearId: data['gear_id']?.toString(),
    );
  }

  StravaBike? _mapBike(Map<String, dynamic> data) {
    final gearId = data['id']?.toString();
    if (gearId == null || gearId.isEmpty) {
      return null;
    }
    final rawName = data['name'];
    final name = (rawName is String && rawName.trim().isNotEmpty)
        ? rawName
        : 'Strava bike $gearId';
    final distance = data['distance'];
    final distanceKm = distance is num ? (distance / 1000).floor() : 0;
    return StravaBike(
      gearId: gearId,
      name: name,
      distanceKm: distanceKm,
    );
  }
}
