// Returns a Duration based on the cyclone level
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Duration getRotationSpeedFromCycloneLevel({required int level}) {
  switch (level) {
    case 1:
      return const Duration(seconds: 7); // Slowest
    case 2:
      return const Duration(seconds: 4);
    case 3:
      return const Duration(seconds: 2);
    case 4:
      return const Duration(seconds: 1); // Fastest
    default:
      return const Duration(seconds: 7); // Default speed
  }
}

// Returns the system UI overlay style
SystemUiOverlayStyle getSystemUiOverlayStyle(
  Brightness brightness, {
  Color statusBarColor = Colors.transparent,
  Color systemNavigationBarColor = Colors.transparent,
}) {
  return SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    systemNavigationBarColor: systemNavigationBarColor,
    statusBarIconBrightness: brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark,
  );
}

void enableEdgeToEdge() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
}
