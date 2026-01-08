import '../db/daos/component_dao.dart';
import '../models/component_models.dart';

class ComponentRepository {
  ComponentRepository(this._componentDao);

  final ComponentDao _componentDao;

  Stream<List<ComponentItem>> watchActiveForBike(int bikeId) {
    return _componentDao.watchActiveByBike(bikeId);
  }

  Stream<ComponentItem?> watchComponent(int id) {
    return _componentDao.watchById(id);
  }

  Stream<List<ComponentHistoryItem>> watchHistory(int componentId) {
    return _componentDao.watchHistory(componentId);
  }

  Stream<List<ComponentHistoryItem>> watchHistoryForBikeType({
    required int bikeId,
    required String type,
  }) {
    return _componentDao.watchHistoryForBikeType(bikeId: bikeId, type: type);
  }

  Stream<double> watchTotalValue() => _componentDao.watchTotalValue();

  Stream<double> watchTotalValueForBike(int bikeId) {
    return _componentDao.watchTotalValueForBike(bikeId);
  }

  Future<List<ComponentWearSnapshot>> fetchActiveWearSnapshots({int? bikeId}) {
    return _componentDao.fetchActiveWearSnapshots(bikeId: bikeId);
  }

  Future<int> addComponent({
    required int bikeId,
    required String type,
    required String brand,
    required String model,
    required int expectedLifeKm,
    required int installedAtBikeKm,
    double? price,
    String? notes,
  }) {
    return _componentDao.insertComponent(
      bikeId: bikeId,
      type: type,
      brand: brand,
      model: model,
      expectedLifeKm: expectedLifeKm,
      installedAtBikeKm: installedAtBikeKm,
      price: price,
      notes: notes,
    );
  }

  Future<void> updateComponent({
    required int id,
    required String brand,
    required String model,
    required int expectedLifeKm,
    double? price,
    String? notes,
  }) {
    return _componentDao.updateComponent(
      id: id,
      brand: brand,
      model: model,
      expectedLifeKm: expectedLifeKm,
      price: price,
      notes: notes,
    );
  }

  Future<void> updateInstalledAtBikeKm({
    required int id,
    required int installedAtBikeKm,
  }) {
    return _componentDao.updateInstalledAtBikeKm(
      id: id,
      installedAtBikeKm: installedAtBikeKm,
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
  }) {
    return _componentDao.replaceComponent(
      oldComponent: oldComponent,
      removedAtBikeKm: removedAtBikeKm,
      removedAt: removedAt,
      newBrand: newBrand,
      newModel: newModel,
      expectedLifeKm: expectedLifeKm,
      newPrice: newPrice,
      newNotes: newNotes,
    );
  }
}
