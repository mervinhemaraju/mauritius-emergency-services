import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/data/local/preferences/settings_provider.dart';
import 'package:mauritius_emergency_services/ui/widgets/appbars/appbar_primary.dart';
import 'package:mauritius_emergency_services/ui/pages/settings/emergency_button_dialog.dart';
import 'package:mauritius_emergency_services/ui/pages/settings/language_dialog.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/widgets/items/item_settings.dart';

// TODO(Update UI and centralize widgets)
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Return the view
    return Scaffold(
      appBar: MesAppBarPrimary(
        title: t.pages.settings.title.capitalize(),
        goBack: () => context.goBack(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // DISPLAY SECTION (Always visible for Theme)
            _SettingsHeaderTitle(
              title: t.pages.settings.section_display.title.capitalizeAll(),
            ),

            // NEW CREATIVE UI: Fluid Theme Sliding Pill
            const _ThemeSelectionPill(),

            // Dynamic colors remain Android-only
            if (Platform.isAndroid) ...[
              SettingsItem(
                icon: Icons.color_lens_outlined,
                title: t
                    .pages
                    .settings
                    .section_display
                    .dynamic_colors
                    .tile_title
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
            ],

            // FEATURE SECTION
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

            // APPLICATION SECTION
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

// --- NEW WIDGET: Fluid Theme Pill ---
class _ThemeSelectionPill extends StatefulWidget {
  const _ThemeSelectionPill();

  @override
  State<_ThemeSelectionPill> createState() => _ThemeSelectionPillState();
}

class _ThemeSelectionPillState extends State<_ThemeSelectionPill> {
  // 0: System, 1: Light, 2: Dark
  // Note: Since you only want UI, this is local state.
  // You can later wire this up to Riverpod just like the dynamic color switch!
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Leveraging Material 3 colors to match your existing app theme perfectly
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 65, // Gives enough room for icon + text
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(
            0.5,
          ), // Subtle background
          borderRadius: BorderRadius.circular(30),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / 3;

            return Stack(
              children: [
                // 1. The Animated Sliding Background Bubble
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  left: _selectedIndex * itemWidth,
                  top: 0,
                  bottom: 0,
                  width: itemWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. The Clickable Options overlaying the bubble
                Row(
                  children: [
                    _buildThemeOption(
                      index: 0,
                      icon: Icons.settings_suggest_outlined,
                      label: 'System', // Swap with slang: t.pages...
                      width: itemWidth,
                      colorScheme: colorScheme,
                    ),
                    _buildThemeOption(
                      index: 1,
                      icon: Icons.light_mode_outlined,
                      label: 'Light', // Swap with slang: t.pages...
                      width: itemWidth,
                      colorScheme: colorScheme,
                    ),
                    _buildThemeOption(
                      index: 2,
                      icon: Icons.dark_mode_outlined,
                      label: 'Dark', // Swap with slang: t.pages...
                      width: itemWidth,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required int index,
    required IconData icon,
    required String label,
    required double width,
    required ColorScheme colorScheme,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      // Ensures the empty space around the icon is clickable
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// --- END NEW WIDGET ---

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
