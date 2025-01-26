import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/providers/api_providers.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_r_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
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
        return CycloneReportNoInternetState(
          t.messages.error.no_internet_connection.capitalize(),
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

      // Get the report and guideliens
      return report.level > 0
          ? CycloneReportWarningState(report, guideline)
          : CycloneReportNoWarningState(report, guideline);
    } catch (e) {
      return CycloneReportErrorState(
        t.messages.error.cannot_load_cyclone_report,
      );
    }
  }

  Future<void> refresh() async {
    // This will trigger a reload while keeping the previous state
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(build);
  }
}
