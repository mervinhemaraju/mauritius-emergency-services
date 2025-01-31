import 'package:flutter/material.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  // Get the base text theme
  TextTheme baseTextTheme = Theme.of(context).textTheme;

  // Configure the body text theme
  // from the base text theme
  // TextTheme bodyTextTheme = baseTextTheme.apply(fontFamily: bodyFontString);

  TextTheme mainTextTheme = baseTextTheme.copyWith(
    // Headlines & Titles
    displayLarge: baseTextTheme.displayLarge?.copyWith(
      fontFamily: displayFontString,
      fontWeight: FontWeight.bold,
      fontSize: 104.0,
    ),
    displayMedium: baseTextTheme.displayMedium?.copyWith(
      fontFamily: displayFontString,
      fontWeight: FontWeight.w500,
      fontSize: 80.0,
    ),
    displaySmall: baseTextTheme.displaySmall?.copyWith(
      fontFamily: displayFontString,
      fontWeight: FontWeight.normal,
      fontSize: 64.0,
    ),
    headlineLarge: baseTextTheme.headlineLarge?.copyWith(
      fontFamily: displayFontString,
      fontWeight: FontWeight.bold,
      fontSize: 56.0,
    ),
    headlineMedium: baseTextTheme.headlineMedium?.copyWith(
      fontFamily: displayFontString,
      fontSize: 48.0,
    ),
    headlineSmall: baseTextTheme.headlineSmall?.copyWith(
      fontFamily: displayFontString,
    ),
    titleLarge: baseTextTheme.titleLarge?.copyWith(
      fontFamily: displayFontString,
    ),
    titleMedium: baseTextTheme.titleMedium?.copyWith(
      fontFamily: displayFontString,
    ),
    titleSmall: baseTextTheme.titleSmall?.copyWith(
      fontFamily: displayFontString,
    ),

    // Body and Captions
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(
      fontFamily: bodyFontString,
    ),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(
      fontFamily: bodyFontString,
    ),
    bodySmall: baseTextTheme.bodySmall?.copyWith(
      fontFamily: bodyFontString,
    ),
    labelLarge: baseTextTheme.labelLarge?.copyWith(
      fontFamily: bodyFontString,
    ),
    labelMedium: baseTextTheme.labelMedium?.copyWith(
      fontFamily: bodyFontString,
      fontSize: 12.0,
    ),
    labelSmall: baseTextTheme.labelSmall?.copyWith(
      fontFamily: bodyFontString,
      fontWeight: FontWeight.bold,
      fontSize: 10.0,
    ),
  );

  // Return the text theme
  return mainTextTheme;
}
