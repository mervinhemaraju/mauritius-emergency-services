import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/runtime_permissions.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';
import 'package:mauritius_emergency_services/ui/pages/home/home_state.dart';
import 'package:permission_handler/permission_handler.dart';

final homeViewStateProvider = StreamProvider<HomeViewState>((ref) async* {
  // Watch both providers
  final permissionStatus =
      await ref.watch(phonePermissionsStatusProvider.future);

  // If permission is not granted, immediately yield restricted state
  if (!permissionStatus.isGranted) {
    yield const HomeViewRestricted();
    return;
  }

  // Watch the emergency services provider
  final servicesAsyncValue = ref.watch(emergencyServicesProvider);

  // Map the services state to our HomeViewState
  yield servicesAsyncValue.when(
    data: (services) => HomeViewData(
      services,
      ref.read(settingsProvider), // Assuming you have a settings provider
    ),
    loading: () => const HomeViewLoading(),
    error: (error, stack) => HomeViewError(error, stack),
  );
});
