import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/widgets/v_card.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../../core/utils/formatters.dart';
import '../wardrobe/wardrobe_providers.dart';
import 'insights_providers.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(bikesForInsightsProvider);
    final componentTotalAsync = ref.watch(componentTotalValueProvider);
    final wardrobeTotalsAsync = ref.watch(wardrobeTotalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.insightsTitle),
      ),
      body: bikesAsync.when(
        data: (bikes) {
          final totalKm = bikes.fold<int>(0, (sum, bike) => sum + bike.totalKm);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              VCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.l10n.totalBikeValue),
                    const SizedBox(height: 8),
                    componentTotalAsync.when(
                      data: (componentTotal) {
                        final purchaseTotal = bikes.fold<double>(
                          0,
                          (sum, bike) => sum + (bike.bike.purchasePrice ?? 0),
                        );
                        final totalValue = purchaseTotal + componentTotal;
                        return Text(
                          Formatters.price(totalValue),
                          style: Theme.of(context).textTheme.headlineSmall,
                        );
                      },
                      loading: () => const Text('...'),
                      error: (_, __) => const Text('...'),
                    ),
                    const SizedBox(height: 12),
                    wardrobeTotalsAsync.when(
                      data: (totals) {
                        final gearTotal = totals.fold<double>(
                          0,
                          (sum, item) => sum + item.totalValue,
                        );
                        return Text(
                          context.l10n.totalGearValueLabel(Formatters.price(gearTotal)),
                        );
                      },
                      loading: () => const Text('...'),
                      error: (_, __) => const Text('...'),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      context.l10n.totalKmAllBikes(
                        Formatters.km(totalKm),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.perBikeBreakdown,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              ...bikes.map((bike) => _BikeBreakdownCard(bikeId: bike.bike.id, bikeName: bike.bike.name, bikeKm: bike.totalKm, purchasePrice: bike.bike.purchasePrice)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _BikeBreakdownCard extends ConsumerWidget {
  const _BikeBreakdownCard({
    required this.bikeId,
    required this.bikeName,
    required this.bikeKm,
    required this.purchasePrice,
  });

  final int bikeId;
  final String bikeName;
  final int bikeKm;
  final double? purchasePrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final componentValueAsync = ref.watch(componentValueForBikeProvider(bikeId));

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: VCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bikeName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(context.l10n.totalKmLabel(Formatters.km(bikeKm))),
            const SizedBox(height: 8),
            componentValueAsync.when(
              data: (componentValue) {
                final total = (purchasePrice ?? 0) + componentValue;
                return Text(context.l10n.bikeValueLabel(Formatters.price(total)));
              },
              loading: () => const Text('...'),
              error: (_, __) => const Text('...'),
            ),
          ],
        ),
      ),
    );
  }
}
