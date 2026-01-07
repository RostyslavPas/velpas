import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/db/daos/meta_dao.dart';
import '../models/strava_models.dart';

class SecureStorageService {
  SecureStorageService(this._storage, this._metaDao);

  final FlutterSecureStorage _storage;
  final MetaDao _metaDao;
  bool _secureAvailable = true;

  static const _keyPro = 'pro_status';
  static const _keyLocale = 'selected_locale';
  static const _keyBiometrics = 'biometrics_enabled';
  static const _keyLastSync = 'last_sync_iso';
  static const _keyStravaConnected = 'strava_connected';
  static const _keyPrimaryBikeId = 'primary_bike_id';
  static const _keyCurrencyCode = 'currency_code';
  static const _keyStravaAccessToken = 'strava_access_token';
  static const _keyStravaRefreshToken = 'strava_refresh_token';
  static const _keyStravaExpiresAt = 'strava_expires_at';
  static const _keyStravaAthleteId = 'strava_athlete_id';
  static const _keyStravaAuthState = 'strava_auth_state';

  Future<bool> getProStatus() async {
    final value = await _read(_keyPro);
    return value == 'true';
  }

  Future<void> setProStatus(bool value) async {
    await _write(_keyPro, value.toString());
  }

  Future<String?> getLocaleCode() async {
    return _read(_keyLocale);
  }

  Future<void> setLocaleCode(String code) async {
    await _write(_keyLocale, code);
  }

  Future<bool> getBiometricsEnabled() async {
    final value = await _read(_keyBiometrics);
    return value == 'true';
  }

  Future<void> setBiometricsEnabled(bool value) async {
    await _write(_keyBiometrics, value.toString());
  }

  Future<DateTime?> getLastSyncAt() async {
    final value = await _read(_keyLastSync);
    if (value == null) return null;
    return DateTime.tryParse(value);
  }

  Future<void> setLastSyncAt(DateTime value) async {
    await _write(_keyLastSync, value.toIso8601String());
  }

  Future<bool> getStravaConnected() async {
    final tokens = await getStravaTokens();
    if (tokens != null) return true;
    final value = await _read(_keyStravaConnected);
    return value == 'true';
  }

  Future<void> setStravaConnected(bool value) async {
    await _write(_keyStravaConnected, value.toString());
  }

  Future<StravaTokens?> getStravaTokens() async {
    final accessToken = await _read(_keyStravaAccessToken);
    final refreshToken = await _read(_keyStravaRefreshToken);
    final expiresAtRaw = await _read(_keyStravaExpiresAt);
    if (accessToken == null || refreshToken == null || expiresAtRaw == null) {
      return null;
    }
    final expiresAt = StravaTokens.parseExpiresAt(expiresAtRaw);
    if (expiresAt == null) return null;
    final athleteId = await _read(_keyStravaAthleteId);
    return StravaTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
      athleteId: athleteId,
    );
  }

  Future<void> setStravaTokens(StravaTokens tokens) async {
    await _write(_keyStravaAccessToken, tokens.accessToken);
    await _write(_keyStravaRefreshToken, tokens.refreshToken);
    await _write(
      _keyStravaExpiresAt,
      (tokens.expiresAt.millisecondsSinceEpoch ~/ 1000).toString(),
    );
    await _write(_keyStravaAthleteId, tokens.athleteId);
    await setStravaConnected(true);
  }

  Future<void> clearStravaTokens() async {
    await _write(_keyStravaAccessToken, null);
    await _write(_keyStravaRefreshToken, null);
    await _write(_keyStravaExpiresAt, null);
    await _write(_keyStravaAthleteId, null);
    await setStravaConnected(false);
  }

  Future<String?> getStravaAuthState() async {
    return _read(_keyStravaAuthState);
  }

  Future<void> setStravaAuthState(String value) async {
    await _write(_keyStravaAuthState, value);
  }

  Future<void> clearStravaAuthState() async {
    await _write(_keyStravaAuthState, null);
  }

  Future<int?> getPrimaryBikeId() async {
    final value = await _read(_keyPrimaryBikeId);
    if (value == null) return null;
    return int.tryParse(value);
  }

  Future<void> setPrimaryBikeId(int? value) async {
    await _write(_keyPrimaryBikeId, value?.toString());
  }

  Future<String> getCurrencyCode() async {
    final value = await _read(_keyCurrencyCode);
    return value ?? 'USD';
  }

  Future<void> setCurrencyCode(String code) async {
    await _write(_keyCurrencyCode, code);
  }

  Future<String?> _read(String key) async {
    if (_secureAvailable) {
      try {
        final value = await _storage.read(key: key);
        if (value != null) return value;
      } catch (_) {
        _secureAvailable = false;
      }
    }
    return _metaDao.getValue(key);
  }

  Future<void> _write(String key, String? value) async {
    if (_secureAvailable) {
      try {
        await _storage.write(key: key, value: value);
      } catch (_) {
        _secureAvailable = false;
      }
    }
    await _metaDao.setValue(key, value);
  }
}
