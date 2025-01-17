import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/providers/cyclone_providers.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';

class CycloneGuidelinesSheet extends ConsumerWidget {
  final int cycloneLevel;

  // Constructor
  const CycloneGuidelinesSheet({super.key, required this.cycloneLevel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define the theme
    final theme = Theme.of(context);

    // Retrieve the cyclone names data
    final uiState = ref.watch(cycloneGuidelinesProvider).when(
          data: (guidelines) {
            final asd = guidelines
                .where((guideline) => guideline.level == cycloneLevel)
                .toList();

            return _CycloneGuidelinesUi(cycloneGuidelines: asd.last);
          },
          loading: () => const LoadingScreen(),
          error: (error, stack) => ErrorScreen(
            title: "An error occurred while fetching the cyclone guidelines.",
            retryAction: () => ref.refresh(cycloneGuidelinesProvider.future),
          ),
        );

    // Return the view
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Guidelines for Class $cycloneLevel',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16.0),
            uiState,
            const SizedBox(height: 48.0),
          ],
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
            cycloneGuidelines.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Text(
            "Precautions",
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
