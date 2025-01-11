import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermittedService {
  final List<Service> services;
  final PermissionStatus status;

  const PermittedService({
    required this.status,
    this.services = const [],
  });
}
