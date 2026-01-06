import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppDatabase extends GeneratedDatabase {
  AppDatabase() : super(_openConnection());

  late final ResultSetImplementation bikesTable =
      _SimpleResultSet(this, 'bikes');
  late final ResultSetImplementation componentsTable =
      _SimpleResultSet(this, 'components');
  late final ResultSetImplementation componentHistoryTable =
      _SimpleResultSet(this, 'component_history');
  late final ResultSetImplementation wardrobeTable =
      _SimpleResultSet(this, 'wardrobe_items');
  late final ResultSetImplementation rideImportsTable =
      _SimpleResultSet(this, 'ride_imports');
  late final ResultSetImplementation appMetaTable =
      _SimpleResultSet(this, 'app_meta');

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'velpas.sqlite'));
      return NativeDatabase(file);
    });
  }

  @override
  int get schemaVersion => 1;

  @override
  Iterable<TableInfo<Table, dynamic>> get allTables => const [];

  Future<void> init() async {
    await customStatement('PRAGMA foreign_keys = ON');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS bikes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        purchase_price REAL,
        photo_path TEXT,
        manual_km INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
      );
    ''');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS components (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bike_id INTEGER NOT NULL,
        type TEXT NOT NULL,
        brand TEXT NOT NULL,
        model TEXT NOT NULL,
        expected_life_km INTEGER NOT NULL,
        installed_at_bike_km INTEGER NOT NULL,
        price REAL,
        notes TEXT,
        is_active INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (bike_id) REFERENCES bikes(id) ON DELETE CASCADE
      );
    ''');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS component_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        component_id INTEGER NOT NULL,
        bike_id INTEGER NOT NULL,
        removed_at_bike_km INTEGER NOT NULL,
        removed_at TEXT NOT NULL,
        price REAL,
        notes TEXT,
        FOREIGN KEY (bike_id) REFERENCES bikes(id) ON DELETE CASCADE
      );
    ''');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS wardrobe_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        brand TEXT NOT NULL,
        model TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL,
        notes TEXT
      );
    ''');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS ride_imports (
        id TEXT PRIMARY KEY,
        bike_id INTEGER NOT NULL,
        distance_km INTEGER NOT NULL,
        date_time TEXT NOT NULL,
        source TEXT NOT NULL,
        FOREIGN KEY (bike_id) REFERENCES bikes(id) ON DELETE CASCADE
      );
    ''');

    await customStatement('''
      CREATE TABLE IF NOT EXISTS app_meta (
        key TEXT PRIMARY KEY,
        value TEXT
      );
    ''');
  }
}

class _SimpleResultSet
    extends ResultSetImplementation<_SimpleResultSet, Map<String, dynamic>> {
  _SimpleResultSet(this.attachedDatabase, this._entityName);

  @override
  final DatabaseConnectionUser attachedDatabase;

  final String _entityName;

  @override
  String get entityName => _entityName;

  @override
  _SimpleResultSet get asDslTable => this;

  @override
  List<GeneratedColumn> get $columns => const [];

  @override
  Map<String, GeneratedColumn> get columnsByName => const {};

  @override
  FutureOr<Map<String, dynamic>> map(Map<String, dynamic> data,
      {String? tablePrefix}) async {
    return data;
  }
}
