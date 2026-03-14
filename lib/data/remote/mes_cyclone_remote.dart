import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/data/helpers/api_constants.dart';
import 'package:mauritius_emergency_services/data/sources/mes_cyclone_source.dart';
import 'package:mauritius_emergency_services/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/models/cyclone_name.dart';
import 'package:mauritius_emergency_services/models/cyclone_report.dart';

class MesCycloneRemote implements MesCycloneSource {
  final Dio dio;

  const MesCycloneRemote(this.dio);

  @override
  Future<CycloneReport> getCycloneReport(String lang) => _fetch(
    lang,
    'cyclone/report',
    (data) => CycloneReport.fromJson(data['report']),
  );

  @override
  Future<CycloneReport> getCycloneReportTesting(String lang) => _fetch(
    lang,
    'cyclone/report/testing',
    (data) => CycloneReport.fromJson(data['report']),
  );

  @override
  Future<List<CycloneName>> getCycloneNames(String lang) => _fetch(
    lang,
    'cyclone/names',
    (data) => (data['names'] as List)
        .map((json) => CycloneName.fromJson(json as Map<String, dynamic>))
        .toList(),
  );

  @override
  Future<List<CycloneGuidelines>> getCycloneGuidelines(String lang) => _fetch(
    lang,
    'cyclone/guidelines',
    (data) => (data['guidelines'] as List)
        .map((json) => CycloneGuidelines.fromJson(json as Map<String, dynamic>))
        .toList(),
  );

  // ---------------------------------------------------------------------------

  Future<T> _fetch<T>(
    String lang,
    String path,
    T Function(Map<String, dynamic> data) mapper,
  ) async {
    final response = await dio.get(ApiConstants.versioned(lang, path));

    if (response.data['success'] != true) {
      final msg = response.data['message']?.toString();
      throw Exception(
        (msg != null && msg.isNotEmpty)
            ? msg
            : 'An error occurred while fetching $path. Please try again later.',
      );
    }

    return mapper(response.data as Map<String, dynamic>);
  }
}
