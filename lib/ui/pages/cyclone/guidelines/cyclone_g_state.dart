import 'package:mauritius_emergency_services/models/cyclone_guidelines.dart';

sealed class CycloneGuidelinesState {
  const CycloneGuidelinesState();
}

class CycloneGuidelinesLoadingState extends CycloneGuidelinesState {
  const CycloneGuidelinesLoadingState();
}

class CycloneGuidelinesErrorState extends CycloneGuidelinesState {
  final String message;
  const CycloneGuidelinesErrorState(this.message);
}

class CycloneGuidelinesNoInternetState extends CycloneGuidelinesState {
  final String message;
  const CycloneGuidelinesNoInternetState(this.message);
}

class CycloneGuidelinesUiState extends CycloneGuidelinesState {
  final CycloneGuidelines cycloneGuidelines;
  const CycloneGuidelinesUiState(this.cycloneGuidelines);
}
