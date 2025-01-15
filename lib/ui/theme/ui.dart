import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/ui/utils/getters.dart';

AppBarTheme createAppBarTheme([Brightness brightness = Brightness.light]) {
  return AppBarTheme(
    backgroundColor: Colors.transparent,
    systemOverlayStyle: getSystemUiOverlayStyle(brightness),
  );
}
