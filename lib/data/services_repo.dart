import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';

abstract class ServicesRepository {
  Future<List<Service>> getServices();
}

abstract class ServicesDataSource {
  Future<List<Service>> getServices();
}

class ServicesRepositoryImpl implements ServicesRepository {
  final ServicesDataSource dataSource;

  ServicesRepositoryImpl(this.dataSource);

  @override
  Future<List<Service>> getServices() async {
    return await dataSource.getServices();
  }
}

class ServicesRemoteDataSource implements ServicesDataSource {
  final Dio dio;

  ServicesRemoteDataSource(this.dio);

  @override
  Future<List<Service>> getServices() async {
    final response =
        await dio.get("https://mes.mervinhemaraju.com/api/v1/en/services");

    final services = response.data['services'] as List;

    return services
        .map((json) => Service(
              identifier: json['identifier'],
              name: json['name'],
              icon: json['icon'],
              type: json['type'],
              emails: List<String>.from(json['emails']),
              mainContact: json['main_contact'],
              otherContacts: List<int>.from(json['other_contacts']),
            ))
        .toList();
  }
}
