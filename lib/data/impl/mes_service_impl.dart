import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/local/mes_services.dart';
import 'package:mauritius_emergency_services/data/repository/mes_service.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';

// Create a repository implementation that handles both local and remote data
class MesServiceCacheImpl implements MesServiceRepository {
  final MesDataSource remoteDataSource;
  final MesServiceLocalDataSource localDataSource;

  MesServiceCacheImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<Service>> getAllServices([String lang = defaultLanguage]) async {
    try {
      // Try to get from local storage first
      final localServices = await localDataSource.getAllServices(lang);

      if (localServices.isNotEmpty) {
        print("Services found locally. Fetching from cache...");
        return localServices;
      }

      // If local storage is empty, fetch from API
      final remoteServices = await remoteDataSource.getAllServices(lang);

      // Cache the services
      await localDataSource.cacheServices(remoteServices, lang);

      print("Services fetched from API and cached locally.");

      return remoteServices;
    } catch (e) {
      print("Error fetching services: $e");

      rethrow;
    }
  }
}
