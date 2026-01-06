import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/v_card.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../../core/utils/formatters.dart';
import 'garage_providers.dart';

class GarageScreen extends ConsumerWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(garageBikesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.garageTitle),
        actions: [
          IconButton(
            onPressed: () => context.push('/garage/add'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: bikesAsync.when(
        data: (bikes) {
          if (bikes.isEmpty) {
            return Center(
              child: Text(context.l10n.emptyGarageTitle),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bikes.length,
            itemBuilder: (context, index) {
              final bike = bikes[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: VCard(
                  onTap: () => context.push('/garage/${bike.bike.id}'),
                  child: Row(
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.directions_bike),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bike.bike.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              context.l10n.totalKmLabel(Formatters.km(bike.totalKm)),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
