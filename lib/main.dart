import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';
import 'package:mauritius_emergency_services/core/routes/router.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/data/impl/app_settings_impl.dart';
import 'package:mauritius_emergency_services/ui/theme/theme.dart';
import 'package:mauritius_emergency_services/ui/theme/typography.dart';
import 'package:mauritius_emergency_services/ui/theme/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final repository = AppSettingsImpl(prefs);

  // TODO(To review this override)
  HttpOverrides.global = MyHttpOverrides();

  // Make screen edge to edge
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  // Run the main app
  runApp(
    ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(repository),
      ],
      child: MesMaterialApp(),
    ),
  );
}

class MesMaterialApp extends ConsumerWidget {
  MesMaterialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the initial location
    final intitialLocation =
        ref.watch(settingsProvider.select((s) => s.isOnboarded))
            ? HomeRoute.path
            : WelcomeRoute.path;

    // Set the initial location
    MesAppRouter.instance.setInitialLocation(intitialLocation);

    // Get the router instance
    final router = MesAppRouter.instance.getRouter();

    // Determine the app brightness (theme)
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Create the text theme
    TextTheme textTheme = createTextTheme(context, "Poppins", "Lato");

    // Create the app bar theme
    AppBarTheme appBarTheme = createAppBarTheme(
      brightness == Brightness.light,
    );

    // Create the material theme
    MaterialTheme theme = MaterialTheme(
      textTheme,
      appBarTheme,
    );

    // Return the Material App
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      title: 'Flutter Demo',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ref.watch(settingsProvider.select(
        (s) => s.theme,
      )),
      highContrastTheme: theme.lightHighContrast(),
      highContrastDarkTheme: theme.darkHighContrast(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(settingsProvider.select(
        (s) => s.locale == MesLocale.system ? null : Locale(s.locale.lang),
      )),
      routerConfig: router,
    );
  }
}
