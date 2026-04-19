import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_name.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_report.dart';

abstract class MesCycloneRepository {
  Future<MesCycloneReport> getCycloneReport([String lang]);
  Future<List<MesCycloneName>> getCycloneNames([String lang]);
  Future<List<MesCycloneGuidelines>> getCycloneGuidelines([String lang]);

  /// Testing-only — do not expose in production UI.
  Future<MesCycloneReport> getCycloneReportTesting([String lang]);
}
