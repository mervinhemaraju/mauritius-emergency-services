import 'package:mauritius_emergency_services/models/service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/pages/services/services_state.freezed.dart';

@freezed
sealed class ServicesState with _$ServicesState {
  const factory ServicesState.Loaded({required List<Service> services}) =
      ServicesLoaded;

  const factory ServicesState.Error({required String message}) = ServicesError;

  const factory ServicesState.Loading() = ServicesLoading;

  const factory ServicesState.NoInternet({required String message}) =
      ServicesNoInternet;
}
