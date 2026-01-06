import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/models/strava_models.dart';
import '../core/providers.dart';
import '../features/settings/settings_controller.dart';

class StravaLinkListener extends ConsumerStatefulWidget {
  const StravaLinkListener({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<StravaLinkListener> createState() => _StravaLinkListenerState();
}

class _StravaLinkListenerState extends ConsumerState<StravaLinkListener> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;

  @override
  void initState() {
    super.initState();
    _initLinks();
  }

  Future<void> _initLinks() async {
    final initial = await _appLinks.getInitialLink();
    if (initial != null) {
      await _handleUri(initial);
    }
    _subscription = _appLinks.uriLinkStream.listen(_handleUri);
  }

  Future<void> _handleUri(Uri uri) async {
    if (!_isStravaCallback(uri)) return;

    final storage = ref.read(secureStorageServiceProvider);
    final incomingState = uri.queryParameters['state'];
    final expectedState = await storage.getStravaAuthState();
    if (!mounted) return;
    if (expectedState != null &&
        incomingState != null &&
        expectedState != incomingState) {
      await storage.clearStravaAuthState();
      return;
    }

    final error = uri.queryParameters['error'];
    if (error != null) {
      await ref.read(settingsControllerProvider.notifier).disconnectStrava();
      await storage.clearStravaAuthState();
      return;
    }

    final accessToken = uri.queryParameters['access_token'];
    final refreshToken = uri.queryParameters['refresh_token'];
    final expiresAt = StravaTokens.parseExpiresAt(uri.queryParameters['expires_at']);
    if (accessToken == null || refreshToken == null || expiresAt == null) {
      return;
    }

    final tokens = StravaTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
      athleteId: uri.queryParameters['athlete_id'],
    );

    await ref.read(settingsControllerProvider.notifier).applyStravaTokens(tokens);
    await storage.clearStravaAuthState();
  }

  bool _isStravaCallback(Uri uri) {
    if (uri.scheme != 'velpas' || uri.host != 'oauth') return false;
    return uri.path == '/strava' || uri.path == 'strava';
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
