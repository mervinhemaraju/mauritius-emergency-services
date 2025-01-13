import 'package:mauritius_emergency_services/data/repository/runtime_permissions.dart';
import 'package:permission_handler/permission_handler.dart';

class RuntimePermissionImpl implements RuntimePermissionRepository {
  @override
  Future<PermissionStatus> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status;
  }

  @override
  Future<PermissionStatus> requestPhonePermission() async {
    final status = await Permission.phone.request();
    return status;
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
  Future<Map<Permission, PermissionStatus>> checkPermissionsStatus() async {
    return {
      Permission.notification: await Permission.notification.status,
      Permission.phone: await Permission.phone.status,
    };
  }

  @override
  Future<PermissionStatus> checkMandatoryPermissionsStatus() async {
    return await Permission.phone.status;
  }
}
