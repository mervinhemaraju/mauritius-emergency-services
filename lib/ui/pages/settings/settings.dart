import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_simple.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/pages/settings/emergency_button_dialog.dart';
import 'package:mauritius_emergency_services/ui/pages/settings/language_dialog.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Return the view
    return Scaffold(
      appBar: MesAppBar(
        title: t.pages.settings.title.capitalize(),
        goBack: () => context.goBack(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // _SettingsHeaderTitle(
            //   title: "Display",
            // ),
            // SettingsItem(
            //   icon: Icons.color_lens_outlined,
            //   title: "Dynamic Colors",
            //   subtitle:
            //       "Apply dynamic colors, based on your wallpaper (Material YOU)",
            //   trailing: _DynamicColorSwitch(),
            // ),
            _SettingsHeaderTitle(
              title: t.pages.settings.section_feature.title.capitalize(),
            ),
            SettingsItem(
              icon: Icons.emergency_outlined,
              title: t.pages.settings.section_feature.emergency_button_action
                  .tile_title
                  .capitalizeAll(),
              subtitle: t.pages.settings.section_feature.emergency_button_action
                  .tile_subtitle
                  .capitalize(),
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      const EmergencyButtonDialog(),
                );
              },
            ),
            _SettingsHeaderTitle(
              title: t.pages.settings.section_application.title.capitalize(),
            ),
            SettingsItem(
              icon: Icons.language_outlined,
              title: t
                  .pages.settings.section_application.change_language.tile_title
                  .capitalizeAll(),
              subtitle: t.pages.settings.section_application.change_language
                  .tile_subtitle
                  .capitalize(),
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const LanguageDialog(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Simple switch widget
// class _DynamicColorSwitch extends ConsumerWidget {
//   const _DynamicColorSwitch();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final settings = ref.watch(settingsProvider);

//     return Switch(
//       value: settings.isDynamicEnabled,
//       onChanged: (value) =>
//           ref.read(settingsProvider.notifier).toggleDynamic(value),
//     );
//   }
// }

class _SettingsHeaderTitle extends StatelessWidget {
  final String title;

  const _SettingsHeaderTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );
  }
}
