import '../db/daos/wardrobe_dao.dart';
import '../models/wardrobe_models.dart';

class WardrobeRepository {
  WardrobeRepository(this._wardrobeDao);

  final WardrobeDao _wardrobeDao;

  Stream<List<WardrobeItem>> watchItems(String category) {
    return _wardrobeDao.watchByCategory(category);
  }

  Stream<List<WardrobeCategoryTotal>> watchCategoryTotals() {
    return _wardrobeDao.watchCategoryTotals();
  }

  Future<int> addItem({
    required String category,
    required String brand,
    required String model,
    required int quantity,
    double? price,
    String? notes,
  }) {
    return _wardrobeDao.insertItem(
      category: category,
      brand: brand,
      model: model,
      quantity: quantity,
      price: price,
      notes: notes,
    );
  }

  Future<void> updateItem({
    required int id,
    required String brand,
    required String model,
    required int quantity,
    double? price,
    String? notes,
  }) {
    return _wardrobeDao.updateItem(
      id: id,
      brand: brand,
      model: model,
      quantity: quantity,
      price: price,
      notes: notes,
    );
  }

  Future<void> deleteItem(int id) => _wardrobeDao.deleteItem(id);
}
