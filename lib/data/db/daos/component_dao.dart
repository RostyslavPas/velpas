import 'package:drift/drift.dart';
import '../app_database.dart';
import '../../models/component_models.dart';

class ComponentDao {
  ComponentDao(this._db);

  final AppDatabase _db;

  Stream<List<ComponentItem>> watchActiveByBike(int bikeId) {
    return _db
        .customSelect(
          '''
          SELECT * FROM components
          WHERE bike_id = ? AND is_active = 1
          ORDER BY id DESC
          ''',
          variables: [Variable<int>(bikeId)],
          readsFrom: {_db.componentsTable},
        )
        .watch()
        .map((rows) => rows.map(_mapComponent).toList());
  }

  Stream<ComponentItem?> watchById(int id) {
    return _db
        .customSelect(
          'SELECT * FROM components WHERE id = ?',
          variables: [Variable<int>(id)],
          readsFrom: {_db.componentsTable},
        )
        .watchSingleOrNull()
        .map((row) => row == null ? null : _mapComponent(row));
  }

  Stream<List<ComponentHistoryItem>> watchHistory(int componentId) {
    return _db
        .customSelect(
          '''
          SELECT h.*, c.brand AS component_brand, c.model AS component_model
          FROM component_history h
          INNER JOIN components c ON c.id = h.component_id
          WHERE h.component_id = ?
          ORDER BY removed_at DESC
          ''',
          variables: [Variable<int>(componentId)],
          readsFrom: {_db.componentHistoryTable, _db.componentsTable},
        )
        .watch()
        .map((rows) => rows.map(_mapHistory).toList());
  }

  Stream<List<ComponentHistoryItem>> watchHistoryForBikeType({
    required int bikeId,
    required String type,
  }) {
    return _db
        .customSelect(
          '''
          SELECT h.*, c.brand AS component_brand, c.model AS component_model
          FROM component_history h
          INNER JOIN components c ON c.id = h.component_id
          WHERE h.bike_id = ? AND c.type = ?
          ORDER BY h.removed_at DESC
          ''',
          variables: [Variable<int>(bikeId), Variable<String>(type)],
          readsFrom: {_db.componentHistoryTable, _db.componentsTable},
        )
        .watch()
        .map((rows) => rows.map(_mapHistory).toList());
  }

  Stream<double> watchTotalValue() {
    return _db
        .customSelect(
          '''
          SELECT
            (SELECT COALESCE(SUM(price), 0.0) FROM components) +
            (SELECT COALESCE(SUM(price), 0.0) FROM component_history) AS total_value
          ''',
          readsFrom: {_db.componentsTable, _db.componentHistoryTable},
        )
        .watchSingle()
        .map((row) => row.read<double>('total_value'));
  }

  Stream<double> watchTotalValueForBike(int bikeId) {
    return _db
        .customSelect(
          '''
          SELECT
            (SELECT COALESCE(SUM(price), 0.0) FROM components WHERE bike_id = ?) +
            (SELECT COALESCE(SUM(price), 0.0) FROM component_history WHERE bike_id = ?) AS total_value
          ''',
          variables: [Variable<int>(bikeId), Variable<int>(bikeId)],
          readsFrom: {_db.componentsTable, _db.componentHistoryTable},
        )
        .watchSingle()
        .map((row) => row.read<double>('total_value'));
  }

  Future<List<ComponentWearSnapshot>> fetchActiveWearSnapshots({int? bikeId}) async {
    final buffer = StringBuffer()
      ..writeln('SELECT c.*, b.name AS bike_name,')
      ..writeln('  (b.manual_km + COALESCE(r.total_km, 0)) AS bike_km')
      ..writeln('FROM components c')
      ..writeln('INNER JOIN bikes b ON b.id = c.bike_id')
      ..writeln('LEFT JOIN (')
      ..writeln('  SELECT bike_id, SUM(distance_km) AS total_km')
      ..writeln('  FROM ride_imports')
      ..writeln('  GROUP BY bike_id')
      ..writeln(') r ON r.bike_id = b.id')
      ..writeln('WHERE c.is_active = 1');

    final variables = <Variable<Object>>[];
    if (bikeId != null) {
      buffer.writeln('AND c.bike_id = ?');
      variables.add(Variable<int>(bikeId));
    }

    final rows = await _db.customSelect(
      buffer.toString(),
      variables: variables,
      readsFrom: {_db.componentsTable, _db.bikesTable, _db.rideImportsTable},
    ).get();

    return rows
        .map(
          (row) => ComponentWearSnapshot(
            component: _mapComponent(row),
            bikeName: row.read<String>('bike_name'),
            bikeKm: row.read<int>('bike_km'),
          ),
        )
        .toList();
  }

