import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/providers/services_providers.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/ui/pages/home/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../../../generated/pages/home/home_provider.g.dart';

@riverpod
Future<HomeState> homeState(Ref ref) async {
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
        return HomeNoInternetState(
          t.messages.error.services_unavailable(
            app_name_short: t.app.short_name.toUpperCase(),
          ),
        );
      }
    }

    // Get the emergency button action
    final emergencyButtonAction = ref.watch(
      mesSettingsNotifierProvider.select((s) => s.emergencyButtonAction),
    );

    // Filter out emergency services
    final emergencyServices =
        services.where((service) => service.type == "E").toList();

    // Set the UI state
    return HomeUiState(emergencyServices, emergencyButtonAction);
  } catch (e) {
    return HomeErrorState(
      t.messages.error.cannot_load_data,
    );
  }
}
