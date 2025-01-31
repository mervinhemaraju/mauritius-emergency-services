import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/pages/about/about.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_r_view.dart';
import 'package:mauritius_emergency_services/ui/pages/home/home_view.dart';
import 'package:mauritius_emergency_services/ui/pages/precall/precall.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_view.dart';
import 'package:mauritius_emergency_services/ui/pages/settings/settings.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome/welcome.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class MesAppRouter {
  // Private vars
  String _initialLocation = HomeRoute.path;

  // Private constructor
  MesAppRouter._();

  // Single instance
  static final MesAppRouter _instance = MesAppRouter._();

  // Getter for the instance
  static MesAppRouter get instance => _instance;

  // Lazy initialization of the router
  static GoRouter? _router;

  // Method to set initial location
  void setInitialLocation(String location) {
    if (location != _initialLocation) {
      _initialLocation = location;
      _router = null;
    }
  }

  // Get router instance
  GoRouter getRouter() {
    _router ??= _createRouter();
    return _router!;
  }

  // Private method to create the router
  GoRouter _createRouter() {
    return GoRouter(
      initialLocation: _initialLocation,
      routes: <RouteBase>[
        GoRoute(
          name: WelcomeRoute.name,
          path: WelcomeRoute.path,
          builder: (BuildContext context, GoRouterState state) {
            return const WelcomeScreen();
          },
        ),
        GoRoute(
          name: HomeRoute.name,
          path: HomeRoute.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const HomeScreen().withScaleTransition(state.pageKey);
          },
        ),
        GoRoute(
          name: ServicesRoute.name,
          path: ServicesRoute.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            final String query;
            if (state.extra != null) {
              final data = state.extra as Map<String, dynamic>;
              query = data[ServicesRoute.extraQuery];
              // Use data safely here
            } else {
              query = "";
              // Handle case where extra is null
            }
            return ServicesScreen(
              searchQuery: query,
            ).withScaleTransition(state.pageKey);
          },
        ),
        GoRoute(
          name: CycloneReportRoute.name,
          path: CycloneReportRoute.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const CycloneScreen().withScaleTransition(state.pageKey);
          },
        ),
        GoRoute(
          name: PrecallRoute.name,
          path: PrecallRoute.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            final data = state.extra! as Map<String, dynamic>;
            return PreCallScreen(
              service: data[PrecallRoute.extraService],
              number: data[PrecallRoute.extraNumber].toString(),
              onComplete: () => context.goBack(),
            ).withSlideTransition(state.pageKey);
          },
        ),
        GoRoute(
          name: AboutRoute.name,
          path: AboutRoute.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const AboutScreen().withSlideTransition(state.pageKey);
          },
        ),
        GoRoute(
          name: SettingsRoute.name,
          path: SettingsRoute.path,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen().withSlideTransition(state.pageKey);
          },
        ),
      ],
    );
  }
}
