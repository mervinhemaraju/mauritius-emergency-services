import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/repository/mes_service.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';

class MesServiceImpl implements MesServiceRepository {
  final MesDataSource dataSource;

  MesServiceImpl(this.dataSource);

  @override
  Future<List<Service>> getAllServices([String lang = defaultLanguage]) async {
    return await dataSource.getAllServices(lang);
  }
}
