import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/providers/api_providers.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_r_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "../../../generated/pages/cyclone/cyclone_r_provider.g.dart";

@riverpod
Future<CycloneGuidelines?> cycloneGuidelineByLevel(
  Ref ref,
  int level,
) async {
  try {
    final repository = ref.watch(mesCycloneRepositoryProvider);

    // Get the cyclone guidelines
    final guidelines = await repository.getCycloneGuidelines();

    // Get the guideline by the report level
    final guideline = guidelines
        .where((guideline) => guideline.level == level)
        .toList()
        .lastOrNull;

    return guideline;
  } catch (e) {
    // Return null if an error occurred
    return null;
  }
}

// Updated CycloneReportNotifier
@riverpod
class CycloneReportNotifier extends _$CycloneReportNotifier {
  @override
  Future<CycloneReportState> build() async {
    try {
      final repository = ref.watch(mesCycloneRepositoryProvider);
      final isConnectedToInternet = await NetworkInfo().isConnectedToInternet;

      if (!isConnectedToInternet) {
        return CycloneReportNoInternet(
          message: t.messages.error.no_internet_connection.capitalize(),
        );
      }

      // Get the cyclone report
      final report = await repository.getCycloneReport();

      // Get the guideline by the report level
      final guideline = await ref.watch(
        cycloneGuidelineByLevelProvider(report.level).future,
      );

      // Get the report and guidelines
      return report.level > 0
          ? CycloneReportWarning(
              cycloneReport: report, cycloneGuidelines: guideline)
          : CycloneReportNoWarning(
              cycloneReport: report, cycloneGuidelines: guideline);
    } catch (e) {
      return CycloneReportError(
        message: t.messages.error.cannot_load_cyclone_report,
      );
    }
  }

  Future<void> refresh() async {
    // This will trigger a reload while keeping the previous state
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(build);
  }
}
