import 'package:mauritius_emergency_services/core/models/network_info.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/local/mes_services.dart';
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
    try {
      // Get network connection info
      final isConnected = await networkInfo.isConnectedToInternet;

      // If connected to network
      if (isConnected) {
        // Fetch services from API
        final remoteServices = await remoteDataSource.getAllServices(lang);

        // Update the cache
        await localDataSource.cacheServices(remoteServices, lang);

        // Return the services
        return remoteServices;
      } else {
        // If offline, try to get from cache
        final localServices = await localDataSource.getAllServices(lang);

        // Return the services
        return localServices;
      }

      // // Try to get from local storage first
      // final localServices = await localDataSource.getAllServices(lang);

      // if (localServices.isNotEmpty) {
      //   print("Services found locally. Fetching from cache...");
      //   return localServices;
      // }

      // // If local storage is empty, fetch from API
      // final remoteServices = await remoteDataSource.getAllServices(lang);

      // // Cache the services
      // await localDataSource.cacheServices(remoteServices, lang);

      // print("Services fetched from API and cached locally.");

      // return remoteServices;
    } catch (e) {
      print("Error fetching services: $e");

      rethrow;
    }
  }
}
