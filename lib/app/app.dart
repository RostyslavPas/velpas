import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/localization/gen/app_localizations.dart';
import '../features/settings/settings_controller.dart';
import '../features/auth/biometric_gate.dart';
import 'router/router_provider.dart';
import 'theme/velpas_theme.dart';
import 'strava_link_listener.dart';

class VelPasApp extends ConsumerWidget {
  const VelPasApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final router = ref.watch(routerProvider);

    return settings.when(
      data: (state) {
        return MaterialApp.router(
          title: 'VelPas',
          debugShowCheckedModeBanner: false,
          theme: VelPasTheme.dark(),
          routerConfig: router,
          locale: state.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          builder: (context, child) {
            return StravaLinkListener(
              child: BiometricGate(
                enabled: state.biometricsEnabled,
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
        );
      },
      loading: () => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, stack) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
