import 'dart:ui';

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
        return ServicesNoInternetState(
          t.messages.error.services_unavailable(
            app_name_short: t.app.short_name.toUpperCase(),
          ),
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

@riverpod
class ExpandedServiceState extends _$ExpandedServiceState {
  @override
  String? build() => null;

  void toggleExpansion(String identifier) {
    state = state == identifier ? null : identifier;
  }
}

@riverpod
class DismissibleBackgroundColorState
    extends _$DismissibleBackgroundColorState {
  @override
  Color? build() => null;

  void setColor(Color color) {
    state = color;
  }
}
