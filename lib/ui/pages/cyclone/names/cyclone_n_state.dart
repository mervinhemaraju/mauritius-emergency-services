import 'package:mauritius_emergency_services/models/cyclone_names.dart';

sealed class CycloneNamesState {
  const CycloneNamesState();
}

class CycloneNamesLoadingState extends CycloneNamesState {
  const CycloneNamesLoadingState();
}

class CycloneNamesErrorState extends CycloneNamesState {
  final String message;
  const CycloneNamesErrorState(this.message);
}

class CycloneNamesNoInternetState extends CycloneNamesState {
  final String message;
  const CycloneNamesNoInternetState(this.message);
}

class CycloneNamesUiState extends CycloneNamesState {
  final List<CycloneNames> cycloneNames;
  const CycloneNamesUiState(this.cycloneNames);
}
