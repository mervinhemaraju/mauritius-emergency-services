import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/pages/alerts/alerts_state.freezed.dart';

@freezed
sealed class AlertsState with _$AlertsState {
  const factory AlertsState.Active({required String message}) =
      AlertsStateActive;
  const factory AlertsState.Clear() = AlertsStateClear;
  const factory AlertsState.Error({required String message}) = AlertsStateError;
  const factory AlertsState.Loading() = AlertsStateLoading;
  const factory AlertsState.NoInternet({required String message}) =
      AlertsStateNoInternet;
}
