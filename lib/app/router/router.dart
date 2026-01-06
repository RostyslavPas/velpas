import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/home_screen.dart';
import '../../features/garage/garage_screen.dart';
import '../../features/garage/bike_detail_screen.dart';
import '../../features/garage/bike_form_screen.dart';
import '../../features/components/component_detail_screen.dart';
import '../../features/components/replace_component_screen.dart';
import '../../features/wardrobe/wardrobe_screen.dart';
import '../../features/wardrobe/wardrobe_category_screen.dart';
import '../../features/insights/insights_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/settings/about_screen.dart';
import '../../features/auth/phone_auth_screen.dart';
import '../../features/paywall/paywall_screen.dart';
import '../../core/localization/app_localizations_ext.dart';

final _rootKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/home',
    overridePlatformDefaultLocation: true,
    onException: (context, state, router) {
      final uri = state.uri;
      if (uri.scheme == 'velpas') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          router.go('/home');
        });
      }
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/garage',
                builder: (context, state) => const GarageScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/wardrobe',
                builder: (context, state) => const WardrobeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/insights',
                builder: (context, state) => const InsightsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/garage/add',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const BikeFormScreen(),
      ),
      GoRoute(
        path: '/garage/:id',
        parentNavigatorKey: _rootKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return BikeDetailScreen(bikeId: id);
        },
      ),
      GoRoute(
        path: '/garage/:id/edit',
        parentNavigatorKey: _rootKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return BikeFormScreen(bikeId: id);
        },
      ),
      GoRoute(
        path: '/components/:id',
        parentNavigatorKey: _rootKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ComponentDetailScreen(componentId: id);
        },
      ),
      GoRoute(
        path: '/components/:id/replace',
        parentNavigatorKey: _rootKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ReplaceComponentScreen(componentId: id);
        },
      ),
      GoRoute(
        path: '/wardrobe/category/:category',
        parentNavigatorKey: _rootKey,
        builder: (context, state) {
          final category = state.pathParameters['category']!;
          return WardrobeCategoryScreen(category: category);
        },
      ),
      GoRoute(
        path: '/settings/about',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/settings/auth',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const PhoneAuthScreen(),
      ),
      GoRoute(
        path: '/paywall',
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const PaywallScreen(),
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home), label: context.l10n.homeTitle),
          NavigationDestination(icon: const Icon(Icons.directions_bike), label: context.l10n.garageTitle),
          NavigationDestination(icon: const Icon(Icons.checkroom), label: context.l10n.wardrobeTitle),
          NavigationDestination(icon: const Icon(Icons.insights), label: context.l10n.insightsTitle),
          NavigationDestination(icon: const Icon(Icons.settings), label: context.l10n.settingsTab),
        ],
      ),
    );
  }
}
