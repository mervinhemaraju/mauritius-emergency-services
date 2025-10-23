import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2e628c),
      surfaceTint: Color(0xff2e628c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffcde5ff),
      onPrimaryContainer: Color(0xff0b4a72),
      secondary: Color(0xff51606f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd5e4f6),
      onSecondaryContainer: Color(0xff3a4857),
      tertiary: Color(0xff67587a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffeedcff),
      onTertiaryContainer: Color(0xff4f4061),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff181c20),
      onSurfaceVariant: Color(0xff42474e),
      outline: Color(0xff72777f),
      outlineVariant: Color(0xffc2c7cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff9acbfa),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001d32),
      primaryFixedDim: Color(0xff9acbfa),
      onPrimaryFixedVariant: Color(0xff0b4a72),
      secondaryFixed: Color(0xffd5e4f6),
      onSecondaryFixed: Color(0xff0e1d2a),
      secondaryFixedDim: Color(0xffb9c8da),
      onSecondaryFixedVariant: Color(0xff3a4857),
      tertiaryFixed: Color(0xffeedcff),
      onTertiaryFixed: Color(0xff221533),
      tertiaryFixedDim: Color(0xffd2bfe7),
      onTertiaryFixedVariant: Color(0xff4f4061),
      surfaceDim: Color(0xffd8dadf),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffeceef3),
      surfaceContainerHigh: Color(0xffe6e8ee),
      surfaceContainerHighest: Color(0xffe0e2e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00395b),
      surfaceTint: Color(0xff2e628c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff3e719b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff293846),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff606f7e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3e3050),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff776689),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff0e1115),
      onSurfaceVariant: Color(0xff31373d),
      outline: Color(0xff4e535a),
      outlineVariant: Color(0xff686d74),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff9acbfa),
      primaryFixed: Color(0xff3e719b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff225981),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff606f7e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff485665),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff776689),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5e4e70),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c6cc),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffe6e8ee),
      surfaceContainerHigh: Color(0xffdadde2),
      surfaceContainerHighest: Color(0xffcfd2d7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002f4c),
      surfaceTint: Color(0xff2e628c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff104d75),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1f2d3b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3c4b59),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff342645),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff524364),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff272d33),
      outlineVariant: Color(0xff444a50),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff9acbfa),
      primaryFixed: Color(0xff104d75),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003556),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3c4b59),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff253442),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff524364),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3a2c4c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb6b9be),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeef1f6),
      surfaceContainer: Color(0xffe0e2e8),
      surfaceContainerHigh: Color(0xffd2d4da),
      surfaceContainerHighest: Color(0xffc4c6cc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9acbfa),
      surfaceTint: Color(0xff9acbfa),
      onPrimary: Color(0xff003352),
      primaryContainer: Color(0xff0b4a72),
      onPrimaryContainer: Color(0xffcde5ff),
      secondary: Color(0xffb9c8da),
      onSecondary: Color(0xff233240),
      secondaryContainer: Color(0xff3a4857),
      onSecondaryContainer: Color(0xffd5e4f6),
      tertiary: Color(0xffd2bfe7),
      onTertiary: Color(0xff382a49),
      tertiaryContainer: Color(0xff4f4061),
      onTertiaryContainer: Color(0xffeedcff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101418),
      onSurface: Color(0xffe0e2e8),
      onSurfaceVariant: Color(0xffc2c7cf),
      outline: Color(0xff8c9198),
      outlineVariant: Color(0xff42474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff2e628c),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001d32),
      primaryFixedDim: Color(0xff9acbfa),
      onPrimaryFixedVariant: Color(0xff0b4a72),
      secondaryFixed: Color(0xffd5e4f6),
      onSecondaryFixed: Color(0xff0e1d2a),
      secondaryFixedDim: Color(0xffb9c8da),
      onSecondaryFixedVariant: Color(0xff3a4857),
      tertiaryFixed: Color(0xffeedcff),
      onTertiaryFixed: Color(0xff221533),
      tertiaryFixedDim: Color(0xffd2bfe7),
      onTertiaryFixedVariant: Color(0xff4f4061),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff36393e),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff272a2f),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc2e0ff),
      surfaceTint: Color(0xff9acbfa),
      onPrimary: Color(0xff002842),
      primaryContainer: Color(0xff6495c1),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcedef0),
      onSecondary: Color(0xff182734),
      secondaryContainer: Color(0xff8392a3),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe9d4fd),
      onTertiary: Color(0xff2d1f3e),
      tertiaryContainer: Color(0xff9b8aaf),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101418),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd8dde5),
      outline: Color(0xffadb2ba),
      outlineVariant: Color(0xff8b9198),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff0e4c74),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff001222),
      primaryFixedDim: Color(0xff9acbfa),
      onPrimaryFixedVariant: Color(0xff00395b),
      secondaryFixed: Color(0xffd5e4f6),
      onSecondaryFixed: Color(0xff03121f),
      secondaryFixedDim: Color(0xffb9c8da),
      onSecondaryFixedVariant: Color(0xff293846),
      tertiaryFixed: Color(0xffeedcff),
      onTertiaryFixed: Color(0xff170a28),
      tertiaryFixedDim: Color(0xffd2bfe7),
      onTertiaryFixedVariant: Color(0xff3e3050),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff414549),
      surfaceContainerLowest: Color(0xff05080b),
      surfaceContainerLow: Color(0xff1a1e22),
      surfaceContainer: Color(0xff25282c),
      surfaceContainerHigh: Color(0xff2f3337),
      surfaceContainerHighest: Color(0xff3a3e42),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe6f1ff),
      surfaceTint: Color(0xff9acbfa),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff96c7f6),
      onPrimaryContainer: Color(0xff000c19),
      secondary: Color(0xffe6f1ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb5c4d6),
      onSecondaryContainer: Color(0xff000c19),
      tertiary: Color(0xfff8ecff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffcebbe3),
      onTertiaryContainer: Color(0xff110522),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff101418),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecf0f8),
      outlineVariant: Color(0xffbec3cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e8),
      inversePrimary: Color(0xff0e4c74),
      primaryFixed: Color(0xffcde5ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff9acbfa),
      onPrimaryFixedVariant: Color(0xff001222),
      secondaryFixed: Color(0xffd5e4f6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb9c8da),
      onSecondaryFixedVariant: Color(0xff03121f),
      tertiaryFixed: Color(0xffeedcff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffd2bfe7),
      onTertiaryFixedVariant: Color(0xff170a28),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff4d5055),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1c2024),
      surfaceContainer: Color(0xff2d3135),
      surfaceContainerHigh: Color(0xff383c40),
      surfaceContainerHighest: Color(0xff44474c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
