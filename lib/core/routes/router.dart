import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/pages/about.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone.dart';
import 'package:mauritius_emergency_services/ui/pages/home/home.dart';
import 'package:mauritius_emergency_services/ui/pages/precall.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services.dart';
import 'package:mauritius_emergency_services/ui/pages/settings/settings.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome.dart';

class MesAppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: WelcomeRoute.path,
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
          return CustomTransitionPage(
            key: state.pageKey,
            child: HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: Tween<double>(
                  begin: 0.95,
                  end: 1.0,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: ServicesRoute.name,
        path: ServicesRoute.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: ServicesScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: Tween<double>(
                  begin: 0.95,
                  end: 1.0,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: CycloneReportRoute.name,
        path: CycloneReportRoute.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: CycloneScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: Tween<double>(
                  begin: 0.95,
                  end: 1.0,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: PrecallRoute.name,
        path: PrecallRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          final data = state.extra! as Map<String, dynamic>;
          return PreCallScreen(
            service: data[PrecallRoute.extraService],
          );
        },
      ),
      GoRoute(
        name: AboutRoute.name,
        path: AboutRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AboutScreen();
        },
      ),
      GoRoute(
        name: SettingsRoute.name,
        path: SettingsRoute.path,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsScreen();
        },
      ),
    ],
  );
}
