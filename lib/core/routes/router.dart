import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/pages/about.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone.dart';
import 'package:mauritius_emergency_services/ui/pages/home.dart';
import 'package:mauritius_emergency_services/ui/pages/precall.dart';
import 'package:mauritius_emergency_services/ui/pages/services.dart';
import 'package:mauritius_emergency_services/ui/pages/settings.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome.dart';

class MesAppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: MesRoutes.welcome,
    routes: <RouteBase>[
      GoRoute(
        path: MesRoutes.welcome,
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeScreen();
        },
      ),
      GoRoute(
        path: MesRoutes.home,
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
        path: MesRoutes.services,
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
        path: MesRoutes.cycloneReport,
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
        path: MesRoutes.about,
        builder: (BuildContext context, GoRouterState state) {
          return const AboutScreen();
        },
      ),
      GoRoute(
        path: MesRoutes.settings,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsScreen();
        },
      ),
      GoRoute(
        path: MesRoutes.precall,
        builder: (BuildContext context, GoRouterState state) {
          return const PreCallScreen();
        },
      ),
    ],
  );
}
