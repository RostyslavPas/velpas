import '../db/daos/ride_dao.dart';
import '../../core/services/strava_service.dart';
import '../models/ride_models.dart';

class RideRepository {
  RideRepository(this._rideDao);

  final RideDao _rideDao;

  Stream<List<RideImport>> watchRides(int bikeId) {
    return _rideDao.watchByBike(bikeId);
  }

  Future<int> insertMockActivities(List<MockActivity> activities) {
    return _rideDao.insertMockActivities(activities);
  }
}
