import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/providers/api_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/providers/cyclone_providers.g.dart';

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
