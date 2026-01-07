import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: AppBootstrap()));
}

class AppBootstrap extends ConsumerWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = ref.watch(appInitProvider);

    return init.when(
      data: (_) => const ProsToApp(),
      loading: () => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, stack) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: Text('Init error: $error')),
        ),
      ),
    );
  }
}
