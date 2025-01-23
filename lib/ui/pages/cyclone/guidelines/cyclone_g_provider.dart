import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/providers/api_providers.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/guidelines/cyclone_g_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "../../../../generated/pages/cyclone/guidelines/cyclone_g_provider.g.dart";

@riverpod
Future<CycloneGuidelinesState> cycloneGuidelines(Ref ref) async {
  /*
  * Gets the cyclone report
  */

  try {
    // Get the cyclone repository provider
    final repository = ref.watch(mesCycloneRepositoryProvider);

    // Get the network info
    final isConnectedToInternet = await NetworkInfo().isConnectedToInternet;

    // Check if not connected to internet
    if (!isConnectedToInternet) {
      // TODO("Add to constants")
      return const CycloneGuidelinesNoInternetState(
        "Please connect to the internet",
      );
    }

    // Get the cyclone report
    final report = await repository.getCycloneReport();

    // Get the cyclone guidelines
    final guidelines = await repository.getCycloneGuidelines();

    // Get the guideline by the report level
    final guideline = guidelines
        .where((guideline) => guideline.level == report.level)
        .toList()
        .last;

    // Return the view
    return CycloneGuidelinesUiState(guideline);
  } catch (e) {
    return CycloneGuidelinesErrorState(
      t.messages.error.cannot_load_data,
    );
  }
}
