import 'package:mauritius_emergency_services/core/models/service.dart';

class PermittedService {
  final List<Service> services;
  final bool isPermissionsGranted;

  const PermittedService({
    this.services = const [],
    this.isPermissionsGranted = false,
  });
}
