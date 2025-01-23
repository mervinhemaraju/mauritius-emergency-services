import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/guidelines/cyclone_g_provider.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/guidelines/cyclone_g_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class CycloneGuidelinesSheet extends ConsumerWidget {
  // final int cycloneLevel;

  // Constructor
  const CycloneGuidelinesSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define the theme
    final theme = Theme.of(context);

    // Retrieve the cyclone names data
    final uiState = ref.watch(cycloneGuidelinesProvider).when(
        data: (state) => state,
        loading: () => const CycloneGuidelinesLoadingState(),
        error: (error, stack) => CycloneGuidelinesErrorState(error.toString()));

    // Get the ui view
    final uiView = switch (uiState) {
      CycloneGuidelinesLoadingState() => const LoadingScreen(),
      CycloneGuidelinesErrorState(message: final message) => ErrorScreen(
          title: message.capitalize(),
          retryAction: () => ref.refresh(cycloneGuidelinesProvider.future),
        ),
      // TODO("Add a better UI for this")
      CycloneGuidelinesNoInternetState(message: final message) => ErrorScreen(
          title: message.capitalize(),
          retryAction: () => ref.refresh(cycloneGuidelinesProvider.future),
        ),
      CycloneGuidelinesUiState(cycloneGuidelines: final cycloneGuidelines) =>
        _CycloneGuidelinesUi(
          cycloneGuidelines: cycloneGuidelines,
        ),
    };

    // Return the view
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // FIXME(Include title in UI view)
            Text(
              t.pages.cyclone.guidelines.title(level: "0").capitalizeAll(),
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16.0),
            uiView,
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
