import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/status_chip.dart';
import '../../app/widgets/v_card.dart';
import '../../app/widgets/wear_ring.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../../core/providers.dart';
import '../../core/utils/component_utils.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/component_models.dart';
import '../../data/models/bike_models.dart';
import '../garage/garage_providers.dart';
import 'component_providers.dart';
import '../settings/settings_controller.dart';

class ComponentDetailScreen extends ConsumerWidget {
  const ComponentDetailScreen({super.key, required this.componentId});

  final int componentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final componentAsync = ref.watch(componentByIdProvider(componentId));
    final settings = ref.watch(settingsControllerProvider).value;
    final canReplace = settings != null && (settings.isPro || !settings.hadPro);
    final currencyCode = ref.watch(settingsControllerProvider).maybeWhen(
          data: (settings) => settings.currencyCode,
          orElse: () => 'USD',
        );

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
              final kmSinceInstall =
                  max(0, bike.totalKm - component.installedAtBikeKm).toInt();
              final wear = (kmSinceInstall / component.expectedLifeKm)
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
                        Text(
                          context.l10n.kmSinceInstall(
                            Formatters.km(kmSinceInstall),
                            Formatters.km(component.expectedLifeKm),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: canReplace
                      ? () => context.push('/components/${component.id}/replace')
                      : null,
                  child: Text(context.l10n.replaceComponent),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => _showAdjustComponentKmSheet(context, ref, component, bike),
                  child: Text(context.l10n.adjustComponentKm),
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
                              (item) {
                                final name = [
                                  item.componentBrand,
                                  item.componentModel,
                                ].where((value) => value != null && value!.isNotEmpty).join(' ');
                                final titleText = name.isEmpty
                                    ? context.l10n.removedAtKm(
                                        Formatters.km(item.removedAtBikeKm),
                                      )
                                    : name;
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(titleText),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (name.isNotEmpty)
                                        Text(
                                          context.l10n.removedAtKm(
                                            Formatters.km(item.removedAtBikeKm),
                                          ),
                                        ),
                                      Text(Formatters.dateTime(item.removedAt)),
                                    ],
                                  ),
                                  trailing: item.price == null
                                      ? null
                                      : Text(
                                          Formatters.price(
                                            item.price!,
                                            currencyCode: currencyCode,
                                          ),
                                        ),
                                );
                              },
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

  void _showAdjustComponentKmSheet(
    BuildContext context,
    WidgetRef ref,
    ComponentItem component,
    BikeWithStats bike,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        final kmSinceInstall =
            max(0, bike.totalKm - component.installedAtBikeKm).toInt();
        final controller = TextEditingController(text: kmSinceInstall.toString());
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                context.l10n.adjustComponentKm,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(labelText: context.l10n.componentKmLabel),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final km = _parseInt(controller.text);
                  if (km == null) return;
                  final installedAt = bike.totalKm - km;
                  await ref.read(componentRepositoryProvider).updateInstalledAtBikeKm(
                        id: component.id,
                        installedAtBikeKm: installedAt,
                      );
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(context.l10n.saveLabel),
              ),
            ],
          ),
        );
      },
    );
  }
}

int? _parseInt(String value) {
  final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
  if (cleaned.isEmpty) return null;
  return int.tryParse(cleaned);
}
