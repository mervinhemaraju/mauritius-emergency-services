// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/local_database.dart';
import 'package:mauritius_emergency_services/core/providers/settings_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'services_providers.g.dart';

// // Services providers
// final servicesProvider = FutureProvider<List<Service>>((ref) async {
//   final repository = ref.watch(mesServiceRepositoryProvider);
//   final settings = ref.watch(settingsProvider);

//   return repository.getAllServices(settings.locale.lang);
// });

// final emergencyServicesProvider = FutureProvider<List<Service>>((ref) async {
//   final services = await ref.watch(servicesProvider.future);
//   return services.where((service) => service.type == "E").toList();
// });

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
Future<List<Service>> emergencyServices(Ref ref) async {
  /*
  * Gets the list of emergency services from the list of services
  */

  // Watch the services
  final services = await ref.watch(servicesProvider.future);

  // Return the list of emergency services
  return services.where((service) => service.type == "E").toList();
}
