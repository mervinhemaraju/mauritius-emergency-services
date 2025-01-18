import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/gen/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class PermissionsDialog extends ConsumerWidget {
  // Global vars
  final Function() onComplete;
  final Function() onProceed;

  // Constructor
  const PermissionsDialog({
    super.key,
    required this.onComplete,
    required this.onProceed,
  });

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
            t.pages.welcome.permissions_dialog
                .primary_text(
                  app_name_short: t.app.short_name.toUpperCase(),
                )
                .capitalizeAll(),
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
            t.pages.welcome.permissions_dialog.secondary_text.capitalize(),
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            t.pages.welcome.permissions_dialog.tertiary_text.capitalize(),
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            t.pages.welcome.permissions_dialog.quaternary_text.capitalize(),
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        _PermissionsActions(
          onProceed: onProceed,
          onCancel: onComplete,
        )
      ],
    );
  }
}

class _PermissionsActions extends StatelessWidget {
  final Function() onProceed;
  final Function() onCancel;

  const _PermissionsActions({
    required this.onProceed,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        spacing: 16.0,
        children: [
          MaterialButton(
            onPressed: onProceed,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            color: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
            shape: const StadiumBorder(),
            child: Text(t.actions.proceed.capitalize()),
          ),
          OutlinedButton(
            onPressed: onCancel,
            child: Text(t.actions.cancel.capitalize()),
          ),
        ],
      ),
    );
  }
}
