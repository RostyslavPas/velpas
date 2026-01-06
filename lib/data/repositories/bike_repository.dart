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
  }) {
    return _bikeDao.insertBike(
      name: name,
      purchasePrice: purchasePrice,
      photoPath: photoPath,
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
}
