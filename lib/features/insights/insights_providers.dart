import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../data/models/bike_models.dart';

final bikesForInsightsProvider = StreamProvider<List<BikeWithStats>>((ref) {
  return ref.watch(bikeRepositoryProvider).watchBikes();
});

final componentTotalValueProvider = StreamProvider<double>((ref) {
  return ref.watch(componentRepositoryProvider).watchTotalValue();
});

final componentValueForBikeProvider = StreamProvider.family<double, int>((ref, bikeId) {
  return ref.watch(componentRepositoryProvider).watchTotalValueForBike(bikeId);
});
