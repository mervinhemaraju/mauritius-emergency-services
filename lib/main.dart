// import 'dart:io';
import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/routes/router.dart';
import 'package:mauritius_emergency_services/routes/routes.dart';
import 'package:mauritius_emergency_services/data/impl/app_settings_impl.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/theme/colors.dart';
import 'package:mauritius_emergency_services/ui/theme/theme.dart';
import 'package:mauritius_emergency_services/ui/theme/typography.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/utils/getters.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Only enable this for development purposes
// ad the following in main() -> HttpOverrides.global = MyHttpOverrides();
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// The main runner app
main() async {
  // Ensure the widgets are initialized
  final binding = WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  // Preserve the splash screen
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  // Initialize the shared preferences
  final prefs = await SharedPreferences.getInstance();

  // Intialize the app settings
  final repository = AppSettingsImpl(prefs);

  // Make screen edge to edge
  enableEdgeToEdge();

  // Remove splash now as the main content has been loaded
  FlutterNativeSplash.remove();

  // Run the main app
  runApp(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(
            repository,
          ),
        ],
        child: const MesMaterialApp(),
      ),
    ),
  );
}

class MesMaterialApp extends ConsumerWidget {
  const MesMaterialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve setting flags
    final isOnboarded = ref.watch(
      mesSettingsProvider.select((s) => s.isOnboarded),
    );
    final disclaimerAcknowledged = ref.watch(
      mesSettingsProvider.select(
        (s) => s.disclaimerAcknowledged,
      ),
    );

    // Determine the initial location
    String initialLocation = switch ((
      isOnboarded,
      disclaimerAcknowledged,
    )) {
      (false, _) => WelcomeRoute.path,
      (true, false) => DisclaimerRoute.path,
      (true, true) => HomeRoute.path,
    };

    // Get the theme mode
    final themeMode = ref.watch(
      mesSettingsProvider.select((s) => s.theme),
    );

    // Get the dynamic color activation
    final isDynamicEnabled = ref.watch(
      mesSettingsProvider.select((s) => s.isDynamicEnabled),
    );

    // Update the app locale
    ref.watch(
      mesSettingsProvider.select(
        (s) => LocaleSettings.setLocaleRaw(s.locale.lang),
      ),
    );

    // Set the initial location
    MesAppRouter.instance.setInitialLocation(initialLocation);

    // Get the router instance
    final router = MesAppRouter.instance.getRouter();

    // Create the text theme
    TextTheme textTheme = createTextTheme(
      context,
      "Poppins",
      "Lato",
    );

    // Create the material theme
    MaterialTheme theme = MaterialTheme(textTheme);

    // Dynamic color builder for Material YOU
    return DynamicColorBuilder(
      builder:
          (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            // Build the condition for dynamic color eligibility
            final bool isEligibleForDc =
                (lightDynamic != null && darkDynamic != null) &&
                isDynamicEnabled;

            // Build light and dark color schemes
            final ThemeData lightTheme = isEligibleForDc
                ? theme.build(lightDynamic.harmonized())
                : theme.build(MesColorSchemes.light);
            final ThemeData darkTheme = isEligibleForDc
                ? theme.build(darkDynamic.harmonized())
                : theme.build(MesColorSchemes.dark);

            // Return the Material App
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: t.app.name.capitalizeAll(),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              locale: TranslationProvider.of(
                context,
              ).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates:
                  GlobalMaterialLocalizations.delegates,
              routerConfig: router,
            );
          },
    );
  }
}
