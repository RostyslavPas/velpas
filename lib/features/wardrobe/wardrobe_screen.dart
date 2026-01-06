import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/v_card.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/wardrobe_models.dart';
import 'wardrobe_categories.dart';
import 'wardrobe_providers.dart';

class WardrobeScreen extends ConsumerWidget {
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalsAsync = ref.watch(wardrobeTotalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.wardrobeTitle),
      ),
      body: totalsAsync.when(
        data: (totals) {
          final totalValue = totals.fold<double>(
            0,
            (sum, item) => sum + item.totalValue,
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              VCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.totalGearValue,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      Formatters.price(totalValue),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: wardrobeCategories.map((category) {
                  final total = totals.firstWhere(
                    (item) => item.category == category.id,
                    orElse: () => WardrobeCategoryTotal(
                      category: category.id,
                      totalItems: 0,
                      totalValue: 0,
                    ),
                  );
                  return VCard(
                    onTap: () => context.push('/wardrobe/category/${category.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _categoryLabel(context, category.id),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          Formatters.price(total.totalValue),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(context.l10n.itemsCount(total.totalItems)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  String _categoryLabel(BuildContext context, String id) {
    switch (id) {
      case 'helmets':
        return context.l10n.categoryHelmets;
      case 'glasses':
        return context.l10n.categoryGlasses;
      case 'jerseys':
        return context.l10n.categoryJerseys;
      case 'bibs':
        return context.l10n.categoryBibs;
      case 'shoes':
        return context.l10n.categoryShoes;
      case 'gloves':
        return context.l10n.categoryGloves;
      case 'jackets':
        return context.l10n.categoryJackets;
      case 'accessories':
        return context.l10n.categoryAccessories;
      default:
        return id;
    }
  }
}
