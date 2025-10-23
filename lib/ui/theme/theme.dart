import "package:flutter/material.dart";
import "package:mauritius_emergency_services/ui/theme/ui.dart";
import "package:mauritius_emergency_services/ui/utils/extensions.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  ThemeData build(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.primary,
        contentTextStyle: TextStyle(
          color: colorScheme.onPrimary,
        ),
      ),
      appBarTheme: createAppBarTheme(colorScheme.brightness),
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.tintedSurface(),
      canvasColor: colorScheme.surface,
    );
  }
}
