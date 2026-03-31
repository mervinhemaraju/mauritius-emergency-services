import 'package:mauritius_emergency_services/data/contracts/cyclone/mes_cyclone_repository.dart';
import 'package:mauritius_emergency_services/data/contracts/services/mes_service_repository.dart';
import 'package:mauritius_emergency_services/data/contracts/cyclone/mes_cyclone_source.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_name.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_report.dart';

class MesCycloneImpl implements MesCycloneRepository {
  final MesCycloneSource remoteSource;

  const MesCycloneImpl({required this.remoteSource});

  @override
  Future<CycloneReport> getCycloneReport([String lang = defaultLanguage]) =>
      remoteSource.getCycloneReport(lang);

  @override
  Future<CycloneReport> getCycloneReportTesting([
    String lang = defaultLanguage,
  ]) => remoteSource.getCycloneReportTesting(lang);

  @override
  Future<List<CycloneName>> getCycloneNames([String lang = defaultLanguage]) =>
      remoteSource.getCycloneNames(lang);

  @override
  Future<List<CycloneGuidelines>> getCycloneGuidelines([
    String lang = defaultLanguage,
  ]) => remoteSource.getCycloneGuidelines(lang);
}
