import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';

class LanguageDialog extends ConsumerWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return SimpleDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        alignment: Alignment.center,
        child: Text("Choose Language"),
      ),
      children: [
        SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView(
            shrinkWrap: true,
            children: MesLocale.values.map((locale) {
              return ListTile(
                selected: settings.locale == locale,
                selectedColor: Theme.of(context).colorScheme.onTertiary,
                selectedTileColor: Theme.of(context).colorScheme.tertiary,
                title: Text(locale.name.toString()),
                trailing: settings.locale == locale
                    ? Icon(
                        Icons.check_outlined,
                        color: Theme.of(context).colorScheme.onTertiary,
                      )
                    : null,
                onTap: () {
                  ref.read(settingsProvider.notifier).updateLocale(locale);
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
