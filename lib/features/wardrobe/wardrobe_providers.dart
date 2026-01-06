import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../data/models/wardrobe_models.dart';

final wardrobeTotalsProvider = StreamProvider<List<WardrobeCategoryTotal>>((ref) {
  return ref.watch(wardrobeRepositoryProvider).watchCategoryTotals();
});

final wardrobeItemsProvider = StreamProvider.family<List<WardrobeItem>, String>(
  (ref, category) {
    return ref.watch(wardrobeRepositoryProvider).watchItems(category);
  },
);
