import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/combined.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class RestrictedPermissions extends ConsumerWidget {
  // Global vars
  final String title;

  // Constructor
  const RestrictedPermissions({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        spacing: 16.0,
        children: [
          Image.asset(
            AssetsManager.STATIC_PERMISSIONS,
            width: 200,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              openAppSettings();
            },
            color: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
            shape: StadiumBorder(),
            child: Text("Open Settings"),
          ),
          MaterialButton(
            onPressed: () {},
            color: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
            shape: StadiumBorder(),
            child: Text("Refresh"),
          )
        ],
      ),
    );
  }
}
