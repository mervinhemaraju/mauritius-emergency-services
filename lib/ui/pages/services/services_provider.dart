import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/providers/services_providers.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../../../generated/pages/services/services_provider.g.dart';

@riverpod
Future<ServicesState> servicesState(Ref ref) async {
  // Add to try catch to catch errors
  try {
    // Get the list of services
    final services = await ref.watch(servicesNotifierProvider.future);

    // If the services list is empty, check the internet connection
    if (services.isEmpty) {
      // Get the network info
      final isConnectedToInternet = await NetworkInfo().isConnectedToInternet;

      // If not connected to internet
      if (!isConnectedToInternet) {
        return const ServicesNoInternetState(
          // TODO(Add to constants)
          "No services available. Please check your internet connection and try again.",
        );
      }
    }

    // Set the UI state
    return ServicesUiState(services);
  } catch (e) {
    return ServicesErrorState(
      t.messages.error.cannot_load_data,
    );
  }
}
