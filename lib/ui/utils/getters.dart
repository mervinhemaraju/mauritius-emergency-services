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
SystemUiOverlayStyle getSystemUiOverlayStyle([
  Brightness brightness = Brightness.dark,
]) {
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    // systemNavigationBarIconBrightness:
    //     brightness, // == Brightness.dark ? Brightness.light : Brightness.dark,
    // statusBarIconBrightness: brightness,
  );
}
