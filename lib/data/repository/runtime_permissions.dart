// Abstract class
import 'package:permission_handler/permission_handler.dart';

abstract class RuntimePermissionRepository {
  /// Request notification permission
  Future<PermissionStatus> requestNotificationPermission();

  /// Request phone permission
  Future<PermissionStatus> requestPhonePermission();

  /// Request all permissions at once
  Future<bool> requestAllPermissions();

  /// Check status of all permissions
  Future<Map<Permission, PermissionStatus>> checkPermissionsStatus();

  /// Check only mandatory permissions (phone)
  Future<PermissionStatus> checkMandatoryPermissionsStatus();
}
