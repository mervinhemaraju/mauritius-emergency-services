import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/providers/api_providers.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_r_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "../../../generated/pages/cyclone/cyclone_r_provider.g.dart";

@riverpod
Future<CycloneReportState> cycloneReport(Ref ref) async {
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
      return const CycloneReportNoInternetState(
        "Please connect to the internet",
      );
    }

    // Get the cyclone report
    final report = await repository.getCycloneReport();

    // Check if there is a warning
    if (report.level > 0) {
      return CycloneReportWarningState(report);
    } else {
      return CycloneReportNoWarningState(report);
    }
  } catch (e) {
    return CycloneReportErrorState(
      t.messages.error.cannot_load_data,
    );
  }
}
