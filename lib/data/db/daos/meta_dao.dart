import 'package:drift/drift.dart';
import '../app_database.dart';

class MetaDao {
  MetaDao(this._db);

  final AppDatabase _db;

  Future<String?> getValue(String key) async {
    final row = await _db.customSelect(
      'SELECT value FROM app_meta WHERE key = ?',
      variables: [Variable<String>(key)],
    ).getSingleOrNull();
    return row?.read<String?>('value');
  }

  Future<void> setValue(String key, String? value) async {
    await _db.customUpdate(
      'INSERT OR REPLACE INTO app_meta (key, value) VALUES (?, ?)',
      variables: [Variable<String>(key), Variable<String>(value)],
      updates: {_db.appMetaTable},
    );
  }
}
