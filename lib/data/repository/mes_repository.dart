import 'package:mauritius_emergency_services/core/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/datasources/mes_datasource.dart';

const defaultLanguage = "en";

abstract class MesRepository {
  // Gets a list of all MES services
  Future<List<Service>> getAllServices([String lang = defaultLanguage]);

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

class MesRepositoryImpl implements MesRepository {
  final MesDataSource dataSource;

  MesRepositoryImpl(this.dataSource);

  @override
  Future<List<Service>> getAllServices([String lang = defaultLanguage]) async {
    return await dataSource.getAllServices(lang);
  }

  @override
  Future<CycloneReport> getCycloneReport(
      [String lang = defaultLanguage]) async {
    return await dataSource.getCycloneReport(lang);
  }

  @override
  Future<List<CycloneGuidelines>> getCycloneGuidelines(
      [String lang = defaultLanguage]) async {
    return await dataSource.getCycloneGuidelines(lang);
  }

  @override
  Future<List<CycloneNames>> getCycloneNames(
      [String lang = defaultLanguage]) async {
    return await dataSource.getCycloneNames(lang);
  }

  @override
  Future<CycloneReport> getCycloneReportTesting(
      [String lang = defaultLanguage]) async {
    return await dataSource.getCycloneReportTesting(lang);
  }
}
