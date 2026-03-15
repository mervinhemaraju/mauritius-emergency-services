import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/pages/about/about.dart';
import 'package:mauritius_emergency_services/ui/pages/newfeature/new_feature_view.dart';
import 'package:mauritius_emergency_services/ui/pages/outages/outages_view.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_r_view.dart';
import 'package:mauritius_emergency_services/ui/pages/disclaimer/disclaimer.dart';
import 'package:mauritius_emergency_services/ui/pages/home/home_view.dart';
import 'package:mauritius_emergency_services/ui/pages/precall/precall.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_view.dart';
import 'package:mauritius_emergency_services/ui/pages/settings/settings.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome/welcome.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/routes/router.g.dart';

@riverpod
GoRouter mesAppRouter(Ref ref) {
  // Watch the individual settings flags that affect routing
  final isOnboarded = ref.watch(
    mesSettingsProvider.select((s) => s.isOnboarded),
  );
  final disclaimerAcknowledged = ref.watch(
    mesSettingsProvider.select((s) => s.disclaimerAcknowledged),
  );
  final isAwareOfNewFeature = ref.watch(
    mesSettingsProvider.select((s) => s.isAwareOfNewFeature),
  );

  return GoRouter(
    initialLocation: HomeRoute.path,
    redirect: (context, state) {
      final location = state.matchedLocation;

      // Step 1 — onboarding gate
      if (!isOnboarded) {
        return location == WelcomeRoute.path ? null : WelcomeRoute.path;
      }

      // Step 2 — disclaimer gate
      if (!disclaimerAcknowledged) {
        return location == DisclaimerRoute.path ? null : DisclaimerRoute.path;
      }

      // Step 3 — new feature announcement gate
      if (!isAwareOfNewFeature) {
        return location == NewFeatureRoute.path ? null : NewFeatureRoute.path;
      }

      // Step 4 — prevent going back to onboarding/disclaimer/new feature
      //          once all gates are cleared
      const gatedRoutes = [
        WelcomeRoute.path,
        DisclaimerRoute.path,
        NewFeatureRoute.path,
      ];
      if (gatedRoutes.contains(location)) {
        return HomeRoute.path;
      }

      return null; // no redirect needed
    },
    routes: <RouteBase>[
      GoRoute(
        name: WelcomeRoute.name,
        path: WelcomeRoute.path,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        name: DisclaimerRoute.name,
        path: DisclaimerRoute.path,
        builder: (context, state) => const DisclaimerScreen(),
      ),
      GoRoute(
        name: HomeRoute.name,
        path: HomeRoute.path,
        pageBuilder: (context, state) =>
            const HomeScreen().withScaleTransition(state.pageKey),
      ),
      GoRoute(
        name: ServicesRoute.name,
        path: ServicesRoute.path,
        pageBuilder: (context, state) {
          final query =
              (state.extra
                  as Map<String, dynamic>?)?[ServicesRoute.extraQuery] ??
              "";
          return ServicesScreen(
            searchQuery: query,
          ).withScaleTransition(state.pageKey);
        },
      ),
      GoRoute(
        name: CycloneReportRoute.name,
        path: CycloneReportRoute.path,
        pageBuilder: (context, state) =>
            const CycloneScreen().withScaleTransition(state.pageKey),
      ),
      GoRoute(
        name: OutagesRoute.name,
        path: OutagesRoute.path,
        pageBuilder: (context, state) =>
            const OutagesScreen().withScaleTransition(state.pageKey),
      ),
      GoRoute(
        name: NewFeatureRoute.name,
        path: NewFeatureRoute.path,
        pageBuilder: (context, state) => const NewFeatureAnnouncementScreen()
            .withSlideTransition(state.pageKey),
      ),
      GoRoute(
        name: PrecallRoute.name,
        path: PrecallRoute.path,
        pageBuilder: (context, state) {
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
        pageBuilder: (context, state) =>
            const AboutScreen().withSlideTransition(state.pageKey),
      ),
      GoRoute(
        name: SettingsRoute.name,
        path: SettingsRoute.path,
        pageBuilder: (context, state) =>
            const SettingsScreen().withSlideTransition(state.pageKey),
      ),
    ],
  );
}
