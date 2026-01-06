import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:dio/dio.dart';

import '../data/db/app_database.dart';
import '../data/db/daos/bike_dao.dart';
import '../data/db/daos/component_dao.dart';
import '../data/db/daos/meta_dao.dart';
import '../data/db/daos/ride_dao.dart';
import '../data/db/daos/wardrobe_dao.dart';
import '../data/repositories/bike_repository.dart';
import '../data/repositories/component_repository.dart';
import '../data/repositories/ride_repository.dart';
import '../data/repositories/wardrobe_repository.dart';
import 'services/biometric_service.dart';
import 'services/secure_storage_service.dart';
import 'services/seed_service.dart';
import 'services/strava_service.dart';
import 'services/strava_api_client.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final secureStorageServiceProvider = Provider<SecureStorageService>(
  (ref) => SecureStorageService(
    ref.watch(secureStorageProvider),
    ref.watch(metaDaoProvider),
  ),
);

final biometricServiceProvider = Provider<BiometricService>(
  (ref) => BiometricService(LocalAuthentication()),
);

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)));
});

final stravaApiClientProvider = Provider<StravaApiClient>((ref) {
  return StravaApiClient(ref.watch(dioProvider));
});

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final bikeDaoProvider = Provider<BikeDao>((ref) {
  return BikeDao(ref.watch(databaseProvider));
});

final componentDaoProvider = Provider<ComponentDao>((ref) {
  return ComponentDao(ref.watch(databaseProvider));
});

final rideDaoProvider = Provider<RideDao>((ref) {
  return RideDao(ref.watch(databaseProvider));
});

final wardrobeDaoProvider = Provider<WardrobeDao>((ref) {
  return WardrobeDao(ref.watch(databaseProvider));
});

final metaDaoProvider = Provider<MetaDao>((ref) {
  return MetaDao(ref.watch(databaseProvider));
});

final bikeRepositoryProvider = Provider<BikeRepository>((ref) {
  return BikeRepository(ref.watch(bikeDaoProvider));
});

final componentRepositoryProvider = Provider<ComponentRepository>((ref) {
  return ComponentRepository(ref.watch(componentDaoProvider));
});

final rideRepositoryProvider = Provider<RideRepository>((ref) {
  return RideRepository(ref.watch(rideDaoProvider));
});

final wardrobeRepositoryProvider = Provider<WardrobeRepository>((ref) {
  return WardrobeRepository(ref.watch(wardrobeDaoProvider));
});

final stravaServiceProvider = Provider<StravaService>((ref) {
  return MockStravaService(ref.watch(rideRepositoryProvider));
});

final seedServiceProvider = Provider<SeedService>((ref) {
  return SeedService(
    metaDao: ref.watch(metaDaoProvider),
    bikeDao: ref.watch(bikeDaoProvider),
    componentDao: ref.watch(componentDaoProvider),
  );
});

final appInitProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(databaseProvider);
  await db.init();
  await ref.watch(seedServiceProvider).seedIfNeeded();
});
