import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/strava_models.dart';
import '../../core/providers.dart';

class SettingsState {
  SettingsState({
    required this.locale,
    required this.biometricsEnabled,
    required this.isPro,
    required this.hadPro,
    required this.lastSync,
    required this.stravaConnected,
    required this.primaryBikeId,
    required this.currencyCode,
  });

  final Locale? locale;
  final bool biometricsEnabled;
  final bool isPro;
  final bool hadPro;
  final DateTime? lastSync;
  final bool stravaConnected;
  final int? primaryBikeId;
  final String currencyCode;

  SettingsState copyWith({
    Locale? locale,
    bool? biometricsEnabled,
    bool? isPro,
    bool? hadPro,
    DateTime? lastSync,
    bool? stravaConnected,
    int? primaryBikeId,
    String? currencyCode,
  }) {
    return SettingsState(
      locale: locale ?? this.locale,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      isPro: isPro ?? this.isPro,
      hadPro: hadPro ?? this.hadPro,
      lastSync: lastSync ?? this.lastSync,
      stravaConnected: stravaConnected ?? this.stravaConnected,
      primaryBikeId: primaryBikeId ?? this.primaryBikeId,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }
}

class SettingsController extends AsyncNotifier<SettingsState> {
  @override
  Future<SettingsState> build() async {
    final storage = ref.read(secureStorageServiceProvider);
    final localeCode = await storage.getLocaleCode();
    final tokens = await storage.getStravaTokens();
    return SettingsState(
      locale: localeCode == null ? const Locale('en') : Locale(localeCode),
      biometricsEnabled: await storage.getBiometricsEnabled(),
      isPro: await storage.getProStatus(),
      hadPro: await storage.getHadPro(),
      lastSync: await storage.getLastSyncAt(),
      stravaConnected: tokens != null,
      primaryBikeId: await storage.getPrimaryBikeId(),
      currencyCode: await storage.getCurrencyCode(),
    );
  }

  Future<void> setLocale(Locale? locale) async {
    final storage = ref.read(secureStorageServiceProvider);
    final safeLocale = locale ?? const Locale('en');
    await storage.setLocaleCode(safeLocale.languageCode);
    state = AsyncData(state.value!.copyWith(locale: safeLocale));
  }

  Future<void> setBiometricsEnabled(bool enabled) async {
    final storage = ref.read(secureStorageServiceProvider);
    await storage.setBiometricsEnabled(enabled);
    state = AsyncData(state.value!.copyWith(biometricsEnabled: enabled));
  }

  Future<void> setPro(bool isPro) async {
    final storage = ref.read(secureStorageServiceProvider);
    await storage.setProStatus(isPro);
    if (isPro) {
      await storage.setHadPro(true);
    }
    if (!isPro) {
      await storage.clearStravaTokens();
    }
    state = AsyncData(
      state.value!.copyWith(
        isPro: isPro,
        hadPro: isPro ? true : state.value!.hadPro,
        stravaConnected: isPro ? state.value!.stravaConnected : false,
      ),
    );
  }

  Future<void> setLastSync(DateTime value) async {
    final storage = ref.read(secureStorageServiceProvider);
    await storage.setLastSyncAt(value);
    state = AsyncData(state.value!.copyWith(lastSync: value));
  }

  Future<void> setStravaConnected(bool value) async {
    final storage = ref.read(secureStorageServiceProvider);
    await storage.setStravaConnected(value);
    state = AsyncData(state.value!.copyWith(stravaConnected: value));
  }

  Future<void> applyStravaTokens(StravaTokens tokens) async {
    final storage = ref.read(secureStorageServiceProvider);
    await storage.setStravaTokens(tokens);
    final current = state.value ??
        SettingsState(
      locale: const Locale('en'),
      biometricsEnabled: false,
      isPro: false,
      hadPro: false,
      lastSync: null,
      stravaConnected: false,
      primaryBikeId: null,
      currencyCode: 'USD',
        );
    state = AsyncData(current.copyWith(stravaConnected: true));
  }

  Future<void> disconnectStrava() async {
    final storage = ref.read(secureStorageServiceProvider);
    await storage.clearStravaTokens();
    final current = state.value ??
        SettingsState(
      locale: const Locale('en'),
      biometricsEnabled: false,
      isPro: false,
      hadPro: false,
      lastSync: null,
      stravaConnected: false,
      primaryBikeId: null,
      currencyCode: 'USD',
        );
    state = AsyncData(current.copyWith(stravaConnected: false));
  }

  Future<void> setPrimaryBikeId(int? value) async {
    final storage = ref.read(secureStorageServiceProvider);
    await storage.setPrimaryBikeId(value);
    state = AsyncData(state.value!.copyWith(primaryBikeId: value));
  }

  Future<void> setCurrencyCode(String code) async {
    final storage = ref.read(secureStorageServiceProvider);
    await storage.setCurrencyCode(code);
    state = AsyncData(state.value!.copyWith(currencyCode: code));
  }
}

final settingsControllerProvider =
    AsyncNotifierProvider<SettingsController, SettingsState>(
  SettingsController.new,
);
