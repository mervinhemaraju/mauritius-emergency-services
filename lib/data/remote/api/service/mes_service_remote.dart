import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/core/models/service/service.dart';
import 'package:mauritius_emergency_services/data/contracts/services/mes_service_source.dart';
import 'package:mauritius_emergency_services/data/helpers/api_constants.dart';

class MesServiceRemote implements MesServiceSource {
  final Dio dio;

  const MesServiceRemote(this.dio);

  @override
  Future<List<MesService>> getAllServices(String lang) async {
    final response = await dio.get(ApiConstants.versioned(lang, 'services'));

    _assertSuccess(response, 'retrieving services');

    return (response.data['services'] as List)
        .map((json) => MesService.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  void _assertSuccess(Response<dynamic> response, String context) {
    if (response.data['success'] == true) return;
    final msg = response.data['message']?.toString();
    throw Exception(
      (msg != null && msg.isNotEmpty)
          ? msg
          : 'An error occurred while $context. Please try again later.',
    );
  }
}
