import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/providers/services_providers.dart';
import 'package:mauritius_emergency_services/core/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/gen/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class LanguageDialog extends ConsumerWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(mesSettingsNotifierProvider);

    return SimpleDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        alignment: Alignment.center,
        child: Text(
          t.pages.settings.section_application.change_language.sheet_title
              .capitalizeAll(),
        ),
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
                title: Text(
                  t.others.language[locale.name.toString()]?.capitalize() ??
                      t.others.language.entries.first.value.capitalize(),
                ),
                trailing: settings.locale == locale
                    ? Icon(
                        Icons.check_outlined,
                        color: Theme.of(context).colorScheme.onTertiary,
                      )
                    : null,
                onTap: () {
                  // Update the locale
                  ref
                      .read(mesSettingsNotifierProvider.notifier)
                      .updateLocale(locale)
                      .whenComplete(
                        // When the locale is updated, refresh the services
                        () => ref.refresh(servicesProvider.future),
                      );
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
