import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/models/outage/mes_district_outage.dart';

part '../../../generated/pages/ceb/ceb_state.freezed.dart';

@freezed
sealed class CebState with _$CebState {
  /// Data loaded and at least one outage exists across any district.
  const factory CebState.Loaded({
    required List<CebDistrictOutage> districtOutages,
  }) = CebLoaded;

  /// Data loaded but no outages scheduled — "all clear" screen.
  const factory CebState.Empty() = CebEmpty;

  const factory CebState.Error({required String message}) = CebError;

  const factory CebState.Loading() = CebLoading;

  const factory CebState.NoInternet({required String message}) = CebNoInternet;
}
