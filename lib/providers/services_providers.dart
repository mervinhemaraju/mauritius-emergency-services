import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:mauritius_emergency_services/providers/local_database.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/providers/services_providers.g.dart';

// TODO(Get rid of this class.)
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
class ServicesNotifier extends _$ServicesNotifier {
  @override
  Future<List<Service>> build() => _fetchServices();

  Future<List<Service>> _fetchServices() async {
    // Get the service repository provider
    final repository = ref.watch(mesServiceRepositoryProvider);

    // Watch the locale settings
    final locale = ref.watch(
      mesSettingsNotifierProvider.select((settings) => settings.locale),
    );

    // Return the list of services
    return await repository.getAllServices(locale.lang);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchServices);
  }
}
