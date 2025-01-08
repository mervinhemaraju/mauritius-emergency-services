import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBarTheme createAppBarTheme([bool isBrightnessLight = true]) {
  return AppBarTheme(
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          isBrightnessLight ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          isBrightnessLight ? Brightness.dark : Brightness.light,
    ),
  );
}
