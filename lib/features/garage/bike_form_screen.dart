import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/localization/app_localizations_ext.dart';
import '../../core/providers.dart';
import 'garage_providers.dart';
import '../settings/settings_controller.dart';

class BikeFormScreen extends ConsumerStatefulWidget {
  const BikeFormScreen({super.key, this.bikeId});

  final int? bikeId;

  @override
  ConsumerState<BikeFormScreen> createState() => _BikeFormScreenState();
}

class _BikeFormScreenState extends ConsumerState<BikeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String? _photoPath;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.bikeId != null;
    final bikeAsync = widget.bikeId == null
        ? const AsyncValue.data(null)
        : ref.watch(bikeByIdProvider(widget.bikeId!));

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? context.l10n.editBike : context.l10n.addBike),
      ),
      body: bikeAsync.when(
        data: (bike) {
          if (isEditing && bike == null) {
            return Center(child: Text(context.l10n.bikeNotFound));
          }
          if (bike != null && _nameController.text.isEmpty) {
            _nameController.text = bike.bike.name;
            _priceController.text = bike.bike.purchasePrice?.toString() ?? '';
            _photoPath = bike.bike.photoPath;
          }

          final viewInsets = MediaQuery.of(context).viewInsets;
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + viewInsets.bottom),
              children: [
                _PhotoPicker(
                  photoPath: _photoPath,
                  onPick: (path) => setState(() => _photoPath = path),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: context.l10n.bikeNameLabel),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.l10n.requiredField;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: context.l10n.purchasePriceOptional),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _save,
                  child: Text(context.l10n.saveLabel),
                ),
                if (isEditing)
                  TextButton(
                    onPressed: _deleteBike,
                    child: Text(context.l10n.deleteBike),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text.trim());

    if (widget.bikeId == null) {
      final settings = ref.read(settingsControllerProvider).value;
      if (settings != null && !settings.isPro) {
        if (settings.hadPro) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.proRequiredMessage)),
            );
          }
          return;
        }
        final bikes = await ref.read(garageBikesProvider.future);
        if (bikes.length >= 1) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.proRequiredMessage)),
            );
          }
          return;
        }
      }
      await ref.read(bikeRepositoryProvider).addBike(
            name: name,
            purchasePrice: price,
            photoPath: _photoPath,
          );
    } else {
      await ref.read(bikeRepositoryProvider).updateBike(
            id: widget.bikeId!,
            name: name,
            purchasePrice: price,
            photoPath: _photoPath,
          );
    }
    if (mounted) {
      context.pop();
    }
  }

  Future<void> _deleteBike() async {
    final id = widget.bikeId;
    if (id == null) return;
    await ref.read(bikeRepositoryProvider).deleteBike(id);
    if (mounted) {
      context.pop();
    }
  }
}

class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({
    required this.photoPath,
    required this.onPick,
  });

  final String? photoPath;
  final ValueChanged<String?> onPick;

  @override
  Widget build(BuildContext context) {
    final file = photoPath == null ? null : File(photoPath!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.bikePhotoLabel, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        InkWell(
          onTap: () => _pickImage(context),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black26,
              image: file != null && file.existsSync()
                  ? DecorationImage(image: FileImage(file), fit: BoxFit.cover)
                  : null,
            ),
            child: file == null
                ? Center(child: Text(context.l10n.pickPhoto))
                : null,
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    if (kIsWeb || Platform.isIOS || Platform.isAndroid) {
      final picker = ImagePicker();
      final result = await picker.pickImage(source: ImageSource.gallery);
      if (result != null) {
        onPick(result.path);
      }
      return;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.photoPickerUnavailable)),
      );
    }
  }
}
