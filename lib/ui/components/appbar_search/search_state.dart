import 'package:mauritius_emergency_services/models/service.dart';

sealed class SearchState {
  const SearchState();
}

class SearchStateInitial extends SearchState {
  const SearchStateInitial();
}

class SearchStateLoading extends SearchState {
  const SearchStateLoading();
}

class SearchStateError extends SearchState {
  final String message;
  const SearchStateError(this.message);
}

class SearchMatchState extends SearchState {
  final List<Service> services;
  const SearchMatchState(this.services);
}

class SearchNoMatchState extends SearchState {
  const SearchNoMatchState();
}
