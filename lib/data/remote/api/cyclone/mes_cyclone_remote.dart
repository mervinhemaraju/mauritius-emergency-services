import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_name.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_report.dart';
import 'package:mauritius_emergency_services/data/contracts/cyclone/mes_cyclone_source.dart';
import 'package:mauritius_emergency_services/data/helpers/api_constants.dart';

class MesCycloneRemote implements MesCycloneSource {
  final Dio dio;

  const MesCycloneRemote(this.dio);

  @override
  Future<MesCycloneReport> getCycloneReport(String lang) => _fetch(
    lang,
    'cyclone/report',
    (data) => MesCycloneReport.fromJson(data['report'] as Map<String, dynamic>),
  );

  @override
  Future<MesCycloneReport> getCycloneReportTesting(String lang) => _fetch(
    lang,
    'cyclone/report/testing',
    (data) => MesCycloneReport.fromJson(data['report'] as Map<String, dynamic>),
  );

  @override
  Future<List<MesCycloneName>> getCycloneNames(String lang) => _fetch(
    lang,
    'cyclone/names',
    (data) => (data['names'] as List)
        .map((json) => MesCycloneName.fromJson(json as Map<String, dynamic>))
        .toList(),
  );

  @override
  Future<List<MesCycloneGuidelines>> getCycloneGuidelines(String lang) =>
      _fetch(
        lang,
        'cyclone/guidelines',
        (data) => (data['guidelines'] as List)
            .map(
              (json) =>
                  MesCycloneGuidelines.fromJson(json as Map<String, dynamic>),
            )
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
