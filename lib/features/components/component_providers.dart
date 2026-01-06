import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../data/models/component_models.dart';

final componentByIdProvider = StreamProvider.family<ComponentItem?, int>((ref, id) {
  return ref.watch(componentRepositoryProvider).watchComponent(id);
});

final componentHistoryProvider = StreamProvider.family<List<ComponentHistoryItem>, int>(
  (ref, componentId) {
    return ref.watch(componentRepositoryProvider).watchHistory(componentId);
  },
);

class ComponentHistoryQuery {
  const ComponentHistoryQuery({required this.bikeId, required this.type});

  final int bikeId;
  final String type;

  @override
  bool operator ==(Object other) {
    return other is ComponentHistoryQuery &&
        other.bikeId == bikeId &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hash(bikeId, type);
}

final componentHistoryByTypeProvider =
    StreamProvider.family<List<ComponentHistoryItem>, ComponentHistoryQuery>(
  (ref, query) {
    return ref
        .watch(componentRepositoryProvider)
        .watchHistoryForBikeType(bikeId: query.bikeId, type: query.type);
  },
);
