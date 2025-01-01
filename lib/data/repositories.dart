import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/datasources.dart';

const defaultLanguage = "en";

abstract class MesRepository {
  Future<List<Service>> getServices([String lang = defaultLanguage]);
}

class MesRepositoryImpl implements MesRepository {
  final MesDataSource dataSource;

  MesRepositoryImpl(this.dataSource);

  @override
  Future<List<Service>> getServices([String lang = defaultLanguage]) async {
    return await dataSource.getServices(lang);
  }
}
