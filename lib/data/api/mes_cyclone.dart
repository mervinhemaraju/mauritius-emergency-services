import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_names.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/data/repository/mes_cyclone.dart';

class MesCycloneApi implements MesCycloneRepository {
  static const _endpoint = "https://mes.mervinhemaraju.com/api";
  static const _version = "v1";

  final Dio dio;

  MesCycloneApi(this.dio);

  // Helper method to reduce duplication
  Future<T> _handleApiCall<T>({
    required String path,
    required T Function(dynamic data) mapper,
    required String errorMessage,
  }) async {
    final response = await dio.get("$_endpoint/$_version/$path");

    if (!response.data["success"]) {
      throw Exception(
        response.data["message"]?.toString() ??
            'An error occurred while $errorMessage. Please try again later.',
      );
    }

    return mapper(response.data);
  }

  @override
  Future<List<CycloneGuidelines>> getCycloneGuidelines(
      [String lang = defaultLanguage]) async {
    return _handleApiCall(
      path: '$lang/cyclone/guidelines',
      mapper: (data) => (data['guidelines'] as List)
          .map((json) => CycloneGuidelines.fromJson(json))
          .toList(),
      errorMessage: 'retrieving the cyclone guidelines',
    );
  }

  @override
  Future<List<CycloneNames>> getCycloneNames(
      [String lang = defaultLanguage]) async {
    return _handleApiCall(
      path: '$lang/cyclone/names',
      mapper: (data) => (data['names'] as List)
          .map((json) => CycloneNames.fromJson(json))
          .toList(),
      errorMessage: 'retrieving the cyclone names',
    );
  }

  @override
  Future<CycloneReport> getCycloneReport(
      [String lang = defaultLanguage]) async {
    return _handleApiCall(
      path: '$lang/cyclone/report',
      mapper: (data) => CycloneReport.fromJson(data['report']),
      errorMessage: 'retrieving the cyclone report',
    );
  }

  @override
  Future<CycloneReport> getCycloneReportTesting(
      [String lang = defaultLanguage]) async {
    return _handleApiCall(
      path: '$lang/cyclone/report/testing',
      mapper: (data) => CycloneReport.fromJson(data['report']),
      errorMessage: 'retrieving the cyclone report',
    );
  }
}
