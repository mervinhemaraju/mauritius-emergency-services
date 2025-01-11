import 'package:mauritius_emergency_services/core/models/service.dart';

sealed class ServicesViewState {
  const ServicesViewState();
}

class ServicesViewLoading extends ServicesViewState {
  const ServicesViewLoading();
}

class ServicesViewRestricted extends ServicesViewState {
  const ServicesViewRestricted();
}

class ServicesViewData extends ServicesViewState {
  final List<Service> services;
  const ServicesViewData(this.services);
}
