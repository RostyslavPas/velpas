import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/v_card.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../../core/utils/formatters.dart';
import 'garage_providers.dart';
import '../settings/settings_controller.dart';

class GarageScreen extends ConsumerWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bikesAsync = ref.watch(garageBikesProvider);
    final settingsAsync = ref.watch(settingsControllerProvider);
    final settings = settingsAsync.value;
    final bikeCount = bikesAsync.value?.length ?? 0;
    final canAddBike = settings != null && _canAddBike(settings, bikeCount);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.garageTitle),
        actions: [
          IconButton(
            onPressed: settings == null
                ? null
                : () {
                    if (canAddBike) {
                      context.push('/garage/add');
                      return;
                    }
                    _showProRequired(context);
                  },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: bikesAsync.when(
        data: (bikes) {
          final primaryBikeId =
              settings?.primaryBikeId ?? (bikes.isNotEmpty ? bikes.first.bike.id : null);
          if (bikes.isEmpty) {
            return Center(
              child: Text(context.l10n.emptyGarageTitle),
            );
          }
          final isLimited = settings != null && !settings.isPro;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bikes.length,
            itemBuilder: (context, index) {
              final bike = bikes[index];
              final isLocked =
                  isLimited && primaryBikeId != null && bike.bike.id != primaryBikeId;
              final photoPath = bike.bike.photoPath;
              final file = (!kIsWeb && photoPath != null) ? File(photoPath) : null;
              final hasPhoto = file != null && file.existsSync();
              return Opacity(
                opacity: isLocked ? 0.5 : 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: VCard(
                    onTap: isLocked ? null : () => context.push('/garage/${bike.bike.id}'),
                    child: Row(
                      children: [
                        Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(12),
                            image: hasPhoto
                                ? DecorationImage(
                                    image: FileImage(file),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: hasPhoto ? null : const Icon(Icons.directions_bike),
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
                        Icon(isLocked ? Icons.lock : Icons.chevron_right),
                      ],
                    ),
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

bool _canAddBike(SettingsState settings, int bikeCount) {
  if (settings.isPro) return true;
  if (settings.hadPro) return false;
  return bikeCount < 1;
}

void _showProRequired(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(context.l10n.proRequiredMessage)),
  );
}
