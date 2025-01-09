import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/themes.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';
import 'package:mauritius_emergency_services/core/routes/router.dart';
import 'package:mauritius_emergency_services/data/repository/settings_repository.dart';
import 'package:mauritius_emergency_services/ui/theme/theme.dart';
import 'package:mauritius_emergency_services/ui/theme/typography.dart';
import 'package:mauritius_emergency_services/ui/theme/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

// FIXME(Fix issue with alertdialogs where selected items are overlapping with title)
// TODO(Replace report testing by prod one after ensuring cyclone UI is done)
// TODO(Add contrast change in theme selector)
// TODO(Review all app UI & theme)
// TODO(Implement app locale)
// TODO(Allow user to change locale in app)
// TODO(Implement dynamic color change)
// TODO(Implement pre call screen)
// TODO(Implement welcome screen)
// TODO(Implement search functionality)
// TODO(Review adaptive UI)
// TODO(Implement offline services availability)
// TODO(Implement notifications for cyclone)
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
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final repository = SettingsRepositoryImpl(prefs);

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
    final settings = ref.watch(settingsProvider);

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

    // Determine the app brightness (theme)
    var brightnessUsed = switch (settings.theme) {
      MesThemes.light => theme.light(),
      MesThemes.dark => theme.dark(),
      MesThemes.followSystem =>
        brightness == Brightness.light ? theme.light() : theme.dark(),
    };

    // Return the Material App
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      title: 'Flutter Demo',
      theme: brightnessUsed,
      routerConfig: MesAppRouter.router,
    );
  }
}
