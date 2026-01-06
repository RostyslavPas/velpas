import '../../data/db/daos/bike_dao.dart';
import '../../data/db/daos/component_dao.dart';
import '../../data/db/daos/meta_dao.dart';
import '../utils/component_utils.dart';

class SeedService {
  SeedService({
    required MetaDao metaDao,
    required BikeDao bikeDao,
    required ComponentDao componentDao,
  })  : _metaDao = metaDao,
        _bikeDao = bikeDao,
        _componentDao = componentDao;

  final MetaDao _metaDao;
  final BikeDao _bikeDao;
  final ComponentDao _componentDao;

  Future<void> seedIfNeeded() async {
    final seeded = await _metaDao.getValue('seeded');
    if (seeded == 'true') return;

    final bikeId = await _bikeDao.insertBike(
      name: 'Cervelo S5',
      purchasePrice: 7200,
      manualKm: 1200,
    );

    await _componentDao.insertComponent(
      bikeId: bikeId,
      type: ComponentType.chain.id,
      brand: 'SRAM',
      model: 'Red AXS chain',
      expectedLifeKm: ComponentDefaults.expectedLifeKm(ComponentType.chain),
      installedAtBikeKm: 0,
    );

    await _componentDao.insertComponent(
      bikeId: bikeId,
      type: ComponentType.cassette.id,
      brand: 'SRAM',
      model: 'Red cassette 10-33',
      expectedLifeKm: ComponentDefaults.expectedLifeKm(ComponentType.cassette),
      installedAtBikeKm: 0,
    );

    await _componentDao.insertComponent(
      bikeId: bikeId,
      type: ComponentType.tires.id,
      brand: 'Vittoria',
      model: 'Corsa Pro TR',
      expectedLifeKm: ComponentDefaults.expectedLifeKm(ComponentType.tires),
      installedAtBikeKm: 0,
    );

    await _componentDao.insertComponent(
      bikeId: bikeId,
      type: ComponentType.wheels.id,
      brand: 'Reserve',
      model: '53/64',
      expectedLifeKm: ComponentDefaults.expectedLifeKm(ComponentType.wheels),
      installedAtBikeKm: 0,
    );

    await _componentDao.insertComponent(
      bikeId: bikeId,
      type: ComponentType.powerMeter.id,
      brand: 'Quarq',
      model: 'Power meter',
      expectedLifeKm: ComponentDefaults.expectedLifeKm(ComponentType.powerMeter),
      installedAtBikeKm: 0,
    );

    await _metaDao.setValue('seeded', 'true');
  }
}
