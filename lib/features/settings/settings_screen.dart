import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/v_card.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../garage/garage_providers.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsTitle),
      ),
      body: settingsAsync.when(
        data: (settings) {
          final isPro = settings.isPro;
          final bikesAsync = ref.watch(garageBikesProvider);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              VCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.languageTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<Locale>(
                      value: settings.locale ?? const Locale('en'),
                      items: [
                        DropdownMenuItem(
                          value: const Locale('en'),
                          child: Text(context.l10n.languageEnglish),
                        ),
                        DropdownMenuItem(
                          value: const Locale('uk'),
                          child: Text(context.l10n.languageUkrainian),
                        ),
                      ],
                      onChanged: (locale) {
                        ref.read(settingsControllerProvider.notifier).setLocale(locale);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              VCard(
                child: bikesAsync.when(
                  data: (bikes) {
                    if (bikes.isEmpty) {
                      return Text(context.l10n.primaryBikeEmpty);
                    }
                    final hasSelected = bikes.any(
                      (bike) => bike.bike.id == settings.primaryBikeId,
                    );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.primaryBikeTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<int?>(
                          value: hasSelected ? settings.primaryBikeId : null,
                          items: [
                            DropdownMenuItem<int?>(
                              value: null,
                              child: Text(context.l10n.primaryBikeNone),
                            ),
                            ...bikes.map(
                              (bike) => DropdownMenuItem<int?>(
                                value: bike.bike.id,
                                child: Text(bike.bike.name),
                              ),
                            ),
                          ],
                          onChanged: (value) => ref
                              .read(settingsControllerProvider.notifier)
                              .setPrimaryBikeId(value),
                          decoration: InputDecoration(
                            labelText: context.l10n.primaryBikeLabel,
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Text('Error: $error'),
                ),
              ),
              const SizedBox(height: 16),
              VCard(
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(context.l10n.biometricToggleTitle),
                  subtitle: Text(context.l10n.biometricToggleSubtitle),
                  value: settings.biometricsEnabled,
                  onChanged: (value) {
                    ref.read(settingsControllerProvider.notifier).setBiometricsEnabled(value);
                  },
                ),
              ),
              const SizedBox(height: 16),
              VCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.subscriptionTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(isPro ? context.l10n.proStatus : context.l10n.freeStatus),
                    const SizedBox(height: 12),
                    if (!isPro)
                      ElevatedButton(
                        onPressed: () => context.push('/paywall'),
                        child: Text(context.l10n.upgradeToPro),
                      ),
                    if (isPro)
                      OutlinedButton(
                        onPressed: () => ref
                            .read(settingsControllerProvider.notifier)
                            .setPro(false),
                        child: Text(context.l10n.cancelPro),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              VCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.stravaTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isPro
                          ? (settings.stravaConnected
                              ? context.l10n.stravaConnected
                              : context.l10n.stravaDisconnected)
                          : context.l10n.stravaLocked,
                    ),
                    const SizedBox(height: 12),
                    if (!isPro)
                      ElevatedButton(
                        onPressed: () => context.push('/paywall'),
                        child: Text(context.l10n.connectStrava),
                      )
                    else if (settings.stravaConnected)
                      OutlinedButton(
                        onPressed: () => ref
                            .read(settingsControllerProvider.notifier)
                            .setStravaConnected(false),
                        child: Text(context.l10n.disconnectStrava),
                      )
                    else
                      ElevatedButton(
                        onPressed: () => ref
                            .read(settingsControllerProvider.notifier)
                            .setStravaConnected(true),
                        child: Text(context.l10n.connectStrava),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              VCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.accountTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(context.l10n.phoneAuthStub),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => context.push('/settings/auth'),
                      child: Text(context.l10n.openAuth),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              VCard(
                onTap: () => context.push('/settings/about'),
                child: Row(
                  children: [
                    Expanded(child: Text(context.l10n.aboutTitle)),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
