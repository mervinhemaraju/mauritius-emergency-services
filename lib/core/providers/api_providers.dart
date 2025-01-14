import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/data/api/mes_cyclone.dart';
import 'package:mauritius_emergency_services/data/api/mes_services.dart';
import 'package:mauritius_emergency_services/data/repository/mes_cyclone.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';

// Define the dio provider
final _dioProvider = Provider((ref) => Dio());

// The cyclone repository provider
final mesCycloneRepositoryProvider = Provider<MesCycloneRepository>((ref) {
  final dio = ref.watch(_dioProvider);
  return MesCycloneApi(dio);
});

// The services repository provider
final mesServiceRemoteDataSourceProvider = Provider<MesDataSource>((ref) {
  final dio = ref.watch(_dioProvider);
  return MesServiceApiDataSource(dio);
});
