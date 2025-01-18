import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/core/providers/api_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cyclone_providers.g.dart';

// Cyclone providers
// final cycloneReportProvider = FutureProvider<CycloneReport>((ref) async {
//   final repository = ref.watch(mesCycloneRepositoryProvider);
//   return repository.getCycloneReport();
// });

// final cycloneReportTestingProvider = FutureProvider<CycloneReport>((ref) async {
//   final repository = ref.watch(mesCycloneRepositoryProvider);
//   return repository.getCycloneReportTesting();
// });

// final cycloneGuidelinesProvider =
//     FutureProvider<List<CycloneGuidelines>>((ref) async {
//   final repository = ref.watch(mesCycloneRepositoryProvider);
//   return repository.getCycloneGuidelines();
// });

// final cycloneNamesProvider = FutureProvider<List<CycloneNames>>((ref) async {
//   final repository = ref.watch(mesCycloneRepositoryProvider);
//   return repository.getCycloneNames();
// });

@riverpod
Future<CycloneReport> cycloneReport(Ref ref) async {
  /*
  * Gets the cyclone report
  */

  // Get the cyclone repository provider
  final repository = ref.watch(mesCycloneRepositoryProvider);

  // Return the cyclone report
  return await repository.getCycloneReport();
}

@riverpod
Future<CycloneReport> cycloneReportTesting(Ref ref) async {
  /*
  * Gets the cyclone report for testing
  */

  // Get the cyclone repository provider
  final repository = ref.watch(mesCycloneRepositoryProvider);

  // Return the cyclone report
  return await repository.getCycloneReportTesting();
}

@riverpod
Future<List<CycloneGuidelines>> cycloneGuidelines(Ref ref) async {
  /*
  * Gets the list of cyclone guidelines
  */

  // Get the cyclone repository provider
  final repository = ref.watch(mesCycloneRepositoryProvider);

  // Return the list of cyclone guidelines
  return await repository.getCycloneGuidelines();
}

@riverpod
Future<List<CycloneNames>> cycloneNames(Ref ref) async {
  /*
  * Gets the list of cyclone names
  */

  // Get the cyclone repository provider
  final repository = ref.watch(mesCycloneRepositoryProvider);

  // Return the list of cyclone names
  return await repository.getCycloneNames();
}
