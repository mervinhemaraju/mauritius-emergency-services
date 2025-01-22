// Create a sealed class of the home state
import 'package:mauritius_emergency_services/models/service.dart';

sealed class HomeState {
  const HomeState();
}

class HomeErrorState extends HomeState {
  final String message;
  const HomeErrorState(this.message);
}

class HomeNoInternetState extends HomeState {
  final String message;
  const HomeNoInternetState(this.message);
}

class HomeUiState extends HomeState {
  final List<Service> emergencyServices;
  final Service emergencyButtonAction;
  const HomeUiState(this.emergencyServices, this.emergencyButtonAction);
}
