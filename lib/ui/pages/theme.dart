import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/themes.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';

class ThemeDialog extends ConsumerStatefulWidget {
  const ThemeDialog({super.key});

  @override
  ConsumerState<ThemeDialog> createState() => ThemeDialogState();
}

class ThemeDialogState extends ConsumerState<ThemeDialog> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    print("New theme read to be ${settings.theme}");

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Theme Preferences",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            ...MesThemes.values.map((theme) {
              return RadioListTile<MesThemes>(
                title: Text(theme.label),
                value: theme,
                groupValue: settings.theme,
                onChanged: (MesThemes? newTheme) {
                  if (newTheme != null) {
                    ref.read(settingsProvider.notifier).updateTheme(newTheme);
                  }
                },
              );
            }),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 21.0),
                child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("Close")),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MesThemeRadioTile extends StatelessWidget {
  final String title;
  final MesThemes value;
  final MesThemes? groupValue;
  final ValueChanged<MesThemes?> onChanged;

  const MesThemeRadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<MesThemes>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
        ),
      ],
    );
  }
}
