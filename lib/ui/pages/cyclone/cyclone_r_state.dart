import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/models/cyclone_report.dart';

part '../../../generated/pages/cyclone/cyclone_r_state.freezed.dart';

@freezed
sealed class CycloneReportState with _$CycloneReportState {
  const factory CycloneReportState.Warning({
    required CycloneReport cycloneReport,
    required CycloneGuidelines? cycloneGuidelines,
  }) = CycloneReportWarning;

  const factory CycloneReportState.NoWarning({
    required CycloneReport cycloneReport,
    required CycloneGuidelines? cycloneGuidelines,
  }) = CycloneReportNoWarning;

  const factory CycloneReportState.Error({required String message}) =
      CycloneReportError;

  const factory CycloneReportState.Loading() = CycloneReportLoading;

  const factory CycloneReportState.NoInternet({required String message}) =
      CycloneReportNoInternet;
}
