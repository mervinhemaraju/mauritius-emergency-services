import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';

class PermissionsDialog extends ConsumerWidget {
  // Constructor
  const PermissionsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return SimpleDialog(
      children: [
        Image.asset(
          AssetsManager.STATIC_PERMISSIONS,
          width: 100,
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Mes needs permission to proceed",
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "To provide the best experience, the app requires permission to make and manage phone calls, as this is its main feature.",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "We also request notification access to keep you informed and up to date.",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Please grant these permissions to continue using the app seamlessly. If it doesn't work, then you'll need to do it manually in the settings.",
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: MaterialButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            color: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
            shape: StadiumBorder(),
            child: Text("Proceed"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: OutlinedButton(
            onPressed: () {
              context.pop();
            },
            child: Text("Cancel"),
          ),
        ),
      ],
    );
  }
}
