import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../data/models/bike_models.dart';
import '../../data/models/component_models.dart';

final garageBikesProvider = StreamProvider<List<BikeWithStats>>((ref) {
  return ref.watch(bikeRepositoryProvider).watchBikes();
});

final bikeByIdProvider = StreamProvider.family<BikeWithStats?, int>((ref, id) {
  return ref.watch(bikeRepositoryProvider).watchBike(id);
});

final componentsForBikeProvider = StreamProvider.family<List<ComponentItem>, int>(
  (ref, bikeId) {
    return ref.watch(componentRepositoryProvider).watchActiveForBike(bikeId);
  },
);
