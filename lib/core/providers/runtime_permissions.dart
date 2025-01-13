import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/data/impl/runtime_permissions_impl.dart';
import 'package:mauritius_emergency_services/data/repository/runtime_permissions.dart';
import 'package:permission_handler/permission_handler.dart';

// Request all permissions
class RequestAllPermissionsUseCase {
  final RuntimePermissionRepository repository;

  RequestAllPermissionsUseCase(this.repository);

  Future<bool> execute() => repository.requestAllPermissions();
}

// Provider
final permissionRepositoryProvider =
    Provider<RuntimePermissionRepository>((ref) {
  return RuntimePermissionImpl();
});

final requestPermissionsUseCaseProvider =
    Provider<RequestAllPermissionsUseCase>((ref) {
  return RequestAllPermissionsUseCase(ref.watch(permissionRepositoryProvider));
});

final permissionsStateProvider =
    StateNotifierProvider<PermissionsNotifier, AsyncValue<bool>>((ref) {
  return PermissionsNotifier(ref.watch(requestPermissionsUseCaseProvider));
});

class PermissionsNotifier extends StateNotifier<AsyncValue<bool>> {
  final RequestAllPermissionsUseCase _requestPermissionsUseCase;

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

final permissionRefreshNotifierProvider =
    StateNotifierProvider<PermissionRefreshNotifier, int>((ref) {
  return PermissionRefreshNotifier();
});

class PermissionRefreshNotifier extends StateNotifier<int> {
  PermissionRefreshNotifier() : super(0);

  void refresh() {
    state = state + 1; // Increment to trigger refresh
  }
}

final phonePermissionsStatusProvider =
    FutureProvider<PermissionStatus>((ref) async {
  // Watch the refresh counter - this will cause the provider to rebuild when refresh() is called
  ref.watch(permissionRefreshNotifierProvider);

  final repository = ref.watch(permissionRepositoryProvider);
  return repository.checkMandatoryPermissionsStatus();
});
