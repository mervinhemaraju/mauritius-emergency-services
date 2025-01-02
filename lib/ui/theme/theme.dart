import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mauritius_emergency_services/ui/theme/color_extended.dart";

class MaterialTheme {
  final TextTheme textTheme;
  final AppBarTheme appBarTheme;

  const MaterialTheme(
    this.textTheme,
    this.appBarTheme,
  );

  // Light + Normal Contrast Scheme
  ThemeData light() {
    return theme(const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF3B608F),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD4E3FF),
      onPrimaryContainer: Color(0xFF001C39),
      secondary: Color(0xFF545F71),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD8E3F8),
      onSecondaryContainer: Color(0xFF111C2B),
      tertiary: Color(0xFF7F4D7A),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFD7F6),
      onTertiaryContainer: Color(0xFF330833),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surface: Color(0xFFF8F9FF),
      onSurface: Color(0xFF191C20),
      onSurfaceVariant: Color(0xFF41484D),
      surfaceTint: Color(0xFFDDE3EA),
      outline: Color(0xFF71787E),
      outlineVariant: Color(0xFFC1C7CD),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2F3036),
      onInverseSurface: Color(0xFFF1F0F7),
      inversePrimary: Color(0xFFA4C9FE),
      surfaceDim: Color(0xFFDAD9E0),
      surfaceBright: Color(0xFFFAF8FF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF4F3FA),
      surfaceContainer: Color(0xFFEEEDF4),
      surfaceContainerHigh: Color(0xFFE8E7EF),
      surfaceContainerHighest: Color(0xFFE2E2E9),
    ));
  }

  // Light + Medium Contrast Scheme
  ThemeData lightMediumContrast() {
    return theme(
      const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF1B4472),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFF5276A7),
        onPrimaryContainer: Color(0xFFFFFFFF),
        secondary: Color(0xFF394354),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFF6A7587),
        onSecondaryContainer: Color(0xFFFFFFFF),
        tertiary: Color(0xFF61325D),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFF986391),
        onTertiaryContainer: Color(0xFFFFFFFF),
        error: Color(0xFF8C0009),
        onError: Color(0xFFFFFFFF),
        errorContainer: Color(0xFFDA342E),
        onErrorContainer: Color(0xFFFFFFFF),
        surface: Color(0xFFF8F9FF),
        surfaceTint: Color(0xFFDDE3EA),
        onSurface: Color(0xFF191C20),
        onSurfaceVariant: Color(0xFF3D4449),
        outline: Color(0xFF596065),
        outlineVariant: Color(0xFF757C81),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFF2F3036),
        onInverseSurface: Color(0xFFF1F0F7),
        inversePrimary: Color(0xFFA4C9FE),
        surfaceDim: Color(0xFFDAD9E0),
        surfaceBright: Color(0xFFFAF8FF),
        surfaceContainerLowest: Color(0xFFFFFFFF),
        surfaceContainerLow: Color(0xFFF4F3FA),
        surfaceContainer: Color(0xFFEEEDF4),
        surfaceContainerHigh: Color(0xFFE8E7EF),
        surfaceContainerHighest: Color(0xFFE2E2E9),
      ),
    );
  }

  // Light + High Contrast Scheme
  ThemeData lightHighContrast() {
    return theme(
      const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF002344),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFF1B4472),
        onPrimaryContainer: Color(0xFFFFFFFF),
        secondary: Color(0xFF182332),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFF394354),
        onSecondaryContainer: Color(0xFFFFFFFF),
        tertiary: Color(0xFF3B103A),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFF61325D),
        onTertiaryContainer: Color(0xFFFFFFFF),
        error: Color(0xFF4E0002),
        onError: Color(0xFFFFFFFF),
        errorContainer: Color(0xFF8C0009),
        onErrorContainer: Color(0xFFFFFFFF),
        surface: Color(0xFFF8F9FF),
        onSurface: Color(0xFF191C20),
        surfaceTint: Color(0xFFDDE3EA),
        onSurfaceVariant: Color(0xFF1E2529),
        outline: Color(0xFF3D4449),
        outlineVariant: Color(0xFF3D4449),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFF2F3036),
        onInverseSurface: Color(0xFFFFFFFF),
        inversePrimary: Color(0xFFE3ECFF),
        surfaceDim: Color(0xFFDAD9E0),
        surfaceBright: Color(0xFFFAF8FF),
        surfaceContainerLowest: Color(0xFFFFFFFF),
        surfaceContainerLow: Color(0xFFF4F3FA),
        surfaceContainer: Color(0xFFEEEDF4),
        surfaceContainerHigh: Color(0xFFE8E7EF),
        surfaceContainerHighest: Color(0xFFE2E2E9),
      ),
    );
  }

  // Dark + Normal Contrast Scheme
  ThemeData dark() {
    return theme(
      const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFA4C9FE),
        onPrimary: Color(0xFF00315D),
        primaryContainer: Color(0xFF204876),
        onPrimaryContainer: Color(0xFFD4E3FF),
        secondary: Color(0xFFBCC7DB),
        onSecondary: Color(0xFF263141),
        secondaryContainer: Color(0xFF3C4758),
        onSecondaryContainer: Color(0xFFD8E3F8),
        tertiary: Color(0xFFF1B3E7),
        onTertiary: Color(0xFF4C1F49),
        tertiaryContainer: Color(0xFF653661),
        onTertiaryContainer: Color(0xFFFFD7F6),
        error: Color(0xFFE57373),
        onError: Color(0xFF690005),
        errorContainer: Color(0xFF93000A),
        onErrorContainer: Color(0xFFFFDAD6),
        surface: Color(0xFF111318),
        onSurface: Color(0xFFE1E2E9),
        surfaceTint: Color(0xFF41484D),
        onSurfaceVariant: Color(0xFFC1C7CD),
        outline: Color(0xFF8B9297),
        outlineVariant: Color(0xFF41484D),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFFE2E2E9),
        onInverseSurface: Color(0xFF2F3036),
        inversePrimary: Color(0xFF3B608F),
        surfaceDim: Color(0xFF121318),
        surfaceBright: Color(0xFF38393F),
        surfaceContainerLowest: Color(0xFF0D0E13),
        surfaceContainerLow: Color(0xFF1A1B21),
        surfaceContainer: Color(0xFF1E1F25),
        surfaceContainerHigh: Color(0xFF282A2F),
        surfaceContainerHighest: Color(0xFF33343A),
      ),
    );
  }

  // Dark + Medium Contrast Scheme
  ThemeData darkMediumContrast() {
    return theme(
      const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFABCDFF),
        onPrimary: Color(0xFF001730),
        primaryContainer: Color(0xFF6E93C5),
        onPrimaryContainer: Color(0xFF000000),
        secondary: Color(0xFFC0CBE0),
        onSecondary: Color(0xFF0B1726),
        secondaryContainer: Color(0xFF8691A4),
        onSecondaryContainer: Color(0xFF000000),
        tertiary: Color(0xFFF5B7EB),
        onTertiary: Color(0xFF2D032D),
        tertiaryContainer: Color(0xFFB67EAF),
        onTertiaryContainer: Color(0xFF000000),
        error: Color(0xFFFFBAB1),
        onError: Color(0xFF370001),
        errorContainer: Color(0xFFFF5449),
        onErrorContainer: Color(0xFF000000),
        surface: Color(0xFF111318),
        onSurface: Color(0xFFE1E2E9),
        surfaceTint: Color(0xFF41484D),
        onSurfaceVariant: Color(0xFFC5CCD2),
        outline: Color(0xFF9DA4AA),
        outlineVariant: Color(0xFF7D848A),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFFE2E2E9),
        onInverseSurface: Color(0xFF282A2F),
        inversePrimary: Color(0xFF214977),
        surfaceDim: Color(0xFF121318),
        surfaceBright: Color(0xFF38393F),
        surfaceContainerLowest: Color(0xFF0D0E13),
        surfaceContainerLow: Color(0xFF1A1B21),
        surfaceContainer: Color(0xFF1E1F25),
        surfaceContainerHigh: Color(0xFF282A2F),
        surfaceContainerHighest: Color(0xFF33343A),
      ),
    );
  }

  // Dark + High Contrast Scheme
  ThemeData darkHighContrast() {
    return theme(
      const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFFBFAFF),
        onPrimary: Color(0xFF000000),
        primaryContainer: Color(0xFFABCDFF),
        onPrimaryContainer: Color(0xFF000000),
        secondary: Color(0xFFFBFAFF),
        onSecondary: Color(0xFF000000),
        secondaryContainer: Color(0xFFC0CBE0),
        onSecondaryContainer: Color(0xFF000000),
        tertiary: Color(0xFFFFF9FA),
        onTertiary: Color(0xFF000000),
        tertiaryContainer: Color(0xFFF5B7EB),
        onTertiaryContainer: Color(0xFF000000),
        error: Color(0xFFFFF9F9),
        onError: Color(0xFF000000),
        errorContainer: Color(0xFFFFBAB1),
        onErrorContainer: Color(0xFF000000),
        surface: Color(0xFF111318),
        onSurface: Color(0xFFE1E2E9),
        surfaceTint: Color(0xFF41484D),
        onSurfaceVariant: Color(0xFFF8FBFF),
        outline: Color(0xFFC5CCD2),
        outlineVariant: Color(0xFFC5CCD2),
        scrim: Color(0xFF000000),
        inverseSurface: Color(0xFFE2E2E9),
        onInverseSurface: Color(0xFF000000),
        inversePrimary: Color(0xFF002B52),
        surfaceDim: Color(0xFF121318),
        surfaceBright: Color(0xFF38393F),
        surfaceContainerLowest: Color(0xFF0D0E13),
        surfaceContainerLow: Color(0xFF1A1B21),
        surfaceContainer: Color(0xFF1E1F25),
        surfaceContainerHigh: Color(0xFF282A2F),
        surfaceContainerHighest: Color(0xFF33343A),
      ),
    );
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        appBarTheme: appBarTheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}
