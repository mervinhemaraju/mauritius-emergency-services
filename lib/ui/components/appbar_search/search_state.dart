import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/models/service.dart';
part '../../../generated/components/appbar_search/search_state.freezed.dart';

@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState.Initial() = SearchInitial;

  const factory SearchState.Loading() = SearchLoading;

  const factory SearchState.Matched({
    required List<Service> services,
  }) = SearchMatched;

  const factory SearchState.NoMatch() = SearchNoMatch;

  const factory SearchState.Error({
    required String message,
  }) = SearchError;
}
