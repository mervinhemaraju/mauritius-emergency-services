import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mauritius_emergency_services/data/local/preferences/settings_provider.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/pages/settings/emergency_button_dialog.dart';
import 'package:mauritius_emergency_services/ui/pages/settings/language_dialog.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/widgets/appbars/appbar_primary.dart';
import 'package:mauritius_emergency_services/ui/widgets/items/item_settings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MesAppBarPrimary(
        title: t.pages.settings.title.capitalize(),
        goBack: () => context.goBack(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(18.0),

            const _ThemeSelectionPill(),

            const Gap(18.0),

            _SettingsHeaderTitle(
              title: t.pages.settings.section_display.title.capitalizeAll(),
            ),

            SettingsItem(
              icon: Icons.color_lens_outlined,
              title: t.pages.settings.section_display.dynamic_colors.tile_title
                  .capitalizeAll(),
              subtitle: t
                  .pages
                  .settings
                  .section_display
                  .dynamic_colors
                  .tile_subtitle
                  .capitalize(),
              trailing: const _DynamicColorSwitch(),
            ),

            _SettingsHeaderTitle(
              title: t.pages.settings.section_feature.title.capitalize(),
            ),
            SettingsItem(
              icon: Icons.emergency_outlined,
              title: t
                  .pages
                  .settings
                  .section_feature
                  .emergency_button_action
                  .tile_title
                  .capitalizeAll(),
              subtitle: t
                  .pages
                  .settings
                  .section_feature
                  .emergency_button_action
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
                  .pages
                  .settings
                  .section_application
                  .change_language
                  .tile_title
                  .capitalizeAll(),
              subtitle: t
                  .pages
                  .settings
                  .section_application
                  .change_language
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

class _ThemeSelectionPill extends ConsumerWidget {
  const _ThemeSelectionPill();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final currentTheme = ref.watch(
      mesSettingsProvider.select((s) => s.theme),
    );

    // ThemeMode.values order: system(0), light(1), dark(2)
    // which matches the themes map keys in slang: system, light, dark
    final selectedIndex = ThemeMode.values.indexOf(currentTheme);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 65,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / ThemeMode.values.length;

            return Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  left: selectedIndex * itemWidth,
                  top: 0,
                  bottom: 0,
                  width: itemWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                ),
                Row(
                  children: ThemeMode.values.map((theme) {
                    return _ThemeOption(
                      theme: theme,
                      isSelected: theme == currentTheme,
                      width: itemWidth,
                      onTap: () {
                        ref
                            .read(mesSettingsProvider.notifier)
                            .updateTheme(theme);
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final ThemeMode theme;
  final bool isSelected;
  final double width;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.theme,
    required this.isSelected,
    required this.width,
    required this.onTap,
  });

  IconData get _icon => switch (theme) {
    ThemeMode.system => Icons.settings_suggest_outlined,
    ThemeMode.light => Icons.light_mode_outlined,
    ThemeMode.dark => Icons.dark_mode_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _icon,
              size: 22,
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 2),
            Text(
              t.others.themes[theme.name]?.capitalize() ??
                  theme.name.capitalize(),
              style: textTheme.labelSmall?.copyWith(
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DynamicColorSwitch extends ConsumerWidget {
  const _DynamicColorSwitch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(mesSettingsProvider);

    return Switch(
      value: settings.isDynamicEnabled,
      onChanged: (value) =>
          ref.read(mesSettingsProvider.notifier).toggleDynamic(value),
    );
  }
}

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
