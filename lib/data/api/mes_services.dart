import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';

class MesServiceApiDataSource implements MesDataSource {
  static final endpoint = "https://mes.mervinhemaraju.com/api";
  static final version = "v1";

  final Dio dio;

  MesServiceApiDataSource(this.dio);

  @override
  Future<List<Service>> getAllServices(String lang) async {
    // Make API call
    final response = await dio.get("$endpoint/$version/$lang/services");

    // Check for errors
    if (!response.data["success"]) {
      if (response.data["message"].toString().isNotEmpty) {
        throw Exception(
          response.data["message"].toString(),
        );
      } else {
        throw Exception(
          'An error occured while retrieving the services. Please try again later.',
        );
      }
    }

    // Retrieve the services as List
    final services = response.data['services'] as List;

    // Convert the List to a List of Service objects
    return services.map((json) => Service.fromJson(json)).toList();
  }
}
