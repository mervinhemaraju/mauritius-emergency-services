import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the theme color
    final colorScheme = Theme.of(context).colorScheme;

    // Get the theme text
    final textTheme = Theme.of(context).textTheme;

    // Define a header highlight
    final headerHighlight = colorScheme.primaryContainer;
    final onHeaderHighlight = colorScheme.onPrimaryContainer;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerHighlight,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Container(
            color: headerHighlight,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8.0,
              children: [
                Text(
                  t.pages.disclaimer_screen.title
                      .capitalizeAll(),
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                    color: onHeaderHighlight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  t.pages.disclaimer_screen.header
                      .capitalizeAll(),
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: onHeaderHighlight,
                  ),
                ),
              ],
            ),
          ),
          InformationSection(
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }
}

class InformationSection extends StatelessWidget {
  const InformationSection({
    super.key,
    required this.colorScheme,
    required this.textTheme,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: t.pages.disclaimer_screen.sections.length + 1,
        separatorBuilder: (context, index) =>
            const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          // Show sections
          if (index <
              t.pages.disclaimer_screen.sections.length) {
            final section =
                t.pages.disclaimer_screen.sections[index];
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: colorScheme.outlineVariant,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.0,
                children: [
                  Row(
                    children: [
                      Text(
                        section.icon,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          section.title
                              .toString()
                              .capitalizeAll(),
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    section.message.toString().capitalize(),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            );
          }

          // Show buttons at the end
          return const ActionButtons();
        },
      ),
    );
  }
}

class ActionButtons extends ConsumerWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 48.0),
      child: Row(
        spacing: 12.0,
        children: [
          Expanded(
            flex: 3,
            child: OutlinedButton(
              onPressed: () {
                exit(0);
              },
              child: Text(t.actions.exit.capitalize()),
            ),
          ),
          Expanded(
            flex: 7,
            child: FilledButton(
              onPressed: () {
                // Mark disclaimer read as true
                ref
                    .read(mesSettingsProvider.notifier)
                    .markDisclaimerAsRead();

                // Navigate to the home screen
                context.go(HomeRoute.path);
              },
              child: Text(t.actions.agree.capitalize()),
            ),
          ),
        ],
      ),
    );
  }
}
