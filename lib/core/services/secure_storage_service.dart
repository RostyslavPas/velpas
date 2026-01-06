import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/db/daos/meta_dao.dart';

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
    final value = await _read(_keyStravaConnected);
    return value == 'true';
  }

  Future<void> setStravaConnected(bool value) async {
    await _write(_keyStravaConnected, value.toString());
  }

  Future<int?> getPrimaryBikeId() async {
    final value = await _read(_keyPrimaryBikeId);
    if (value == null) return null;
    return int.tryParse(value);
  }

  Future<void> setPrimaryBikeId(int? value) async {
    await _write(_keyPrimaryBikeId, value?.toString());
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
