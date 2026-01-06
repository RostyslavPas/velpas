import 'dart:convert';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

import 'secure_storage_service.dart';

class StravaAuthService {
  StravaAuthService(this._storage);

  final SecureStorageService _storage;

  static const String clientId = '161678';
  static const String redirectUri = 'https://pasue.com.ua/strava/callback';

  Future<void> startAuth() async {
    final state = _generateState();
    await _storage.setStravaAuthState(state);
    final uri = _buildAuthorizeUri(state);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      await _storage.clearStravaAuthState();
      throw const StravaAuthLaunchException();
    }
  }

  Uri _buildAuthorizeUri(String state) {
    return Uri.https('www.strava.com', '/oauth/authorize', {
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'response_type': 'code',
      'approval_prompt': 'force',
      'access_type': 'offline',
      'scope': 'read,profile:read_all,activity:read_all',
      'state': state,
    });
  }

  String _generateState() {
    final random = Random.secure();
    final values = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(values).replaceAll('=', '');
  }
}

class StravaAuthLaunchException implements Exception {
  const StravaAuthLaunchException();
}
