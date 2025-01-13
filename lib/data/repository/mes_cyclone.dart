import 'package:mauritius_emergency_services/core/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';

// Defines the default language
const defaultLanguage = "en";

abstract class MesCycloneRepository {
  // Gets the cyclone report from MES
  Future<CycloneReport> getCycloneReport([String lang = defaultLanguage]);

  // Gets the cyclone names from MES
  Future<List<CycloneNames>> getCycloneNames([String lang = defaultLanguage]);

  // Gets the cyclone guidelines from MES
  Future<List<CycloneGuidelines>> getCycloneGuidelines([
    String lang = defaultLanguage,
  ]);

  // Gets the cyclone report from MES for testing purposes ONLY
  Future<CycloneReport> getCycloneReportTesting([
    String lang = defaultLanguage,
  ]);
}
