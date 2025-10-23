import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/models/cyclone_name.dart';

part '../../../../generated/pages/cyclone/names/cyclone_n_state.freezed.dart';

@freezed
sealed class CycloneNamesState with _$CycloneNamesState {
  const factory CycloneNamesState.Loaded({
    required List<CycloneName> cycloneNames,
  }) = CycloneNamesLoaded;

  const factory CycloneNamesState.Error({required String message}) =
      CycloneNamesError;

  const factory CycloneNamesState.Loading() = CycloneNamesLoading;

  const factory CycloneNamesState.NoInternet({required String message}) =
      CycloneNamesNoInternet;
}
