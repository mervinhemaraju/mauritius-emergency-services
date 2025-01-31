import 'package:mauritius_emergency_services/data/repository/runtime_permissions.dart';
import 'package:permission_handler/permission_handler.dart';

class RuntimePermissions implements RuntimePermissionsRepository {
  @override
  Future<PermissionStatus> checkPhonePermissionStatus() async {
    return await Permission.phone.status;
  }

  @override
  Future<bool> requestAllPermissions() async {
    final statuses = await [
      Permission.notification,
      Permission.phone,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  @override
  Future<bool> requestPhonePermissions() async {
    final status = await Permission.phone.request();
    return status.isGranted;
  }
}
