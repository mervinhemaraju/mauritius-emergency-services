import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_name.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_report.dart';

/// Contract for any data source that can provide cyclone data.
abstract class MesCycloneSource {
  Future<CycloneReport> getCycloneReport(String lang);
  Future<List<CycloneName>> getCycloneNames(String lang);
  Future<List<CycloneGuidelines>> getCycloneGuidelines(String lang);

  /// Testing-only endpoint — should not be used in production flows.
  Future<CycloneReport> getCycloneReportTesting(String lang);
}
