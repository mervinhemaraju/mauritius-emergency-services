import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';

class LanguageDialog extends ConsumerStatefulWidget {
  const LanguageDialog({super.key});

  @override
  ConsumerState<LanguageDialog> createState() => LanguageDialogState();
}

class LanguageDialogState extends ConsumerState<LanguageDialog> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Choose Language",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            ...MesLocale.values.map((locale) {
              return ListTile(
                selected: settings.locale == locale,
                selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
                selectedTileColor:
                    Theme.of(context).colorScheme.primaryContainer,
                title: Text(locale.name.toString()),
                trailing:
                    settings.locale == locale ? Icon(Icons.check_circle) : null,
                onTap: () {
                  ref.read(settingsProvider.notifier).updateLocale(locale);
                },
              );
            }),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 21.0,
                ),
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
