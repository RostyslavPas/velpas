import 'package:drift/drift.dart';
import '../app_database.dart';
import '../../models/ride_models.dart';

class RideDao {
  RideDao(this._db);

  final AppDatabase _db;

  Stream<List<RideImport>> watchByBike(int bikeId) {
    return _db
        .customSelect(
          'SELECT * FROM ride_imports WHERE bike_id = ? ORDER BY date_time DESC',
          variables: [Variable<int>(bikeId)],
          readsFrom: {_db.rideImportsTable},
        )
        .watch()
        .map((rows) => rows.map(_mapRide).toList());
  }

  Future<int> countByBike(int bikeId) async {
    final row = await _db.customSelect(
      'SELECT COUNT(*) AS total FROM ride_imports WHERE bike_id = ?',
      variables: [Variable<int>(bikeId)],
      readsFrom: {_db.rideImportsTable},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> sumDistanceByBike(int bikeId) async {
    final row = await _db.customSelect(
      'SELECT COALESCE(SUM(distance_km), 0) AS total_km FROM ride_imports WHERE bike_id = ?',
      variables: [Variable<int>(bikeId)],
      readsFrom: {_db.rideImportsTable},
    ).getSingle();
    return row.read<int>('total_km');
  }

  Future<void> deleteBySource(String source) async {
    await _db.customUpdate(
      'DELETE FROM ride_imports WHERE source = ?',
      variables: [Variable<String>(source)],
      updates: {_db.rideImportsTable},
      updateKind: UpdateKind.delete,
    );
  }

  Future<RideInsertResult> insertActivities(List<RideImportInput> activities) async {
    var added = 0;
    var totalDistanceKm = 0;
    await _db.transaction(() async {
      for (final activity in activities) {
        final result = await _db.customInsert(
          '''
          INSERT OR IGNORE INTO ride_imports
          (id, bike_id, distance_km, date_time, source)
          VALUES (?, ?, ?, ?, ?)
          ''',
          variables: [
            Variable<String>(activity.id),
            Variable<int>(activity.bikeId),
            Variable<int>(activity.distanceKm),
            Variable<String>(activity.dateTime.toIso8601String()),
            Variable<String>(activity.source),
          ],
          updates: {_db.rideImportsTable},
        );
        if (result > 0) {
          added += 1;
          totalDistanceKm += activity.distanceKm;
        }
      }
    });
    return RideInsertResult(added: added, totalDistanceKm: totalDistanceKm);
  }

  RideImport _mapRide(QueryRow row) {
    return RideImport(
      id: row.read<String>('id'),
      bikeId: row.read<int>('bike_id'),
      distanceKm: row.read<int>('distance_km'),
      dateTime: DateTime.parse(row.read<String>('date_time')),
      source: row.read<String>('source'),
    );
  }
}
