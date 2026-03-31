import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_name.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_report.dart';

abstract class MesCycloneRepository {
  Future<CycloneReport> getCycloneReport([String lang]);
  Future<List<CycloneName>> getCycloneNames([String lang]);
  Future<List<CycloneGuidelines>> getCycloneGuidelines([String lang]);

  /// Testing-only — do not expose in production UI.
  Future<CycloneReport> getCycloneReportTesting([String lang]);
}
