import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';

class ThemeDialog extends ConsumerWidget {
  // Constructor
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the settings
    final settings = ref.watch(settingsProvider);

    // FIXME(Issue with dialog on Landscape)
    // Return the view
    return AlertDialog(
      title: Text(
        "Theme Preferences",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ...ThemeMode.values.map((theme) {
            return RadioListTile<ThemeMode>(
              contentPadding: EdgeInsets.zero,
              title: Text(theme.name),
              value: theme,
              groupValue: settings.theme,
              onChanged: (ThemeMode? newTheme) {
                if (newTheme != null) {
                  ref.read(settingsProvider.notifier).updateTheme(newTheme);
                }
              },
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text("Close"),
        )
      ],
    );
  }
}
