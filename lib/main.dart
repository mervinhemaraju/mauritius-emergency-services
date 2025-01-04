import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/settings_notifier.dart';
import 'package:mauritius_emergency_services/core/routes/router.dart';
import 'package:mauritius_emergency_services/ui/theme/theme.dart';
import 'package:mauritius_emergency_services/ui/theme/typography.dart';
import 'package:mauritius_emergency_services/ui/theme/ui.dart';

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
  // TODO(To review this override)
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  // Run the main app
  runApp(
    ProviderScope(
      child: MesMaterialApp(),
    ),
  );
}

class MesMaterialApp extends ConsumerWidget {
  MesMaterialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine the app brightness (theme)
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Create the text theme
    TextTheme textTheme = createTextTheme(context, "Poppins", "Lato");

    // Create the app bar theme
    AppBarTheme appBarTheme = createAppBarTheme(brightness == Brightness.light);

    // Create the material theme
    MaterialTheme theme = MaterialTheme(
      textTheme,
      appBarTheme,
    );

    // Return the Material App
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: MesAppRouter.router,
    );
  }
}
