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
    if (seeded == 'true') {
      await _removeSampleBikeIfPresent();
      return;
    }

    await _metaDao.setValue('seeded', 'true');
  }

  Future<void> _removeSampleBikeIfPresent() async {
    final bikes = await _bikeDao.fetchAllBikes();
    const sampleModels = [
      'Red AXS chain',
      'Red cassette 10-33',
      'Corsa Pro TR',
      '53/64',
      'Power meter',
    ];
    for (final bike in bikes) {
      if (bike.name != 'Cervelo S5' ||
          bike.manualKm != 1200 ||
          bike.stravaGearId != null) {
        continue;
      }
      final matches =
          await _componentDao.countComponentsByBikeModels(bike.id, sampleModels);
      if (matches >= sampleModels.length) {
        await _bikeDao.deleteBike(bike.id);
        break;
      }
    }
  }
}
