import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/providers/api_providers.dart';
import 'package:mauritius_emergency_services/data/impl/mes_service_impl.dart';
import 'package:mauritius_emergency_services/data/local/mes_services.dart';
import 'package:mauritius_emergency_services/data/repository/mes_service.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/local_database.g.dart';

@riverpod
Store objectBox(Ref ref) {
  /*
  * Gets the object box provider
  */

  throw UnimplementedError('Initialize this in your main.dart');
}

@riverpod
MesServiceLocalDataSource mesServiceLocalDataSource(Ref ref) {
  /*
  * Gets the local data source for the MES service
  */

  // Get the object box provider
  final store = ref.watch(objectBoxProvider);

  // Return the local data source
  return MesServiceLocalDataSource(store);
}

@riverpod
MesServiceRepository mesServiceRepository(Ref ref) {
  /*
  * Gets the MES service repository
  */

  // Get the remote data source
  final remoteDataSource = ref.watch(mesServiceRemoteDataSourceProvider);

  // Get the local data source
  final localDataSource = ref.watch(mesServiceLocalDataSourceProvider);

  // Get the network info
  final networkInfo = NetworkInfo();

  // Return the repository
  return MesServiceCacheImpl(remoteDataSource, localDataSource, networkInfo);
}
