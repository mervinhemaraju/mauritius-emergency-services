import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome/perms.dart';

class PermissionsDialog extends ConsumerWidget {
  // Constructor
  const PermissionsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define the theme
    final theme = Theme.of(context);

    // Get the permissions state
    final permissionsState = ref.watch(permissionsStateProvider);

    // Listen to permission state changes
    ref.listen(permissionsStateProvider, (previous, next) {
      next.whenData((isGranted) {
        // Mark the user as onboarded
        ref.read(settingsProvider.notifier).markAsOnboarded();

        // Navigate to home page whether permissions were granted or denied
        context.go(HomeRoute.path);
      });
    });

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
        permissionsState.when(
          data: (_) => _PermissionsActions(
            onProceed: () => ref
                .read(permissionsStateProvider.notifier)
                .requestPermissions(),
            onCancel: () {
              // Navigate to home page even if user cancels
              context.pop();
            },
          ),
          error: (error, stack) => _PermissionsActions(
            onProceed: () => ref
                .read(permissionsStateProvider.notifier)
                .requestPermissions(),
            onCancel: () => context.goNamed(HomeRoute.path),
          ),
          loading: () => LoadingScreen(),
        ),
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
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            color: theme.colorScheme.primary,
            textColor: theme.colorScheme.onPrimary,
            shape: StadiumBorder(),
            child: Text("Proceed"),
          ),
          OutlinedButton(
            onPressed: onCancel,
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
