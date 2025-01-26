import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class CycloneGuidelinesSheet extends ConsumerWidget {
  final CycloneGuidelines cycloneGuidelines;

  // Constructor
  const CycloneGuidelinesSheet({
    super.key,
    required this.cycloneGuidelines,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Return the view
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: SingleChildScrollView(
        child: _CycloneGuidelinesUi(
          cycloneGuidelines: cycloneGuidelines,
        ),
      ),
    );
  }
}

class _CycloneGuidelinesUi extends StatelessWidget {
  final CycloneGuidelines cycloneGuidelines;

  const _CycloneGuidelinesUi({
    required this.cycloneGuidelines,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 8.0,
        children: [
          Text(
            t.pages.cyclone.guidelines
                .title(level: cycloneGuidelines.level)
                .capitalizeAll(),
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            cycloneGuidelines.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Text(
            t.pages.cyclone.guidelines.header_precautions_title.capitalizeAll(),
            style: theme.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8.0,
          ),
          ...cycloneGuidelines.precautions.map((precaution) => Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: theme.colorScheme.secondaryContainer,
                ),
                child: Text(
                  precaution,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
