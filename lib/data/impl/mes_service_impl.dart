import 'package:mauritius_emergency_services/data/local/mes_services.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:mauritius_emergency_services/data/repository/mes_service.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';

// Create a repository implementation that handles both local and remote data
class MesServiceCacheImpl implements MesServiceRepository {
  final MesDataSource remoteDataSource;
  final MesServiceLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MesServiceCacheImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<List<Service>> getAllServices([String lang = defaultLanguage]) async {
    // Add into a try except to catch errors
    try {
      // Get the services offline first
      final localServices = await localDataSource.getAllServices(lang);

      // Get network connection info
      final isConnected = await networkInfo.isConnectedToInternet;

      // If connected to network
      if (isConnected) {
        // Fetch services from API
        final remoteServices = await remoteDataSource.getAllServices(lang);

        // Update the cache
        localDataSource.cacheServices(remoteServices);

        // Return the remote services
        return remoteServices;
      }

      // Return the services
      return localServices;
    } catch (e) {
      rethrow;
    }
  }
}
