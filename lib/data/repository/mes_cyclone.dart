import 'package:mauritius_emergency_services/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/models/cyclone_name.dart';
import 'package:mauritius_emergency_services/models/cyclone_report.dart';

abstract class MesCycloneRepository {
  // Gets the cyclone report from MES
  Future<CycloneReport> getCycloneReport();

  // Gets the cyclone names from MES
  Future<List<CycloneName>> getCycloneNames();

  // Gets the cyclone guidelines from MES
  Future<List<CycloneGuidelines>> getCycloneGuidelines();

  // Gets the cyclone report from MES for testing purposes ONLY
  Future<CycloneReport> getCycloneReportTesting();
}
