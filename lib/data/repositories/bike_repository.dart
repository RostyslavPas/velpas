import '../db/daos/bike_dao.dart';
import '../models/bike_models.dart';

class BikeRepository {
  BikeRepository(this._bikeDao);

  final BikeDao _bikeDao;

  Stream<List<BikeWithStats>> watchBikes() => _bikeDao.watchAllWithStats();

  Stream<BikeWithStats?> watchBike(int id) => _bikeDao.watchByIdWithStats(id);

  Future<int> addBike({
    required String name,
    double? purchasePrice,
    String? photoPath,
    String? stravaGearId,
    int manualKm = 0,
  }) {
    return _bikeDao.insertBike(
      name: name,
      purchasePrice: purchasePrice,
      photoPath: photoPath,
      manualKm: manualKm,
      stravaGearId: stravaGearId,
    );
  }

  Future<void> updateBike({
    required int id,
    required String name,
    double? purchasePrice,
    String? photoPath,
  }) {
    return _bikeDao.updateBike(
      id: id,
      name: name,
      purchasePrice: purchasePrice,
      photoPath: photoPath,
    );
  }

  Future<void> deleteBike(int id) => _bikeDao.deleteBike(id);

  Future<void> updateStravaGearId(int id, String? gearId) {
    return _bikeDao.updateStravaGearId(id, gearId);
  }

  Future<void> updateManualKm(int id, int manualKm) {
    return _bikeDao.updateManualKm(id, manualKm);
  }

  Future<List<Bike>> fetchAllBikes() => _bikeDao.fetchAllBikes();

  Future<Map<String, int>> fetchStravaBikeMap() => _bikeDao.fetchStravaBikeMap();
}
