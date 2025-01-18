import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/local_database.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';

// Services providers
final servicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(mesServiceRepositoryProvider);
  final settings = ref.watch(settingsProvider);

  return repository.getAllServices(settings.locale.lang);
});

final emergencyServicesProvider = FutureProvider<List<Service>>((ref) async {
  final services = await ref.watch(servicesProvider.future);
  return services.where((service) => service.type == "E").toList();
});
