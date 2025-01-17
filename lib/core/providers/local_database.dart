import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/api_providers.dart';
import 'package:mauritius_emergency_services/core/providers/network_info.dart';
import 'package:mauritius_emergency_services/data/impl/mes_service_impl.dart';
import 'package:mauritius_emergency_services/data/local/mes_services.dart';
import 'package:mauritius_emergency_services/data/repository/mes_service.dart';
import 'package:objectbox/objectbox.dart';

// Define the object box provider
final objectBoxProvider = Provider<Store>((ref) {
  throw UnimplementedError('Initialize this in your main.dart');
});

// Define the local data source provider
final _mesServiceLocalDataSourceProvider =
    Provider<MesServiceLocalDataSource>((ref) {
  final store = ref.watch(objectBoxProvider);
  return MesServiceLocalDataSource(store);
});

// Define the mes repository provider
final mesServiceRepositoryProvider = Provider<MesServiceRepository>((ref) {
  final remoteDataSource = ref.watch(mesServiceRemoteDataSourceProvider);
  final localDataSource = ref.watch(_mesServiceLocalDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return MesServiceCacheImpl(remoteDataSource, localDataSource, networkInfo);
});
