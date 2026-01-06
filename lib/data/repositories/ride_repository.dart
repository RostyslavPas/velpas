import '../db/daos/ride_dao.dart';
import '../models/ride_models.dart';

class RideRepository {
  RideRepository(this._rideDao);

  final RideDao _rideDao;

  Stream<List<RideImport>> watchRides(int bikeId) {
    return _rideDao.watchByBike(bikeId);
  }

  Future<int> countRides(int bikeId) {
    return _rideDao.countByBike(bikeId);
  }

  Future<RideInsertResult> insertActivities(List<RideImportInput> activities) {
    return _rideDao.insertActivities(activities);
  }
}
