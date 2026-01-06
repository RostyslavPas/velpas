import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../data/models/bike_models.dart';
import '../../data/models/component_models.dart';

final bikesStreamProvider = StreamProvider<List<BikeWithStats>>((ref) {
  return ref.watch(bikeRepositoryProvider).watchBikes();
});

final componentsByBikeProvider = StreamProvider.family<List<ComponentItem>, int>(
  (ref, bikeId) {
    return ref.watch(componentRepositoryProvider).watchActiveForBike(bikeId);
  },
);
