import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/routes/router.dart';
import 'package:mauritius_emergency_services/data/contracts/settings/app_settings_impl.dart';
import 'package:mauritius_emergency_services/data/contracts/settings/app_settings_repository.dart';
import 'package:mauritius_emergency_services/data/local/preferences/settings_provider.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/theme/colors.dart';
import 'package:mauritius_emergency_services/ui/theme/theme.dart';
import 'package:mauritius_emergency_services/ui/theme/typography.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/utils/getters.dart';
import 'package:shared_preferences/shared_preferences.dart';

// The main runner app
void main() async {
  // Ensure the widgets are initialized
  final binding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the splash screen
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  // Initialize the shared preferences
  final prefs = await SharedPreferences.getInstance();

  // Intialize the app settings
  final AppSettingsRepository repository = AppSettingsImpl(prefs);

  // Make screen edge to edge
  enableEdgeToEdge();

  // Remove splash now as the main content has been loaded
  FlutterNativeSplash.remove();

  // Run the main app
  runApp(
    TranslationProvider(
      child: ProviderScope(
        overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
        child: const MesMaterialApp(),
      ),
    ),
  );
}

class MesMaterialApp extends ConsumerWidget {
  const MesMaterialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(mesSettingsProvider.select((s) => s.theme));
    final isDynamicEnabled = ref.watch(
      mesSettingsProvider.select((s) => s.isDynamicEnabled),
    );

    // Update locale reactively
    ref.watch(
      mesSettingsProvider.select(
        (s) => LocaleSettings.setLocaleRaw(s.locale.lang),
      ),
    );

    // Get the router from the provider — rebuilds automatically when
    // settings flags change, so redirects fire immediately
    final router = ref.watch(mesAppRouterProvider);

    final textTheme = createTextTheme(context, "Poppins", "Lato");
    final theme = MaterialTheme(textTheme);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final isEligibleForDc =
            (lightDynamic != null && darkDynamic != null) && isDynamicEnabled;

        final lightTheme = isEligibleForDc
            ? theme.build(lightDynamic.harmonized())
            : theme.build(MesColorSchemes.light);
        final darkTheme = isEligibleForDc
            ? theme.build(darkDynamic.harmonized())
            : theme.build(MesColorSchemes.dark);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: t.app.name.capitalizeAll(),
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          routerConfig: router,
        );
      },
    );
  }
}
