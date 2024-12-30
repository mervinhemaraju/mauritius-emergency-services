import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/home.dart';

//  Entry point for the MES app
class MesMaterialApp extends StatelessWidget {
  const MesMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      title: 'Mauritius Emergency Services',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blueGrey),
      home: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        appBar: AppBar(
          title: const Text("Mauritius Emergency Services"),
          backgroundColor: Colors.blueGrey,
        ),
        body: HomeScreen(),
      ),
    );
  }
}
