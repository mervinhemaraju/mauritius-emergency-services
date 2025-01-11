import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/runtime_permissions.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_state.dart';
import 'package:permission_handler/permission_handler.dart';

// First, create a notifier to handle the refresh trigger
class ServicesViewNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() => 0; // Counter to trigger refreshes

  void refresh() => state++; // Increment to force refresh
}

final servicesViewNotifierProvider =
    AutoDisposeNotifierProvider<ServicesViewNotifier, int>(
  () => ServicesViewNotifier(),
);

// Modify your StreamProvider to watch the refresh trigger
final servicesViewStateProvider =
    StreamProvider<ServicesViewState>((ref) async* {
  // Watch the refresh notifier
  ref.watch(servicesViewNotifierProvider);

  // Rest of your existing code
  final permissionStatus = await ref.watch(
    phonePermissionsStatusProvider.future,
  );

  if (!permissionStatus.isGranted) {
    yield const ServicesViewRestricted();
    return;
  }

  final servicesAsyncValue = ref.watch(servicesProvider);

  yield servicesAsyncValue.when(
    data: (services) => ServicesViewData(
      services,
    ),
    loading: () => const ServicesViewLoading(),
    error: (error, stack) => throw error,
  );
});
