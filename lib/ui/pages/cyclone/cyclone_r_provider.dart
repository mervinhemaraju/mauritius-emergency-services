import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/providers/api_providers.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_r_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "../../../generated/pages/cyclone/cyclone_r_provider.g.dart";

@riverpod
class CycloneReportNotifier extends _$CycloneReportNotifier {
  @override
  Future<CycloneReportState> build() async {
    try {
      final repository = ref.watch(mesCycloneRepositoryProvider);
      final isConnectedToInternet = await NetworkInfo().isConnectedToInternet;

      if (!isConnectedToInternet) {
        return const CycloneReportNoInternetState(
          // TODO("Add to constants")
          "Please connect to the internet",
        );
      }

      final report = await repository.getCycloneReport();

      return report.level > 0
          ? CycloneReportWarningState(report)
          : CycloneReportNoWarningState(report);
    } catch (e) {
      return CycloneReportErrorState(
        t.messages.error.cannot_load_data,
      );
    }
  }

  Future<void> refresh() async {
    // This will trigger a reload while keeping the previous state
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(build);
  }
}

@riverpod
Future<CycloneReportState> cycloneReportTesting(Ref ref) async {
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
    final report = await repository.getCycloneReportTesting();

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
