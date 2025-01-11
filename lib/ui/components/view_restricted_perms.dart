import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class RestrictedPermissions extends ConsumerWidget {
  // Global vars
  final String title;
  final Function() onReferesh;

  // Constructor
  const RestrictedPermissions({
    super.key,
    required this.title,
    required this.onReferesh,
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
        spacing: 8.0,
        children: [
          Image.asset(
            AssetsManager.STATIC_PERMISSIONS,
            width: 200,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 16.0,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Click refresh after granting permissions.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                MaterialButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  onPressed: () {
                    openAppSettings();
                  },
                  color: theme.colorScheme.primary,
                  textColor: theme.colorScheme.onPrimary,
                  shape: StadiumBorder(),
                  child: Text("Open Settings"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                MaterialButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  onPressed: onReferesh,
                  color: theme.colorScheme.primary,
                  textColor: theme.colorScheme.onPrimary,
                  shape: StadiumBorder(),
                  child: Text("Refresh"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
