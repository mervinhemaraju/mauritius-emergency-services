// Abstract class
import 'package:permission_handler/permission_handler.dart';

abstract class RuntimePermissionsRepository {
  Future<bool> requestAllPermissions();

  Future<bool> requestPhonePermissions();

  Future<PermissionStatus> checkPhonePermissionStatus();
}
