import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionRepository {
  Future<bool> requestPermissions();
  Future<bool> checkPermissionsStatus();
  Future<bool> checkMandatoryPermissionsStatus();
}

// lib/domain/usecases/request_permissions_usecase.dart
class RequestPermissionsUseCase {
  final PermissionRepository repository;

  RequestPermissionsUseCase(this.repository);

  Future<bool> execute() async {
    return await repository.requestPermissions();
  }
}

class PermissionRepositoryImpl implements PermissionRepository {
  @override
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
      Permission.phone,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  @override
  Future<bool> checkPermissionsStatus() async {
    bool isNotificationGranted = await Permission.notification.isGranted;
    bool isPhoneGranted = await Permission.phone.isGranted;

    return isNotificationGranted && isPhoneGranted;
  }

  @override
  Future<bool> checkMandatoryPermissionsStatus() async {
    bool isPhoneGranted = await Permission.phone.isGranted;

    return isPhoneGranted;
  }
}

final permissionRepositoryProvider = Provider<PermissionRepository>((ref) {
  return PermissionRepositoryImpl();
});

final requestPermissionsUseCaseProvider =
    Provider<RequestPermissionsUseCase>((ref) {
  return RequestPermissionsUseCase(ref.watch(permissionRepositoryProvider));
});

final permissionsStateProvider =
    StateNotifierProvider<PermissionsNotifier, AsyncValue<bool>>((ref) {
  return PermissionsNotifier(ref.watch(requestPermissionsUseCaseProvider));
});

class PermissionsNotifier extends StateNotifier<AsyncValue<bool>> {
  final RequestPermissionsUseCase _requestPermissionsUseCase;

  PermissionsNotifier(this._requestPermissionsUseCase)
      : super(const AsyncValue.data(false));

  Future<void> requestPermissions() async {
    state = const AsyncValue.loading();
    try {
      final result = await _requestPermissionsUseCase.execute();
      state = AsyncValue.data(result);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
