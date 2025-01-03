import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/themes.dart';

class ThemeDialog extends StatefulWidget {
  const ThemeDialog({super.key});

  @override
  State<ThemeDialog> createState() => ThemeDialogState();
}

class ThemeDialogState extends State<ThemeDialog> {
  MesThemes? _character = MesThemes.followSystem;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
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
            MesThemeRadioTile(
              title: "Follow System",
              value: MesThemes.followSystem,
              groupValue: _character,
              onChanged: (MesThemes? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            MesThemeRadioTile(
              title: "Light",
              value: MesThemes.light,
              groupValue: _character,
              onChanged: (MesThemes? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            MesThemeRadioTile(
              title: "Dark",
              value: MesThemes.dark,
              groupValue: _character,
              onChanged: (MesThemes? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
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
