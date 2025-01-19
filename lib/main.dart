import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/providers/local_database.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/routes/router.dart';
import 'package:mauritius_emergency_services/routes/routes.dart';
import 'package:mauritius_emergency_services/data/impl/app_settings_impl.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/generated/objectbox/objectbox.g.dart';
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
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;
  }
}

// The main runner app
main() async {
  // Ensure the widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // TODO(Remove before deploying to prod)
  HttpOverrides.global = MyHttpOverrides();

  // Initialize the shared preferences
  final prefs = await SharedPreferences.getInstance();

  // Intialize the app settings
  final repository = AppSettingsImpl(prefs);

  // Initialize the local DB
  final store = await openStore();

  // Make screen edge to edge
  enableEdgeToEdge();

  // Run the main app
  runApp(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(repository),
          objectBoxProvider.overrideWithValue(store),
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
    // Get the initial location
    final intitialLocation =
        ref.watch(mesSettingsNotifierProvider.select((s) => s.isOnboarded))
            ? HomeRoute.path
            : WelcomeRoute.path;

    // Update the app locale
    ref.watch(
      mesSettingsNotifierProvider.select(
        (s) => LocaleSettings.setLocaleRaw(s.locale.lang),
      ),
    );

    // Set the initial location
    MesAppRouter.instance.setInitialLocation(intitialLocation);

    // Get the router instance
    final router = MesAppRouter.instance.getRouter();

    // Create the text theme
    TextTheme textTheme = createTextTheme(context, "Poppins", "Lato");

    // Create the material theme
    MaterialTheme theme = MaterialTheme(textTheme);

    // Return the Material App
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: t.app.name.capitalizeAll(),
      theme: theme.light(),
      darkTheme: theme.dark(),
      highContrastTheme: theme.lightHighContrast(),
      highContrastDarkTheme: theme.darkHighContrast(),
      themeMode: ref.watch(mesSettingsNotifierProvider.select(
        (s) => s.theme,
      )),
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      routerConfig: router,
    );
  }
}
