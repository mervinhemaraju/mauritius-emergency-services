import 'package:mauritius_emergency_services/data/repository/rt_permissions_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class RuntimePermissionsImpl implements RuntimePermissionsRepository {
  const RuntimePermissionsImpl();

  @override
  Future<PermissionStatus> checkPhonePermissionStatus() =>
      Permission.phone.status;

  @override
  Future<bool> requestAllPermissions() async {
    final statuses = await [
      Permission.notification,
      Permission.phone,
    ].request();
    return statuses.values.every((s) => s.isGranted);
  }

  @override
  Future<bool> requestPhonePermissions() async {
    final status = await Permission.phone.request();
    return status.isGranted;
  }
}
