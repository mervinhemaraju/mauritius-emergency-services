import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/data/api/mes_cyclone.dart';
import 'package:mauritius_emergency_services/data/api/mes_services.dart';
import 'package:mauritius_emergency_services/data/repository/mes_cyclone.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'api_providers.g.dart';

// Define the dio provider
// final _dioProvider = Provider((ref) => Dio());

// // The cyclone repository provider
// final mesCycloneRepositoryProvider = Provider<MesCycloneRepository>((ref) {
//   final dio = ref.watch(_dioProvider);
//   final settings = ref.watch(settingsProvider);
//   return MesCycloneApi(
//     dio: dio,
//     defaultLanguage: settings.locale.lang,
//   );
// });

// // The services repository provider
// final mesServiceRemoteDataSourceProvider = Provider<MesDataSource>((ref) {
//   final dio = ref.watch(_dioProvider);
//   return MesServiceApiDataSource(dio);
// });

@riverpod
MesCycloneRepository mesCycloneRepository(Ref ref) {
  // Define the dio provider
  final dio = Dio();

  // Watch the locale settings
  final locale = ref.watch(
    mesSettingsNotifierProvider.select((settings) => settings.locale),
  );

  // Return the cyclone api repo
  return MesCycloneApi(
    dio: dio,
    defaultLanguage: locale.lang,
  );
}

@riverpod
MesDataSource mesServiceRemoteDataSource(Ref ref) {
  // Define the dio provider
  final dio = Dio();

  // Return the service api data source
  return MesServiceApiDataSource(dio);
}
