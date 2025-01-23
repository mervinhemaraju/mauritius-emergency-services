import 'package:mauritius_emergency_services/models/service.dart';

sealed class ServicesState {
  const ServicesState();
}

class ServicesLoadingState extends ServicesState {
  const ServicesLoadingState();
}

class ServicesErrorState extends ServicesState {
  final String message;
  const ServicesErrorState(this.message);
}

class ServicesNoInternetState extends ServicesState {
  final String message;
  const ServicesNoInternetState(this.message);
}

class ServicesUiState extends ServicesState {
  final List<Service> services;
  const ServicesUiState(this.services);
}
