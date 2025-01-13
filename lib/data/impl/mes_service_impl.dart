import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/api/mes_services.dart';
import 'package:mauritius_emergency_services/data/local/mes_services.dart';
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

// Repository implementation with caching
class MesCachingRepository implements MesServiceRepository {
  final MesServiceApiDataSource remoteDataSource;
  final MesServiceLocalDataSource localDataSource;

  MesCachingRepository(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<Service>> getAllServices([String lang = defaultLanguage]) async {
    try {
      // Try to get from local storage first
      final localServices = await localDataSource.getAllServices(lang);

      if (localServices.isNotEmpty) {
        print("Services have already been cached, returning from cache.");
        return localServices;
      }

      print("Services have not been cached, fetching from remote.");

      // If local storage is empty, fetch from remote
      final remoteServices = await remoteDataSource.getAllServices(lang);

      // Cache the fetched services
      await localDataSource.cacheServices(remoteServices, lang);

      return remoteServices;
    } catch (e) {
      print("Failed to fetch services. $e");

      // If remote fails, try to get from local storage
      // final localServices = await localDataSource.getAllServices(lang);

      // if (localServices.isNotEmpty) {
      //   return localServices;
      // }

      rethrow;
    }
  }
}
