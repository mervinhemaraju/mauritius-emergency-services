// Database provider
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/data/api/mes_services.dart';
import 'package:mauritius_emergency_services/data/impl/mes_service_impl.dart';
import 'package:mauritius_emergency_services/data/local/mes_services.dart';
import 'package:mauritius_emergency_services/data/repository/mes_service.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';
import 'package:objectbox/objectbox.dart';

// Riverpod implementations
final objectBoxProvider = Provider<Store>((ref) {
  throw UnimplementedError('Initialize this in your main.dart');
});

final mesServiceLocalDataSourceProvider =
    Provider<MesServiceLocalDataSource>((ref) {
  final store = ref.watch(objectBoxProvider);
  return MesServiceLocalDataSource(store);
});

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final mesServiceRemoteDataSourceProvider = Provider<MesDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return MesServiceApiDataSource(dio);
});

final mesServiceRepositoryProvider = Provider<MesServiceRepository>((ref) {
  final remoteDataSource = ref.watch(mesServiceRemoteDataSourceProvider);
  final localDataSource = ref.watch(mesServiceLocalDataSourceProvider);
  return MesServiceCacheImpl(remoteDataSource, localDataSource);
});