  Future<int> insertComponent({
    required int bikeId,
    required String type,
    required String brand,
    required String model,
    required int expectedLifeKm,
    required int installedAtBikeKm,
    double? price,
    String? notes,
  }) async {
    return _db.customInsert(
      '''
      INSERT INTO components (
        bike_id, type, brand, model, expected_life_km,
        installed_at_bike_km, price, notes, is_active
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1)
      ''',
      variables: [
        Variable<int>(bikeId),
        Variable<String>(type),
        Variable<String>(brand),
        Variable<String>(model),
        Variable<int>(expectedLifeKm),
        Variable<int>(installedAtBikeKm),
        Variable<double>(price),
        Variable<String>(notes),
      ],
      updates: {_db.componentsTable},
    );
  }

  Future<void> updateComponent({
    required int id,
    required String brand,
    required String model,
    required int expectedLifeKm,
    double? price,
    String? notes,
  }) async {
    await _db.customUpdate(
      '''
      UPDATE components
      SET brand = ?, model = ?, expected_life_km = ?, price = ?, notes = ?
      WHERE id = ?
      ''',
      variables: [
        Variable<String>(brand),
        Variable<String>(model),
        Variable<int>(expectedLifeKm),
        Variable<double>(price),
        Variable<String>(notes),
        Variable<int>(id),
      ],
      updates: {_db.componentsTable},
    );
  }

  Future<int> replaceComponent({
    required ComponentItem oldComponent,
    required int removedAtBikeKm,
    required DateTime removedAt,
    required String newBrand,
    required String newModel,
    required int expectedLifeKm,
    double? newPrice,
    String? newNotes,
  }) async {
    return _db.transaction(() async {
      await _db.customUpdate(
        'UPDATE components SET is_active = 0 WHERE id = ?',
        variables: [Variable<int>(oldComponent.id)],
        updates: {_db.componentsTable},
      );

      await _db.customInsert(
        '''
        INSERT INTO component_history (
          component_id, bike_id, removed_at_bike_km, removed_at, price, notes
        )
        VALUES (?, ?, ?, ?, ?, ?)
        ''',
        variables: [
          Variable<int>(oldComponent.id),
          Variable<int>(oldComponent.bikeId),
          Variable<int>(removedAtBikeKm),
          Variable<String>(removedAt.toIso8601String()),
          Variable<double>(oldComponent.price),
          Variable<String>(oldComponent.notes),
        ],
        updates: {_db.componentHistoryTable},
      );

      final newComponentId = await _db.customInsert(
        '''
        INSERT INTO components (
          bike_id, type, brand, model, expected_life_km,
          installed_at_bike_km, price, notes, is_active
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1)
        ''',
        variables: [
          Variable<int>(oldComponent.bikeId),
          Variable<String>(oldComponent.type),
          Variable<String>(newBrand),
          Variable<String>(newModel),
          Variable<int>(expectedLifeKm),
          Variable<int>(removedAtBikeKm),
          Variable<double>(newPrice),
          Variable<String>(newNotes),
        ],
        updates: {_db.componentsTable},
      );
      return newComponentId;
    });
  }

  ComponentItem _mapComponent(QueryRow row) {
    return ComponentItem(
      id: row.read<int>('id'),
      bikeId: row.read<int>('bike_id'),
      type: row.read<String>('type'),
      brand: row.read<String>('brand'),
      model: row.read<String>('model'),
      expectedLifeKm: row.read<int>('expected_life_km'),
      installedAtBikeKm: row.read<int>('installed_at_bike_km'),
      price: row.read<double?>('price'),
      notes: row.read<String?>('notes'),
      isActive: row.read<int>('is_active') == 1,
    );
  }

  ComponentHistoryItem _mapHistory(QueryRow row) {
    return ComponentHistoryItem(
      id: row.read<int>('id'),
      componentId: row.read<int>('component_id'),
      bikeId: row.read<int>('bike_id'),
      removedAtBikeKm: row.read<int>('removed_at_bike_km'),
      removedAt: DateTime.parse(row.read<String>('removed_at')),
      price: row.read<double?>('price'),
      notes: row.read<String?>('notes'),
      componentBrand: row.read<String>('component_brand'),
      componentModel: row.read<String>('component_model'),
    );
  }
}
