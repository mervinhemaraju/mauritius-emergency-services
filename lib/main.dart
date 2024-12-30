import 'package:flutter/material.dart';
import 'dart:io';
import 'package:mauritius_emergency_services/ui/material_app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// The main runner app
void main() {
  // TODO(To review this override)
  HttpOverrides.global = MyHttpOverrides();
  runApp(MesMaterialApp());
}
