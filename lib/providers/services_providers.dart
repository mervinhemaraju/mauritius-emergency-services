// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:mauritius_emergency_services/providers/local_database.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:pair/pair.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/providers/services_providers.g.dart';

@riverpod
Future<List<Service>> services(Ref ref) async {
  /*
  * Gets the list of services from the service repository
  */

  // Get the service repository provider
  final repository = ref.watch(mesServiceRepositoryProvider);

  // Watch the locale settings
  final locale = ref.watch(
    mesSettingsNotifierProvider.select((settings) => settings.locale),
  );

  // Return the list of services
  return await repository.getAllServices(locale.lang);
}

@riverpod
Future<Pair<Service, List<Service>>> emergencyServices(Ref ref) async {
  /*
  * Gets the list of emergency services from the list of services
  */

  // Watch the services
  final services = await ref.watch(servicesProvider.future);

  // Get the emergency button action
  final emergencyButtonAction = ref.watch(
    mesSettingsNotifierProvider.select((s) => s.emergencyButtonAction),
  );

  // Filter out emergency services
  final emergencyServices =
      services.where((service) => service.type == "E").toList();

  // Return the list of emergency services
  return Pair(emergencyButtonAction, emergencyServices);
}
