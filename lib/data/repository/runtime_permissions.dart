// Abstract class
import 'package:permission_handler/permission_handler.dart';

abstract class SimplifiedRuntimePermissionsRepository {
  Future<bool> requestAllPermissions();

  Future<bool> requestPhonePermissions();

  Future<PermissionStatus> checkPhonePermissionStatus();
}
