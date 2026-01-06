import 'package:drift/drift.dart';
import '../app_database.dart';
import '../../models/wardrobe_models.dart';

class WardrobeDao {
  WardrobeDao(this._db);

  final AppDatabase _db;

  Stream<List<WardrobeItem>> watchByCategory(String category) {
    return _db
        .customSelect(
          'SELECT * FROM wardrobe_items WHERE category = ? ORDER BY id DESC',
          variables: [Variable<String>(category)],
          readsFrom: {_db.wardrobeTable},
        )
        .watch()
        .map((rows) => rows.map(_mapItem).toList());
  }

  Stream<List<WardrobeCategoryTotal>> watchCategoryTotals() {
    return _db
        .customSelect(
          '''
          SELECT category,
            SUM(COALESCE(price, 0.0) * quantity) AS total_value,
            SUM(quantity) AS total_items
          FROM wardrobe_items
          GROUP BY category
          ''',
          readsFrom: {_db.wardrobeTable},
        )
        .watch()
        .map((rows) => rows.map(_mapTotal).toList());
  }

  Future<int> insertItem({
    required String category,
    required String brand,
    required String model,
    required int quantity,
    double? price,
    String? notes,
  }) async {
    return _db.customInsert(
      '''
      INSERT INTO wardrobe_items (category, brand, model, quantity, price, notes)
      VALUES (?, ?, ?, ?, ?, ?)
      ''',
      variables: [
        Variable<String>(category),
        Variable<String>(brand),
        Variable<String>(model),
        Variable<int>(quantity),
        Variable<double>(price),
        Variable<String>(notes),
      ],
      updates: {_db.wardrobeTable},
    );
  }

  Future<void> updateItem({
    required int id,
    required String brand,
    required String model,
    required int quantity,
    double? price,
    String? notes,
  }) async {
    await _db.customUpdate(
      '''
      UPDATE wardrobe_items
      SET brand = ?, model = ?, quantity = ?, price = ?, notes = ?
      WHERE id = ?
      ''',
      variables: [
        Variable<String>(brand),
        Variable<String>(model),
        Variable<int>(quantity),
        Variable<double>(price),
        Variable<String>(notes),
        Variable<int>(id),
      ],
      updates: {_db.wardrobeTable},
    );
  }

  Future<void> deleteItem(int id) async {
    await _db.customUpdate(
      'DELETE FROM wardrobe_items WHERE id = ?',
      variables: [Variable<int>(id)],
      updates: {_db.wardrobeTable},
      updateKind: UpdateKind.delete,
    );
  }

  WardrobeItem _mapItem(QueryRow row) {
    return WardrobeItem(
      id: row.read<int>('id'),
      category: row.read<String>('category'),
      brand: row.read<String>('brand'),
      model: row.read<String>('model'),
      quantity: row.read<int>('quantity'),
      price: row.read<double?>('price'),
      notes: row.read<String?>('notes'),
    );
  }

  WardrobeCategoryTotal _mapTotal(QueryRow row) {
    return WardrobeCategoryTotal(
      category: row.read<String>('category'),
      totalValue: row.read<double>('total_value'),
      totalItems: row.read<int>('total_items'),
    );
  }
}
