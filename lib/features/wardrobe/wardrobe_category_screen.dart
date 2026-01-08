import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/app_localizations_ext.dart';
import '../../core/providers.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/wardrobe_models.dart';
import 'wardrobe_providers.dart';
import '../settings/settings_controller.dart';

class WardrobeCategoryScreen extends ConsumerWidget {
  const WardrobeCategoryScreen({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(wardrobeItemsProvider(category));
    final settings = ref.watch(settingsControllerProvider).value;
    final isPro = settings?.isPro ?? false;
    final currencyCode = ref.watch(settingsControllerProvider).maybeWhen(
          data: (settings) => settings.currencyCode,
          orElse: () => 'USD',
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryLabel(context, category)),
        actions: [
          IconButton(
            onPressed: () {
              if (isPro) {
                _showForm(context, ref);
                return;
              }
              _showProRequired(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: itemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(context.l10n.emptyWardrobeCategory));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text('${item.brand} ${item.model}'),
                subtitle: Text(context.l10n.itemQuantity(item.quantity)),
                trailing: item.price == null
                    ? null
                    : Text(
                        Formatters.price(
                          item.price! * item.quantity,
                          currencyCode: currencyCode,
                        ),
                      ),
                onTap: () {
                  if (isPro) {
                    _showForm(context, ref, item: item);
                    return;
                  }
                  _showProRequired(context);
                },
              );
            },
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

  void _showForm(BuildContext context, WidgetRef ref, {WardrobeItem? item}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) => _WardrobeItemForm(
        category: category,
        item: item,
      ),
    );
  }
}

void _showProRequired(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(context.l10n.proRequiredMessage)),
  );
}

class _WardrobeItemForm extends ConsumerStatefulWidget {
  const _WardrobeItemForm({required this.category, this.item});

  final String category;
  final WardrobeItem? item;

  @override
  ConsumerState<_WardrobeItemForm> createState() => _WardrobeItemFormState();
}

class _WardrobeItemFormState extends ConsumerState<_WardrobeItemForm> {
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    if (item != null && _brandController.text.isEmpty) {
      _brandController.text = item.brand;
      _modelController.text = item.model;
      _quantityController.text = item.quantity.toString();
      _priceController.text = item.price?.toString() ?? '';
      _notesController.text = item.notes ?? '';
    }

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
            item == null ? context.l10n.addItem : context.l10n.editItem,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _brandController,
            decoration: InputDecoration(labelText: context.l10n.brandLabel),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _modelController,
            decoration: InputDecoration(labelText: context.l10n.modelLabel),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: context.l10n.quantityLabel),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: context.l10n.priceOptionalLabel),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            decoration: InputDecoration(labelText: context.l10n.notesLabel),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final brand = _brandController.text.trim();
              final model = _modelController.text.trim();
              final quantity = int.tryParse(_quantityController.text) ?? 1;
              if (brand.isEmpty || model.isEmpty) return;

              final price = double.tryParse(_priceController.text.trim());
              final notes = _notesController.text.trim().isEmpty
                  ? null
                  : _notesController.text.trim();

              if (item == null) {
                await ref.read(wardrobeRepositoryProvider).addItem(
                      category: widget.category,
                      brand: brand,
                      model: model,
                      quantity: quantity,
                      price: price,
                      notes: notes,
                    );
              } else {
                await ref.read(wardrobeRepositoryProvider).updateItem(
                      id: item.id,
                      brand: brand,
                      model: model,
                      quantity: quantity,
                      price: price,
                      notes: notes,
                    );
              }
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Text(context.l10n.saveLabel),
          ),
          if (item != null)
            TextButton(
              onPressed: () async {
                await ref.read(wardrobeRepositoryProvider).deleteItem(item.id);
                if (context.mounted) Navigator.of(context).pop();
              },
              child: Text(context.l10n.deleteItem),
            ),
        ],
      ),
    );
  }
}
