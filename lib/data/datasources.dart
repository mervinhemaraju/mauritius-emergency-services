import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';

abstract class MesDataSource {
  Future<List<Service>> getServices(String lang);
}

class MesRemoteDataSource implements MesDataSource {
  static final endpoint = "https://mes.mervinhemaraju.com/api";
  static final version = "v1";

  final Dio dio;

  MesRemoteDataSource(this.dio);

  @override
  Future<List<Service>> getServices(String lang) async {
    // Make API call
    final response = await dio.get("$endpoint/$version/$lang/services");

    if (!response.data["success"]) {
      throw Exception(
        'An error occured while retrieving the services. Please try again later.',
      );
    }

    // Retrieve the services as List
    final services = response.data['services'] as List;

    // Convert the List to a List of Service objects
    return services.map((json) => Service.fromJson(json)).toList();
  }
}
