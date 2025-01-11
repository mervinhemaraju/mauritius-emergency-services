import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/runtime_permissions.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';
import 'package:mauritius_emergency_services/ui/pages/home/home_state.dart';
import 'package:permission_handler/permission_handler.dart';

// First, create a notifier to handle the refresh trigger
class HomeViewNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() => 0; // Counter to trigger refreshes

  void refresh() => state++; // Increment to force refresh
}

final homeViewNotifierProvider =
    AutoDisposeNotifierProvider<HomeViewNotifier, int>(
  () => HomeViewNotifier(),
);

// Modify your StreamProvider to watch the refresh trigger
final homeViewStateProvider = StreamProvider<HomeViewState>((ref) async* {
  // Watch the refresh notifier
  ref.watch(homeViewNotifierProvider);

  // Rest of your existing code
  final permissionStatus = await ref.watch(
    phonePermissionsStatusProvider.future,
  );

  if (!permissionStatus.isGranted && !Platform.isIOS) {
    yield const HomeViewRestricted();
    return;
  }

  final servicesAsyncValue = ref.watch(emergencyServicesProvider);

  yield servicesAsyncValue.when(
    data: (services) => HomeViewData(
      services,
      ref.read(settingsProvider),
    ),
    loading: () => const HomeViewLoading(),
    error: (error, stack) => throw error,
  );
});
