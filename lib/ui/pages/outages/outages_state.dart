import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/core/models/outage/mes_district_outage.dart';

part '../../../generated/pages/outages/outages_state.freezed.dart';

@freezed
sealed class OutagesState with _$OutagesState {
  /// Data loaded and at least one outage exists across any district.
  const factory OutagesState.Loaded({
    required List<CebDistrictOutage> districtOutages,
  }) = OutagesLoaded;

  /// Data loaded but no outages scheduled — "all clear" screen.
  const factory OutagesState.Empty() = OutagesEmpty;

  const factory OutagesState.Error({required String message}) = OutagesError;

  const factory OutagesState.Loading() = OutagesLoading;

  const factory OutagesState.NoInternet({required String message}) =
      OutagesNoInternet;
}
