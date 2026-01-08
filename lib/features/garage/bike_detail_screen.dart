import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
import 'garage_providers.dart';
import '../settings/settings_controller.dart';

class BikeDetailScreen extends ConsumerWidget {
  const BikeDetailScreen({super.key, required this.bikeId});

  final int bikeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikeAsync = ref.watch(bikeByIdProvider(bikeId));
    final componentsAsync = ref.watch(componentsForBikeProvider(bikeId));
    final settingsAsync = ref.watch(settingsControllerProvider);
    final currencyCode = ref.watch(settingsControllerProvider).maybeWhen(
          data: (settings) => settings.currencyCode,
          orElse: () => 'USD',
        );
    final settings = settingsAsync.value;
    final componentCount =
        componentsAsync.maybeWhen(data: (components) => components.length, orElse: () => -1);
    final hasComponentCount = componentCount >= 0;
    final isCancelled = settings != null && !settings.isPro && settings.hadPro;
    final isFree = settings != null && !settings.isPro && !settings.hadPro;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.bikeDetailTitle),
        actions: [
          IconButton(
            onPressed: () => context.push('/garage/$bikeId/edit'),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: bikeAsync.when(
        data: (bike) {
          if (bike == null) {
            return Center(child: Text(context.l10n.bikeNotFound));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _BikeHeader(
                bikeName: bike.bike.name,
                totalKm: bike.totalKm,
                price: bike.bike.purchasePrice,
                photoPath: bike.bike.photoPath,
                currencyCode: currencyCode,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.componentsTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: settings == null || !hasComponentCount
                        ? null
                        : () {
                            if (isCancelled) {
                              _showProRequired(context);
                              return;
                            }
                            if (isFree && componentCount >= 5) {
                              _showProRequired(context);
                              return;
                            }
                            _showAddComponentSheet(context, bike.totalKm, componentCount);
                          },
                    icon: const Icon(Icons.add),
                    label: Text(context.l10n.addComponent),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              componentsAsync.when(
                data: (components) {
                  if (components.isEmpty) {
                    return Text(context.l10n.noComponentsYet);
                  }
                  final grouped = _groupComponents(components);
                  return Column(
                    children: grouped.entries.map((entry) {
                      final category = entry.key;
                      final items = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _categoryLabel(context, category),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1.2,
                              children: items
                                  .map(
                                    (component) => _ComponentTile(
                                      component: component,
                                      bikeTotalKm: bike.totalKm,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => Text(context.l10n.noComponentsYet),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Map<ComponentCategory, List<ComponentItem>> _groupComponents(List<ComponentItem> items) {
    final map = <ComponentCategory, List<ComponentItem>>{};
    for (final item in items) {
      final type = ComponentType.fromId(item.type);
      final category = categoryFor(type);
      map.putIfAbsent(category, () => []).add(item);
    }
    return map;
  }

  String _categoryLabel(BuildContext context, ComponentCategory category) {
    switch (category) {
      case ComponentCategory.drivetrain:
        return context.l10n.categoryDrivetrain;
      case ComponentCategory.wheelsTires:
        return context.l10n.categoryWheelsTires;
      case ComponentCategory.brakes:
        return context.l10n.categoryBrakes;
      case ComponentCategory.cockpit:
        return context.l10n.categoryCockpit;
      case ComponentCategory.other:
        return context.l10n.categoryOther;
    }
  }

  void _showAddComponentSheet(
    BuildContext context,
    int bikeTotalKm,
    int currentCount,
  ) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        return _AddComponentSheet(
          bikeId: bikeId,
          bikeTotalKm: bikeTotalKm,
          currentCount: currentCount,
        );
      },
    );
  }
}

class _BikeHeader extends StatelessWidget {
  const _BikeHeader({
    required this.bikeName,
    required this.totalKm,
    required this.price,
    this.photoPath,
    required this.currencyCode,
  });

  final String bikeName;
  final int totalKm;
  final double? price;
  final String? photoPath;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final file = (!kIsWeb && photoPath != null) ? File(photoPath!) : null;
    final hasPhoto = file != null && file.existsSync();
    if (!hasPhoto) {
      return VCard(
        child: Row(
          children: [
            Container(
              height: 88,
              width: 88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black26,
              ),
              child: const Icon(Icons.directions_bike, size: 40),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bikeName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Text(context.l10n.totalKmLabel(Formatters.km(totalKm))),
                  if (price != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      context.l10n.purchasePriceLabel(
                        Formatters.price(price!, currencyCode: currencyCode),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    }

    return VCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.file(
                file,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bikeName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(context.l10n.totalKmLabel(Formatters.km(totalKm))),
                if (price != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.purchasePriceLabel(
                      Formatters.price(price!, currencyCode: currencyCode),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComponentTile extends StatelessWidget {
  const _ComponentTile({
    required this.component,
    required this.bikeTotalKm,
  });

  final ComponentItem component;
  final int bikeTotalKm;

  @override
  Widget build(BuildContext context) {
    final wear = ((bikeTotalKm - component.installedAtBikeKm) /
            component.expectedLifeKm)
        .clamp(0.0, 1.0)
        .toDouble();
    final wearLabel = (wear * 100).round();
    final status = WearStatus.statusFromWear(wear);

    return VCard(
      onTap: () => context.push('/components/${component.id}'),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxHeight < 180;
          final ringSize = compact ? 44.0 : 56.0;
          final spacing = compact ? 6.0 : 8.0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  WearRing(
                    progress: wear,
                    size: ringSize,
                    strokeWidth: compact ? 5 : 6,
                    center: Text(
                      '$wearLabel%',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: StatusChip(
                      label: _statusLabel(context, wear),
                      level: status,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing),
              Text(
                '${component.brand} ${component.model}',
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                context.l10n.kmSinceInstall(
                  Formatters.km(bikeTotalKm - component.installedAtBikeKm),
                  Formatters.km(component.expectedLifeKm),
                ),
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: compact ? 1 : 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
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

class _AddComponentSheet extends ConsumerStatefulWidget {
  const _AddComponentSheet({
    required this.bikeId,
    required this.bikeTotalKm,
    required this.currentCount,
  });

  final int bikeId;
  final int bikeTotalKm;
  final int currentCount;

  @override
  ConsumerState<_AddComponentSheet> createState() => _AddComponentSheetState();
}

class _AddComponentSheetState extends ConsumerState<_AddComponentSheet> {
  ComponentType _type = ComponentType.chain;
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _lifeController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _lifeController.text = ComponentDefaults.expectedLifeKm(_type).toString();
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _lifeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOther = _type == ComponentType.other;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(context.l10n.addComponent, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          DropdownButtonFormField<ComponentType>(
            value: _type,
            items: ComponentType.values
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(ComponentDefaults.label(type, context.l10n)),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _type = value;
                _lifeController.text = ComponentDefaults.expectedLifeKm(value).toString();
              });
            },
            decoration: InputDecoration(labelText: context.l10n.componentType),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _brandController,
            decoration: InputDecoration(
              labelText:
                  isOther ? context.l10n.componentNameLabel : context.l10n.brandLabel,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _modelController,
            decoration: InputDecoration(
              labelText: isOther
                  ? context.l10n.componentDetailsOptionalLabel
                  : context.l10n.modelLabel,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _lifeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: context.l10n.expectedLifeLabel),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: context.l10n.priceOptionalLabel),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final settings = ref.read(settingsControllerProvider).value;
              final isCancelled = settings != null && !settings.isPro && settings.hadPro;
              final isFree = settings != null && !settings.isPro && !settings.hadPro;
              if (isCancelled || (isFree && widget.currentCount >= 5)) {
                if (context.mounted) {
                  _showProRequired(context);
                }
                return;
              }
              final brand = _brandController.text.trim();
              final model = _modelController.text.trim();
              if (brand.isEmpty || (!isOther && model.isEmpty)) return;
              final expected = int.tryParse(_lifeController.text) ??
                  ComponentDefaults.expectedLifeKm(_type);
              final price = double.tryParse(_priceController.text.trim());
              await ref.read(componentRepositoryProvider).addComponent(
                    bikeId: widget.bikeId,
                    type: _type.id,
                    brand: brand,
                    model: model,
                    expectedLifeKm: expected,
                    installedAtBikeKm: widget.bikeTotalKm,
                    price: price,
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
  }
}

void _showProRequired(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(context.l10n.proRequiredMessage)),
  );
}
