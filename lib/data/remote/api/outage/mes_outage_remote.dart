import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/data/helpers/api_constants.dart';
import 'package:mauritius_emergency_services/data/contracts/outages/mes_outage_source.dart';
import 'package:mauritius_emergency_services/core/models/outage/mes_district_outage.dart';

class CebOutageRemote implements CebOutageSource {
  final Dio dio;

  const CebOutageRemote(this.dio);

  @override
  Future<List<CebDistrictOutage>> getOutages(String lang) async {
    final response = await dio.get(ApiConstants.versioned(lang, 'ceb/outages'));

    if (response.data['success'] != true) {
      final msg = response.data['message']?.toString();
      throw Exception(
        (msg != null && msg.isNotEmpty)
            ? msg
            : 'An error occurred while retrieving power outages. Please try again later.',
      );
    }

    return (response.data['district_outages'] as List)
        .map((json) => CebDistrictOutage.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
