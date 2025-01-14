import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/core/providers/api_providers.dart';

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
