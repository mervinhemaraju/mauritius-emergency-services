import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/models/service.dart';

part '../../../generated/pages/home/home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.Loaded({
    required List<Service> services,
    required Service emergencyButtonAction,
  }) = HomeLoaded;

  const factory HomeState.Error({
    required String message,
  }) = HomeError;

  const factory HomeState.Loading() = HomeLoading;

  const factory HomeState.NoInternet({
    required String message,
  }) = HomeNoInternet;
}
