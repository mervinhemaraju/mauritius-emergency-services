import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/settings_notifier.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/settings_item.dart';
import 'package:mauritius_emergency_services/ui/settings/extensions.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppBar(
        title: "Settings",
        goBack: () => context.goBack(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SettingsHeaderTitle(
              title: "Display",
            ),
            SettingsItem(
              icon: Icons.color_lens_outlined,
              title: "Dynamic Colors",
              subtitle:
                  "Apply dynamic colors, based on your wallpaper (Material YOU)",
              trailing: DynamicSwitch(),
            ),
            _SettingsHeaderTitle(
              title: "Feature",
            ),
            SettingsItem(
              icon: Icons.emergency_outlined,
              title: "Emergency Button Action",
              subtitle: "Set an emergency service for the red button",
              onTap: () {},
            ),
            _SettingsHeaderTitle(
              title: "Application",
            ),
            SettingsItem(
              icon: Icons.language_outlined,
              title: "Change Language",
              subtitle: "Change your app's language",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicSwitch extends ConsumerWidget {
  const DynamicSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(mesSettingsProvider);

    return Switch(
      value: settings.isDynamicEnabled,
      onChanged: (bool value) {
        ref.read(mesSettingsProvider.notifier).updateDynamicEnabled(value);
      },
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
