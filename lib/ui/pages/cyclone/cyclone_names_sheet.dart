import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';

class CycloneNamesSheet extends ConsumerWidget {
  // Constructor
  const CycloneNamesSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve the cyclone names data
    final uiState = ref.watch(cycloneNamesProvider).when(
          data: (names) => _CycloneNamesUi(
            cycloneNames: names,
          ),
          loading: () => LoadingScreen(),
          error: (error, stack) => ErrorScreen(
            title: "An error occurred while fetching the cyclone names.",
            retryAction: () => ref.refresh(cycloneNamesProvider.future),
          ),
        );

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Cyclone Names',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 48.0),
            uiState,
            SizedBox(height: 48.0),
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
      columns: const [
        DataColumn(
          label: Text(
            'Name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Gender',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Provided By',
            style: TextStyle(fontWeight: FontWeight.bold),
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
