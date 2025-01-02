import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/datasources.dart';
import 'package:mauritius_emergency_services/data/repositories.dart';

// Define the dio provider
final _dioProvider = Provider((ref) => Dio());

// Initialize the MesRepository provider
final mesRepositoryProvider = Provider<MesRepository>((ref) {
  final dio = ref.watch(_dioProvider);
  final dataSource = MesRemoteDataSource(dio);
  return MesRepositoryImpl(dataSource);
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
  final repository = ref.watch(mesRepositoryProvider);
  return repository.getCycloneReport();
});

final cycloneReportTestingProvider = FutureProvider<CycloneReport>((ref) async {
  final repository = ref.watch(mesRepositoryProvider);
  return repository.getCycloneReportTesting();
});

final cycloneGuidelinesProvider =
    FutureProvider<List<CycloneGuidelines>>((ref) async {
  final repository = ref.watch(mesRepositoryProvider);
  return repository.getCycloneGuidelines();
});

final cycloneNamesProvider = FutureProvider<List<CycloneNames>>((ref) async {
  final repository = ref.watch(mesRepositoryProvider);
  return repository.getCycloneNames();
});
