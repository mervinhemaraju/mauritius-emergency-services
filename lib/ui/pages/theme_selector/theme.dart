import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class ThemeDialog extends ConsumerWidget {
  // Constructor
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the settings
    final settings = ref.watch(mesSettingsNotifierProvider);

    // Return the view
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        alignment: Alignment.center,
        child: Text(t.pages.theme_selector.title.capitalizeAll()),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ...ThemeMode.values.map((theme) {
              return RadioListTile<ThemeMode>(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  t.others.themes[theme.name]?.capitalize() ??
                      t.others.themes.entries.first.value.capitalize(),
                ),
                value: theme,
                groupValue: settings.theme,
                onChanged: (ThemeMode? newTheme) {
                  if (newTheme != null) {
                    ref
                        .read(mesSettingsNotifierProvider.notifier)
                        .updateTheme(newTheme);
                  }
                },
              );
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(t.actions.close.capitalize()),
        )
      ],
    );
  }
}
