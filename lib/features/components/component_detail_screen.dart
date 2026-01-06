import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/status_chip.dart';
import '../../app/widgets/v_card.dart';
import '../../app/widgets/wear_ring.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../../core/utils/component_utils.dart';
import '../../core/utils/formatters.dart';
import '../garage/garage_providers.dart';
import 'component_providers.dart';

class ComponentDetailScreen extends ConsumerWidget {
  const ComponentDetailScreen({super.key, required this.componentId});

  final int componentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final componentAsync = ref.watch(componentByIdProvider(componentId));

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.componentDetailTitle),
      ),
      body: componentAsync.when(
        data: (component) {
          if (component == null) {
            return Center(child: Text(context.l10n.componentNotFound));
          }
          final bikeAsync = ref.watch(bikeByIdProvider(component.bikeId));
          final historyAsync = ref.watch(
            componentHistoryByTypeProvider(
              ComponentHistoryQuery(
                bikeId: component.bikeId,
                type: component.type,
              ),
            ),
          );

          return bikeAsync.when(
            data: (bike) {
              if (bike == null) return Center(child: Text(context.l10n.bikeNotFound));
              final wear = ((bike.totalKm - component.installedAtBikeKm) /
                      component.expectedLifeKm)
                  .clamp(0.0, 1.0)
                  .toDouble();
              final wearPercent = (wear * 100).round();
              final status = WearStatus.statusFromWear(wear);

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  VCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            WearRing(
                              progress: wear,
                              size: 72,
                              center: Text('$wearPercent%'),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${component.brand} ${component.model}',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  StatusChip(
                                    label: _statusLabel(context, wear),
                                    level: status,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(context.l10n.kmSinceInstall(
                          Formatters.km(bike.totalKm - component.installedAtBikeKm),
                          Formatters.km(component.expectedLifeKm),
                        )),
                        const SizedBox(height: 8),
                        Text(context.l10n.installedAtKm(Formatters.km(component.installedAtBikeKm))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.push('/components/${component.id}/replace'),
                    child: Text(context.l10n.replaceComponent),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.l10n.replacementHistory,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  historyAsync.when(
                    data: (history) {
                      if (history.isEmpty) {
                        return Text(context.l10n.noHistory);
                      }
                      return Column(
                        children: history
                            .map(
                              (item) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(context.l10n.removedAtKm(
                                  Formatters.km(item.removedAtBikeKm),
                                )),
                                subtitle: Text(Formatters.dateTime(item.removedAt)),
                                trailing: item.price == null
                                    ? null
                                    : Text(Formatters.price(item.price!)),
                              ),
                            )
                            .toList(),
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => Text(context.l10n.noHistory),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  String _statusLabel(BuildContext context, double wear) {
    if (wear >= 1.0) return context.l10n.statusReplaceNow;
    if (wear >= 0.85) return context.l10n.statusReplace;
    if (wear >= 0.7) return context.l10n.statusWatch;
    return context.l10n.statusOk;
  }
}
