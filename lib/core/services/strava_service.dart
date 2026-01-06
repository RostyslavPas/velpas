import 'dart:math';

import '../utils/formatters.dart';
import '../../data/repositories/ride_repository.dart';

class SyncResult {
  SyncResult({required this.added, required this.totalDistanceKm});

  final int added;
  final int totalDistanceKm;

  String summary() => '${Formatters.km(totalDistanceKm)} km';
}

abstract class StravaService {
  Future<SyncResult> syncBike(int bikeId);
}

class MockStravaService implements StravaService {
  MockStravaService(this._rideRepository);

  final RideRepository _rideRepository;

  @override
  Future<SyncResult> syncBike(int bikeId) async {
    final random = Random();
    final count = random.nextInt(3) + 1;
    final now = DateTime.now();
    final activities = List.generate(count, (index) {
      final distance = 20 + random.nextInt(101);
      final date = now.subtract(Duration(days: random.nextInt(14)));
      return MockActivity(
        id: 'mock_${date.millisecondsSinceEpoch}_$index',
        bikeId: bikeId,
        distanceKm: distance,
        dateTime: date,
        source: 'mock_strava',
      );
    });

    final added = await _rideRepository.insertMockActivities(activities);
    final total = activities.fold<int>(
      0,
      (sum, item) => sum + item.distanceKm,
    );
    return SyncResult(added: added, totalDistanceKm: total);
  }
}

class MockActivity {
  MockActivity({
    required this.id,
    required this.bikeId,
    required this.distanceKm,
    required this.dateTime,
    required this.source,
  });

  final String id;
  final int bikeId;
  final int distanceKm;
  final DateTime dateTime;
  final String source;
}
