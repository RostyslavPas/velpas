import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/v_card.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../../core/providers.dart';
import '../../core/services/strava_service.dart';
import '../../data/models/bike_models.dart';
import '../garage/garage_providers.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Widget _backgroundCard(BuildContext context, Widget child, {VoidCallback? onTap}) {
    return VCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.12,
                  child: Image.asset(
                    'assets/w13.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ],
        ),
      ),
    );
  }

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
          final canChangeCurrency = isPro;
          const basicCurrencies = {'USD', 'EUR', 'UAH'};
          const basicOrder = ['UAH', 'USD', 'EUR'];
          final canChangeLanguage = isPro;
          final basicLanguages = <Locale>[
            const Locale('en'),
            const Locale('uk'),
          ];
          final proLanguages = <Locale>[
            const Locale('es'),
            const Locale('fr'),
            const Locale('it'),
            Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
          ];
          final languageLabels = <Locale, String>{
            const Locale('en'): context.l10n.languageEnglish,
            const Locale('uk'): context.l10n.languageUkrainian,
            const Locale('es'): context.l10n.languageSpanish,
            const Locale('fr'): context.l10n.languageFrench,
            const Locale('it'): context.l10n.languageItalian,
            Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'):
                context.l10n.languageChinese,
          };
          final currencyEntries = <MapEntry<String, String>>[
            MapEntry('USD', context.l10n.currencyUsd),
            MapEntry('EUR', context.l10n.currencyEur),
            MapEntry('GBP', context.l10n.currencyGbp),
            MapEntry('JPY', context.l10n.currencyJpy),
            MapEntry('CHF', context.l10n.currencyChf),
            MapEntry('CNY', context.l10n.currencyCny),
            MapEntry('HKD', context.l10n.currencyHkd),
            MapEntry('SGD', context.l10n.currencySgd),
            MapEntry('KRW', context.l10n.currencyKrw),
            MapEntry('INR', context.l10n.currencyInr),
            MapEntry('THB', context.l10n.currencyThb),
            MapEntry('IDR', context.l10n.currencyIdr),
            MapEntry('MYR', context.l10n.currencyMyr),
            MapEntry('PHP', context.l10n.currencyPhp),
            MapEntry('CAD', context.l10n.currencyCad),
            MapEntry('AUD', context.l10n.currencyAud),
            MapEntry('NZD', context.l10n.currencyNzd),
            MapEntry('MXN', context.l10n.currencyMxn),
            MapEntry('BRL', context.l10n.currencyBrl),
            MapEntry('ARS', context.l10n.currencyArs),
            MapEntry('CLP', context.l10n.currencyClp),
            MapEntry('COP', context.l10n.currencyCop),
            MapEntry('PLN', context.l10n.currencyPln),
            MapEntry('CZK', context.l10n.currencyCzk),
            MapEntry('HUF', context.l10n.currencyHuf),
            MapEntry('SEK', context.l10n.currencySek),
            MapEntry('NOK', context.l10n.currencyNok),
            MapEntry('DKK', context.l10n.currencyDkk),
            MapEntry('RON', context.l10n.currencyRon),
            MapEntry('UAH', context.l10n.currencyUah),
            MapEntry('TRY', context.l10n.currencyTry),
            MapEntry('AED', context.l10n.currencyAed),
            MapEntry('SAR', context.l10n.currencySar),
            MapEntry('ILS', context.l10n.currencyIls),
            MapEntry('ZAR', context.l10n.currencyZar),
            MapEntry('EGP', context.l10n.currencyEgp),
            MapEntry('NGN', context.l10n.currencyNgn),
          ];
          final disabledTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              );
          final highlightStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              );
          final currencyLabels = Map<String, String>.fromEntries(currencyEntries);
          final basicEntries = basicOrder
              .map((code) => MapEntry(code, currencyLabels[code] ?? code))
              .toList();
          final proEntries =
              currencyEntries.where((entry) => !basicCurrencies.contains(entry.key));
          final proLanguageValue = const Locale('pro');
          final basicLanguageEntries =
              basicLanguages.map((locale) => MapEntry(locale, languageLabels[locale] ?? ''));
          final proLanguageEntries =
              proLanguages.map((locale) => MapEntry(locale, languageLabels[locale] ?? ''));
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _backgroundCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.languageTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<Locale>(
                      value: settings.locale ?? const Locale('en'),
                      isExpanded: true,
                      items: [
                        ...basicLanguageEntries.map(
                          (entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(entry.value),
                          ),
                        ),
                        if (!canChangeLanguage)
                          DropdownMenuItem(
                            value: proLanguageValue,
                            enabled: false,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lock,
                                  size: 16,
                                  color: highlightStyle?.color,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    context.l10n.languageProOnlyHint,
                                    style: highlightStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ...proLanguageEntries.map(
                          (entry) => DropdownMenuItem(
                            value: entry.key,
                            enabled: canChangeLanguage,
                            child: Text(
                              entry.value,
                              style: canChangeLanguage ? null : disabledTextStyle,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (locale) {
                        if (locale == null || locale == proLanguageValue) return;
                        if (!canChangeLanguage &&
                            !basicLanguages.any((item) => item == locale)) {
                          _showProRequired(context);
                          return;
                        }
                        ref.read(settingsControllerProvider.notifier).setLocale(locale);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _backgroundCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.currencyTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: settings.currencyCode,
                      isExpanded: true,
                      items: [
                        ...basicEntries.map(
                          (entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(entry.value),
                          ),
                        ),
                        if (!canChangeCurrency)
                          DropdownMenuItem(
                            value: '__pro_only__',
                            enabled: false,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lock,
                                  size: 16,
                                  color: highlightStyle?.color,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    context.l10n.currencyProOnlyHint,
                                    style: highlightStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ...proEntries.map(
                          (entry) {
                            final enabled = canChangeCurrency;
                            return DropdownMenuItem(
                              value: entry.key,
                              enabled: enabled,
                              child: Text(
                                entry.value,
                                style: enabled ? null : disabledTextStyle,
                              ),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        if (value == '__pro_only__') return;
                        if (!canChangeCurrency && !basicCurrencies.contains(value)) {
                          _showProRequired(context);
                          return;
                        }
                        ref
                            .read(settingsControllerProvider.notifier)
                            .setCurrencyCode(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _backgroundCard(
                context,
                bikesAsync.when(
                  data: (bikes) {
                    if (bikes.isEmpty) {
                      return Text(context.l10n.primaryBikeEmpty);
                    }
                    final hasSelected = bikes.any(
                      (bike) => bike.bike.id == settings.primaryBikeId,
                    );
                    final canSelectPrimary = isPro;
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
                          onChanged: canSelectPrimary
                              ? (value) => ref
                                  .read(settingsControllerProvider.notifier)
                                  .setPrimaryBikeId(value)
                              : null,
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
              _backgroundCard(
                context,
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(context.l10n.biometricToggleTitle),
                  subtitle: Text(context.l10n.biometricToggleSubtitle),
                  value: settings.biometricsEnabled,
                  onChanged: isPro
                      ? (value) {
                          ref
                              .read(settingsControllerProvider.notifier)
                              .setBiometricsEnabled(value);
                        }
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              VCard(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Opacity(
                            opacity: 0.16,
                            child: Image.asset(
                              'assets/w10.png',
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _backgroundCard(
                context,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.stravaTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    if (!isPro)
                      Text(context.l10n.stravaLocked)
                    else if (!settings.stravaConnected)
                      Text(context.l10n.stravaDisconnected),
                    const SizedBox(height: 12),
                    if (!isPro)
                      ElevatedButton(
                        onPressed: () => context.push('/paywall'),
                        child: Text(context.l10n.connectStrava),
                      )
                    else if (settings.stravaConnected)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OutlinedButton(
                            onPressed: () => ref
                                .read(settingsControllerProvider.notifier)
                                .disconnectStrava(),
                            child: Text(context.l10n.disconnectStrava),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () async {
                              final confirmed = await _confirmFullSync(context);
                              if (confirmed != true) return;
                              await _runFullSync(
                                context,
                                ref,
                                settings,
                              );
                            },
                            child: Text(context.l10n.fullSyncStrava),
                          ),
                        ],
                      )
                    else
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await ref.read(stravaAuthServiceProvider).startAuth();
                          } on Exception {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(context.l10n.stravaAuthFailed)),
                              );
                            }
                          }
                        },
                        child: Text(context.l10n.connectStrava),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _backgroundCard(
                context,
                Row(
                  children: [
                    Expanded(child: Text(context.l10n.aboutTitle)),
                    const Icon(Icons.chevron_right),
                  ],
                ),
                onTap: () => context.push('/settings/about'),
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

Future<bool?> _confirmFullSync(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(context.l10n.fullSyncConfirmTitle),
        content: Text(context.l10n.fullSyncConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.fullSyncCancelAction),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.fullSyncConfirmAction),
          ),
        ],
      );
    },
  );
}

Future<void> _runFullSync(
  BuildContext context,
  WidgetRef ref,
  SettingsState settings,
) async {
  if (!settings.isPro) {
    if (context.mounted) {
      context.push('/paywall');
    }
    return;
  }
  if (!settings.stravaConnected) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.stravaConnectRequired)),
      );
    }
    return;
  }

  if (!context.mounted) return;
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  BikeImportResult? importResult;
  try {
    final service = ref.read(stravaServiceProvider);
    importResult = await service.importBikes();

    final bikes = await ref.read(garageBikesProvider.future);
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

    final fallbackBikeId = _resolveFallbackBikeId(bikes, settings.primaryBikeId);
    if (fallbackBikeId == null) return;

    final result = await service.syncBike(fallbackBikeId, fullSync: true);
    await ref.read(settingsControllerProvider.notifier).setLastSync(DateTime.now());
    await ref.read(maintenanceAlertServiceProvider).checkAlerts(context);

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
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}

int? _resolveFallbackBikeId(List<BikeWithStats> bikes, int? primaryBikeId) {
  if (bikes.isEmpty) return null;
  if (primaryBikeId == null) return bikes.first.bike.id;
  for (final bike in bikes) {
    if (bike.bike.id == primaryBikeId) {
      return primaryBikeId;
    }
  }
  return bikes.first.bike.id;
}

void _showProRequired(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(context.l10n.proRequiredMessage)),
  );
}
