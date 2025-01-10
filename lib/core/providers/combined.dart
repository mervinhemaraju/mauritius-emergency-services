import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/permitted_service.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome/perms.dart';

final permittedServiceProvider = FutureProvider<PermittedService>((ref) async {
  // Wait for emergency services to resolve
  final services = await ref.watch(emergencyServicesProvider.future);

  // Get the current permissions state
  final permissionsState = ref.watch(permissionsStateProvider);

  // Handle permissions state
  final isPermissionsGranted = permissionsState.maybeWhen(
    data: (isGranted) => isGranted,
    orElse: () => false, // Default to false if loading or error
  );

  // Combine into PermittedService
  return PermittedService(
    services: services,
    isPermissionsGranted: isPermissionsGranted,
  );
});
