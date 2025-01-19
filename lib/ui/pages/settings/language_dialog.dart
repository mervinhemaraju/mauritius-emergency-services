import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
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
          child: ListView.builder(
            prototypeItem: LanguageSelectorItem(
              isSelected: false,
              locale: MesLocale.english,
              onTap: (locale) {},
            ),
            itemCount: MesLocale.values.length,
            itemBuilder: (context, index) {
              final locale = MesLocale.values[index];
              return LanguageSelectorItem(
                isSelected: settings.locale == locale,
                locale: locale,
                onTap: (locale) {
                  // Update the locale
                  ref
                      .read(mesSettingsNotifierProvider.notifier)
                      .updateLocale(locale);
                },
              );
            },
          ),
        )
      ],
    );
  }
}
