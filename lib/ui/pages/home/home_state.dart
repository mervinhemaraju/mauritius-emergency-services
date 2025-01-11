import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';

sealed class HomeViewState {
  const HomeViewState();
}

class HomeViewLoading extends HomeViewState {
  const HomeViewLoading();
}

class HomeViewRestricted extends HomeViewState {
  const HomeViewRestricted();
}

class HomeViewData extends HomeViewState {
  final List<Service> services;
  final MesSettings settings;
  const HomeViewData(this.services, this.settings);
}
