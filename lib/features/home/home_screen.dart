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

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _checkedAlerts = false;
  bool _isSyncing = false;

  @override
  Widget build(BuildContext context) {
    final bikesAsync = ref.watch(bikesStreamProvider);
    final settingsAsync = ref.watch(settingsControllerProvider);
    final settings = settingsAsync.value;
    final isLimited = settings != null && !settings.isPro;
    settingsAsync.whenData((settings) {
      if (_checkedAlerts || !settings.isPro) return;
      _checkedAlerts = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref.read(maintenanceAlertServiceProvider).checkAlerts(context);
      });
    });
    final primaryBikeId = settings?.primaryBikeId;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.homeTitle),
        actions: [
          IconButton(
            onPressed: settings?.isPro == true
                ? () => _showAlertsSheet(context)
                : () => context.push('/paywall'),
            icon: const Icon(Icons.notifications_active),
            tooltip: context.l10n.alertsTitle,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VCard(
            child: Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: 0.08,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Transform.translate(
                          offset: const Offset(0, -6),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Image.asset(
                              'assets/app_icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    settingsAsync.when(
                      data: (settings) {
                        final lastSync = settings.lastSync;
                        final lastSyncText = lastSync == null
                            ? context.l10n.lastSyncNever
                            : Formatters.dateTime(lastSync);
                        final isPro = settings.isPro;
                        final statusText = isPro
                            ? (settings.stravaConnected
                                ? context.l10n.connectedStatus
                                : context.l10n.disconnectedStatus)
                            : context.l10n.proOnlyStatus;
                        final showStatus = !isPro || !settings.stravaConnected;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final lastSyncBlock = Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      context.l10n.lastSyncTitle,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(lastSyncText),
                                  ],
                                );
                                final stravaBlock = Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (showStatus) Text(statusText),
                                  ],
                                );
                                if (constraints.maxWidth < 360) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      lastSyncBlock,
                                      const SizedBox(height: 12),
                                      stravaBlock,
                                    ],
                                  );
                                }
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: lastSyncBlock),
                                    const SizedBox(width: 16),
                                    Expanded(child: stravaBlock),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            const Divider(height: 1),
                            const SizedBox(height: 12),
                            if (!isPro)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => context.push('/paywall'),
                                  child: Text(context.l10n.connectStrava),
                                ),
                              )
                            else if (!settings.stravaConnected)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:
                                      _isSyncing ? null : () => _connectStrava(context),
                                  child: Text(context.l10n.connectStrava),
                                ),
                              )
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed:
                                        _isSyncing ? null : () => _handleSync(context),
                                    icon: _isSyncing
                                        ? const SizedBox(
                                            height: 16,
                                            width: 16,
                                            child:
                                                CircularProgressIndicator(strokeWidth: 2),
                                          )
                                        : const Icon(Icons.sync),
                                    label: Text(
                                      _isSyncing
                                          ? context.l10n.syncingStrava
                                          : context.l10n.syncStrava,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  OutlinedButton(
                                    onPressed: _isSyncing ? null : _disconnectStrava,
                                    child: Text(context.l10n.disconnectStrava),
                                  ),
                                ],
                              ),
                          ],
                        );
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: LinearProgressIndicator(),
                      ),
                      error: (_, __) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.lastSyncTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(context.l10n.lastSyncNever),
                          const SizedBox(height: 12),
                          Text(context.l10n.disconnectedStatus),
                        ],
                      ),
                    ),
                  ],
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
                        onPressed: settings == null
                            ? null
                            : () {
                                if (settings.isPro || !settings.hadPro) {
                                  context.push('/garage/add');
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(context.l10n.proRequiredMessage)),
                                );
                              },
                        child: Text(context.l10n.addBike),
                      ),
                    ],
                  ),
                );
              }

              var ordered = bikes;
              final effectivePrimaryId =
                  primaryBikeId ?? (bikes.isNotEmpty ? bikes.first.bike.id : null);
              final index = bikes.indexWhere(
                (bike) => bike.bike.id == effectivePrimaryId,
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
                          child: _BikeCard(
                            bike: bike,
                            isLocked: isLimited &&
                                effectivePrimaryId != null &&
                                bike.bike.id != effectivePrimaryId,
                          ),
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
    final settings = ref.read(settingsControllerProvider).value;
    if (settings != null && !settings.isPro && settings.hadPro) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.proRequiredMessage)),
        );
      }
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        return _ReplacePickerSheet();
      },
    );
  }

  Future<void> _showAlertsSheet(BuildContext context) async {
    final settings = ref.read(settingsControllerProvider).value;
    if (settings?.isPro != true) {
      if (context.mounted) {
        context.push('/paywall');
      }
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<_AlertItem>>(
            future: _loadAlerts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text(context.l10n.noComponentsYet);
              }
              final alerts = snapshot.data ?? [];
              if (alerts.isEmpty) {
                return Center(child: Text(context.l10n.alertsEmpty));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.alertsTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemCount: alerts.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final alert = alerts[index];
                        final component = alert.snapshot.component;
                        final wearPercent = (alert.wear * 100).round();
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('${component.brand} ${component.model}'),
                          subtitle: Text(
                            '${alert.snapshot.bikeName} • $wearPercent%',
                          ),
                          trailing: StatusChip(
                            label: _wearStatusLabel(context, alert.wear),
                            level: WearStatus.statusFromWear(alert.wear),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            context.push('/components/${component.id}');
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }


  Future<List<_AlertItem>> _loadAlerts() async {
    final snapshots = await ref.read(componentRepositoryProvider).fetchActiveWearSnapshots();
    final alerts = <_AlertItem>[];
    for (final snapshot in snapshots) {
      final expected = snapshot.component.expectedLifeKm;
      if (expected <= 0) continue;
      final wear = ((snapshot.bikeKm - snapshot.component.installedAtBikeKm) / expected)
          .clamp(0.0, 1.0)
          .toDouble();
      if (wear >= 0.7) {
        alerts.add(_AlertItem(snapshot: snapshot, wear: wear));
      }
    }
    alerts.sort((a, b) => b.wear.compareTo(a.wear));
    return alerts;
  }

  Future<void> _handleSync(BuildContext context) async {
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

    final service = ref.read(stravaServiceProvider);
    BikeImportResult? importResult;
    if (mounted) {
      setState(() => _isSyncing = true);
    }
    try {
      importResult = await service.importBikes();
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
      return;
    } on Exception {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.stravaImportFailed)),
        );
      }
      return;
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }

    final bikes = await ref.read(bikesStreamProvider.future);
    if (bikes.isEmpty) {
      if (context.mounted &&
          importResult != null &&
          (importResult.added > 0 || importResult.linked > 0)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.l10n.stravaImportResult(
                importResult.added,
                importResult.linked,
                importResult.skipped,
              ),
            ),
          ),
        );
      }
      return;
    }

    final selectedBikeId = await _selectBike(context, bikes);
    if (selectedBikeId == null) return;

    try {
      if (mounted) {
        setState(() => _isSyncing = true);
      }
      final result = await service.syncBike(selectedBikeId);
      await ref.read(settingsControllerProvider.notifier).setLastSync(DateTime.now());
      await ref
          .read(maintenanceAlertServiceProvider)
          .checkAlerts(context, bikeId: selectedBikeId);

      if (context.mounted) {
        if (importResult != null &&
            (importResult.added > 0 || importResult.linked > 0)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.l10n.stravaImportResult(
                  importResult.added,
                  importResult.linked,
                  importResult.skipped,
                ),
              ),
            ),
          );
        }
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
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }

  Future<void> _connectStrava(BuildContext context) async {
    try {
      await ref.read(stravaAuthServiceProvider).startAuth();
    } on Exception {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.stravaAuthFailed)),
        );
      }
    }
  }

  Future<void> _disconnectStrava() async {
    await ref.read(settingsControllerProvider.notifier).disconnectStrava();
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
  const _BikeCard({required this.bike, required this.isLocked});

  final BikeWithStats bike;
  final bool isLocked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final componentsAsync = ref.watch(componentsByBikeProvider(bike.bike.id));

    return Opacity(
      opacity: isLocked ? 0.5 : 1,
      child: VCard(
        onTap: isLocked ? null : () => context.push('/garage/${bike.bike.id}'),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      bike.bike.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  if (isLocked) const Icon(Icons.lock, size: 18),
                ],
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
                          context.l10n
                              .topAlertLabel(top.component.brand, top.component.model, wearPercent),
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
    return _wearStatusLabel(context, wear);
  }
}

class _WearInfo {
  _WearInfo({required this.component, required this.wear});

  final ComponentItem component;
  final double wear;
}

class _AlertItem {
  _AlertItem({required this.snapshot, required this.wear});

  final ComponentWearSnapshot snapshot;
  final double wear;
}

String _wearStatusLabel(BuildContext context, double wear) {
  if (wear >= 1.0) return context.l10n.statusReplaceNow;
  if (wear >= 0.85) return context.l10n.statusReplace;
  if (wear >= 0.7) return context.l10n.statusWatch;
  return context.l10n.statusOk;
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
    final settings = ref.watch(settingsControllerProvider).value;

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

                  final isLimited = settings != null && !settings.isPro;
                  final primaryBikeId =
                      settings?.primaryBikeId ?? bikes.first.bike.id;
                  final availableBikes = isLimited
                      ? bikes.where((bike) => bike.bike.id == primaryBikeId).toList()
                      : bikes;
                  final selectedBike = availableBikes.firstWhere(
                    (bike) => bike.bike.id == _selectedBikeId,
                    orElse: () => availableBikes.first,
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
                        children: availableBikes
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
