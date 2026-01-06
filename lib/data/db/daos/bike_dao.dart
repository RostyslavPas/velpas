import 'package:drift/drift.dart';
import '../app_database.dart';
import '../../models/bike_models.dart';

class BikeDao {
  BikeDao(this._db);

  final AppDatabase _db;

  Stream<List<BikeWithStats>> watchAllWithStats() {
    return _db
        .customSelect(
          '''
          SELECT b.*, COALESCE(SUM(r.distance_km), 0) AS rides_km
          FROM bikes b
          LEFT JOIN ride_imports r ON r.bike_id = b.id
          GROUP BY b.id
          ORDER BY b.created_at DESC
          ''',
          readsFrom: {_db.bikesTable, _db.rideImportsTable},
        )
        .watch()
        .map((rows) => rows.map(_mapBikeWithStats).toList());
  }

  Stream<BikeWithStats?> watchByIdWithStats(int id) {
    return _db
        .customSelect(
          '''
          SELECT b.*, COALESCE(SUM(r.distance_km), 0) AS rides_km
          FROM bikes b
          LEFT JOIN ride_imports r ON r.bike_id = b.id
          WHERE b.id = ?
          GROUP BY b.id
          ''',
          variables: [Variable<int>(id)],
          readsFrom: {_db.bikesTable, _db.rideImportsTable},
        )
        .watchSingleOrNull()
        .map((row) => row == null ? null : _mapBikeWithStats(row));
  }

  Future<int> insertBike({
    required String name,
    double? purchasePrice,
    String? photoPath,
    int manualKm = 0,
  }) async {
    return _db.customInsert(
      '''
      INSERT INTO bikes (name, purchase_price, photo_path, manual_km, created_at)
      VALUES (?, ?, ?, ?, ?)
      ''',
      variables: [
        Variable<String>(name),
        Variable<double>(purchasePrice),
        Variable<String>(photoPath),
        Variable<int>(manualKm),
        Variable<String>(DateTime.now().toIso8601String()),
      ],
      updates: {_db.bikesTable},
    );
  }

  Future<void> updateBike({
    required int id,
    required String name,
    double? purchasePrice,
    String? photoPath,
  }) async {
    await _db.customUpdate(
      '''
      UPDATE bikes
      SET name = ?, purchase_price = ?, photo_path = ?
      WHERE id = ?
      ''',
      variables: [
        Variable<String>(name),
        Variable<double>(purchasePrice),
        Variable<String>(photoPath),
        Variable<int>(id),
      ],
      updates: {_db.bikesTable},
    );
  }

  Future<void> updateManualKm(int id, int manualKm) async {
    await _db.customUpdate(
      'UPDATE bikes SET manual_km = ? WHERE id = ?',
      variables: [Variable<int>(manualKm), Variable<int>(id)],
      updates: {_db.bikesTable},
    );
  }

  Future<void> deleteBike(int id) async {
    await _db.customUpdate(
      'DELETE FROM bikes WHERE id = ?',
      variables: [Variable<int>(id)],
      updates: {_db.bikesTable},
      updateKind: UpdateKind.delete,
    );
  }

  BikeWithStats _mapBikeWithStats(QueryRow row) {
    final purchaseValue = row.read<double?>('purchase_price');
    final bike = Bike(
      id: row.read<int>('id'),
      name: row.read<String>('name'),
      purchasePrice: purchaseValue,
      photoPath: row.read<String?>('photo_path'),
      manualKm: row.read<int>('manual_km'),
      createdAt: DateTime.parse(row.read<String>('created_at')),
    );
    return BikeWithStats(
      bike: bike,
      ridesKm: row.read<int>('rides_km'),
    );
  }
}
