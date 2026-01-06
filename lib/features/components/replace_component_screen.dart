import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/app_localizations_ext.dart';
import '../../core/providers.dart';
import '../../core/utils/component_utils.dart';
import '../../core/utils/formatters.dart';
import '../garage/garage_providers.dart';
import 'component_providers.dart';

class ReplaceComponentScreen extends ConsumerStatefulWidget {
  const ReplaceComponentScreen({super.key, required this.componentId});

  final int componentId;

  @override
  ConsumerState<ReplaceComponentScreen> createState() => _ReplaceComponentScreenState();
}

class _ReplaceComponentScreenState extends ConsumerState<ReplaceComponentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _removedKmController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _lifeController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _removedKmController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _lifeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final componentAsync = ref.watch(componentByIdProvider(widget.componentId));

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.replaceComponent)),
      body: componentAsync.when(
        data: (component) {
          if (component == null) {
            return Center(child: Text(context.l10n.componentNotFound));
          }
          final bikeAsync = ref.watch(bikeByIdProvider(component.bikeId));

          return bikeAsync.when(
            data: (bike) {
              if (bike == null) {
                return Center(child: Text(context.l10n.bikeNotFound));
              }
              if (_brandController.text.isEmpty) {
                _brandController.text = component.brand;
                _modelController.text = component.model;
                _lifeController.text = component.expectedLifeKm.toString();
                _removedKmController.text = bike.totalKm.toString();
              }

              return Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      context.l10n.removalKmLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _removedKmController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: context.l10n.currentBikeKmLabel(Formatters.km(bike.totalKm)),
                      ),
                      validator: (value) {
                        if (value == null || int.tryParse(value) == null) {
                          return context.l10n.requiredField;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.newComponentTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _brandController,
                      decoration: InputDecoration(labelText: context.l10n.brandLabel),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.l10n.requiredField;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _modelController,
                      decoration: InputDecoration(labelText: context.l10n.modelLabel),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.l10n.requiredField;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _lifeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: context.l10n.expectedLifeLabel),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: context.l10n.priceOptionalLabel),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        final removedKm = int.parse(_removedKmController.text);
                        final expected = int.tryParse(_lifeController.text) ??
                            ComponentDefaults.expectedLifeKm(
                              ComponentType.fromId(component.type),
                            );
                        final price = double.tryParse(_priceController.text.trim());

                        await ref.read(componentRepositoryProvider).replaceComponent(
                              oldComponent: component,
                              removedAtBikeKm: removedKm,
                              removedAt: DateTime.now(),
                              newBrand: _brandController.text.trim(),
                              newModel: _modelController.text.trim(),
                              expectedLifeKm: expected,
                              newPrice: price,
                            );
                        if (mounted) {
                          context.pop();
                        }
                      },
                      child: Text(context.l10n.replaceComponent),
                    ),
                  ],
                ),
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
}
