import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/status_chip.dart';
import '../../app/widgets/v_card.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../../core/providers.dart';
import '../../core/services/strava_service.dart';
import '../../core/utils/component_utils.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/component_models.dart';
import '../../data/models/bike_models.dart';
import '../settings/settings_controller.dart';
import 'home_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(bikesStreamProvider);
    final settingsAsync = ref.watch(settingsControllerProvider);
    final primaryBikeId = settingsAsync.maybeWhen(
      data: (settings) => settings.primaryBikeId,
      orElse: () => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.homeTitle),
        actions: [
          IconButton(
            onPressed: () => _showReplacePicker(context),
            icon: const Icon(Icons.swap_horiz),
            tooltip: context.l10n.addReplacement,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.lastSyncTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                settingsAsync.when(
                  data: (settings) {
                    final lastSync = settings.lastSync;
                    final text = lastSync == null
                        ? context.l10n.lastSyncNever
                        : Formatters.dateTime(lastSync);
                    return Text(text);
                  },
                  loading: () => const Text('...'),
                  error: (_, __) => Text(context.l10n.lastSyncNever),
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final primary = ElevatedButton.icon(
                      onPressed: () => _showReplacePicker(context),
                      icon: const Icon(Icons.build),
                      label: Text(
                        context.l10n.addReplacement,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                    final secondary = OutlinedButton.icon(
                      onPressed: () => _handleSync(context, ref),
                      icon: const Icon(Icons.sync),
                      label: Text(
                        context.l10n.syncStrava,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                    if (constraints.maxWidth < 360) {
                      return Column(
                        children: [
                          SizedBox(width: double.infinity, child: primary),
                          const SizedBox(height: 12),
                          SizedBox(width: double.infinity, child: secondary),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(child: primary),
                        const SizedBox(width: 12),
                        Expanded(child: secondary),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.yourBikes,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          bikesAsync.when(
            data: (bikes) {
              if (bikes.isEmpty) {
                return VCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.emptyGarageTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(context.l10n.emptyGarageSubtitle),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.push('/garage/add'),
                        child: Text(context.l10n.addBike),
                      ),
                    ],
                  ),
                );
              }

              var ordered = bikes;
              final index = bikes.indexWhere(
                (bike) => bike.bike.id == primaryBikeId,
              );
              if (index > 0) {
                final mutable = [...bikes];
                final primary = mutable.removeAt(index);
                mutable.insert(0, primary);
                ordered = mutable;
              }

              return Column(
                children: ordered
                    .map((bike) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _BikeCard(bike: bike),
                        ))
                    .toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('Error: $error'),
          ),
        ],
      ),
    );
  }

  Future<void> _showReplacePicker(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        return _ReplacePickerSheet();
      },
    );
  }

  Future<void> _handleSync(BuildContext context, WidgetRef ref) async {
    final settingsAsync = ref.read(settingsControllerProvider);
    if (settingsAsync.value?.isPro != true) {
      if (context.mounted) {
        context.push('/paywall');
      }
      return;
    }
    if (settingsAsync.value?.stravaConnected != true) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.stravaConnectRequired)),
        );
      }
      return;
    }

    final bikes = await ref.read(bikesStreamProvider.future);
    if (bikes.isEmpty) return;

    final selectedBikeId = await _selectBike(context, bikes);
    if (selectedBikeId == null) return;

    try {
      final service = ref.read(stravaServiceProvider);
      final result = await service.syncBike(selectedBikeId);
      await ref.read(settingsControllerProvider.notifier).setLastSync(DateTime.now());

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.syncSuccess(result.added, result.summary()))),
        );
      }
    } on StravaAuthException catch (error) {
      await ref.read(settingsControllerProvider.notifier).disconnectStrava();
      if (context.mounted) {
        final message = error.error == StravaAuthError.expired
            ? context.l10n.stravaSessionExpired
            : context.l10n.stravaConnectRequired;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } on Exception {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.stravaSyncFailed)),
        );
      }
    }
  }

  Future<int?> _selectBike(BuildContext context, List<BikeWithStats> bikes) async {
    if (bikes.length == 1) return bikes.first.bike.id;
    return showDialog<int>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(context.l10n.selectBike),
          children: bikes
              .map(
                (bike) => SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(bike.bike.id),
                  child: Text(bike.bike.name),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _BikeCard extends ConsumerWidget {
  const _BikeCard({required this.bike});

  final BikeWithStats bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final componentsAsync = ref.watch(componentsByBikeProvider(bike.bike.id));

    return VCard(
      onTap: () => context.push('/garage/${bike.bike.id}'),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bike.bike.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.totalKmLabel(Formatters.km(bike.totalKm)),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            componentsAsync.when(
              data: (components) {
                if (components.isEmpty) {
                  return Text(context.l10n.noComponentsYet);
                }
                final top = _topWear(components, bike.totalKm);
                final wearPercent = (top.wear * 100).round();
                return Row(
                  children: [
                    Flexible(
                      child: StatusChip(
                        label: _statusLabel(context, top.wear),
                        level: WearStatus.statusFromWear(top.wear),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        context.l10n.topAlertLabel(top.component.brand, top.component.model, wearPercent),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => Text(context.l10n.noComponentsYet),
            ),
          ],
        ),
      ),
    );
  }

  _WearInfo _topWear(List<ComponentItem> components, int bikeTotalKm) {
    double maxWear = 0;
    ComponentItem maxComponent = components.first;
    for (final component in components) {
      final wear = ((bikeTotalKm - component.installedAtBikeKm) /
              component.expectedLifeKm)
          .clamp(0.0, 1.0)
          .toDouble();
      if (wear >= maxWear) {
        maxWear = wear;
        maxComponent = component;
      }
    }
    return _WearInfo(component: maxComponent, wear: maxWear);
  }

  String _statusLabel(BuildContext context, double wear) {
    if (wear >= 1.0) return context.l10n.statusReplaceNow;
    if (wear >= 0.85) return context.l10n.statusReplace;
    if (wear >= 0.7) return context.l10n.statusWatch;
    return context.l10n.statusOk;
  }
}

class _WearInfo {
  _WearInfo({required this.component, required this.wear});

  final ComponentItem component;
  final double wear;
}

class _ReplacePickerSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<_ReplacePickerSheet> createState() => _ReplacePickerSheetState();
}

class _ReplacePickerSheetState extends ConsumerState<_ReplacePickerSheet> {
  int? _selectedBikeId;

  @override
  Widget build(BuildContext context) {
    final bikesAsync = ref.watch(bikesStreamProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: bikesAsync.when(
                data: (bikes) {
                  if (bikes.isEmpty) {
                    return Text(context.l10n.emptyGarageTitle);
                  }

                  final selectedBike = bikes.firstWhere(
                    (bike) => bike.bike.id == _selectedBikeId,
                    orElse: () => bikes.first,
                  );
                  _selectedBikeId ??= selectedBike.bike.id;

                  final componentsAsync =
                      ref.watch(componentsByBikeProvider(selectedBike.bike.id));

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.selectBike,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: bikes
                            .map(
                              (bike) => ChoiceChip(
                                label: Text(bike.bike.name),
                                selected: bike.bike.id == _selectedBikeId,
                                onSelected: (_) {
                                  setState(() {
                                    _selectedBikeId = bike.bike.id;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        context.l10n.selectComponent,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      componentsAsync.when(
                        data: (components) {
                          if (components.isEmpty) {
                            return Text(context.l10n.noComponentsYet);
                          }
                          return Column(
                            children: components
                                .map(
                                  (component) => ListTile(
                                    title: Text('${component.brand} ${component.model}'),
                                    subtitle: Text(component.type),
                                    trailing: const Icon(Icons.chevron_right),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      context.push('/components/${component.id}/replace');
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        },
                        loading: () => const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(),
                        ),
                        error: (_, __) => Text(context.l10n.noComponentsYet),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Text('Error: $error'),
              ),
            ),
          );
        },
      ),
    );
  }
}
