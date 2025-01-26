import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/names/cyclone_n_provider.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/names/cyclone_n_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class CycloneNamesSheet extends ConsumerWidget {
  // Constructor
  const CycloneNamesSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a retry action
    void retryAction() {
      ref.invalidate(cycloneNamesProvider);
    }

    // Get the ui state
    final uiState = ref.watch(cycloneNamesProvider).when(
          data: (state) => state,
          loading: () => const CycloneNamesLoadingState(),
          error: (error, stack) => CycloneNamesErrorState(
            error.toString().capitalize(),
          ),
        );

    // Get the ui view
    final uiView = switch (uiState) {
      CycloneNamesLoadingState() => const LoadingScreen(),
      CycloneNamesErrorState(message: final message) => ErrorScreen(
          title: message.capitalize(),
          showErrorImage: true,
          retryAction: retryAction,
        ),
      CycloneNamesNoInternetState(message: final message) => ErrorScreen(
          title: message.capitalize(),
          showInternetErrorImage: true,
          retryAction: retryAction,
        ),
      CycloneNamesUiState(cycloneNames: final cycloneNames) => _CycloneNamesUi(
          cycloneNames: cycloneNames,
        ),
    };

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              t.pages.cyclone.names.title.capitalizeAll(),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 48.0),
            uiView,
            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }
}

class _CycloneNamesUi extends StatelessWidget {
  final List<CycloneNames> cycloneNames;

  const _CycloneNamesUi({
    required this.cycloneNames,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.primaryContainer,
      ),
      columns: [
        DataColumn(
          label: Text(
            t.pages.cyclone.names.table_header_name.capitalizeAll(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            t.pages.cyclone.names.table_header_gender.capitalizeAll(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            t.pages.cyclone.names.table_header_provided_by.capitalizeAll(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: cycloneNames.map((cyclone) {
        return DataRow(
          cells: [
            DataCell(Text(cyclone.name)),
            DataCell(Text(cyclone.gender)),
            DataCell(Text(cyclone.providedBy)),
          ],
        );
      }).toList(),
    );
  }
}
