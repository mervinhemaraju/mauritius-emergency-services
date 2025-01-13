import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/api/mes_cyclone.dart';
import 'package:mauritius_emergency_services/data/api/mes_services.dart';
import 'package:mauritius_emergency_services/data/impl/mes_service_impl.dart';
import 'package:mauritius_emergency_services/data/repository/mes_cyclone.dart';
import 'package:mauritius_emergency_services/data/repository/mes_service.dart';

// Define the dio provider
final _dioProvider = Provider((ref) => Dio());

// Initialize the MesRepository provider
final mesCycloneRepositoryProvider = Provider<MesCycloneRepository>((ref) {
  final dio = ref.watch(_dioProvider);
  return MesCycloneApi(dio);
});

// Initialize the MesRepository provider
final mesRepositoryProvider = Provider<MesServiceRepository>((ref) {
  final dio = ref.watch(_dioProvider);
  final dataSource = MesServiceApiDataSource(dio);
  return MesServiceImpl(dataSource);
});

// Services providers
final servicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(mesRepositoryProvider);
  return repository.getAllServices();
});

final emergencyServicesProvider = FutureProvider<List<Service>>((ref) async {
  final services = await ref.watch(servicesProvider.future);
  return services.where((service) => service.type == "E").toList();
});

// Cyclone providers
final cycloneReportProvider = FutureProvider<CycloneReport>((ref) async {
  final repository = ref.watch(mesCycloneRepositoryProvider);
  return repository.getCycloneReport();
});

final cycloneReportTestingProvider = FutureProvider<CycloneReport>((ref) async {
  final repository = ref.watch(mesCycloneRepositoryProvider);
  return repository.getCycloneReportTesting();
});

final cycloneGuidelinesProvider =
    FutureProvider<List<CycloneGuidelines>>((ref) async {
  final repository = ref.watch(mesCycloneRepositoryProvider);
  return repository.getCycloneGuidelines();
});

final cycloneNamesProvider = FutureProvider<List<CycloneNames>>((ref) async {
  final repository = ref.watch(mesCycloneRepositoryProvider);
  return repository.getCycloneNames();
});
