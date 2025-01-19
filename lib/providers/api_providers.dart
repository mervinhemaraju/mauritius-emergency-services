import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/data/api/mes_cyclone.dart';
import 'package:mauritius_emergency_services/data/api/mes_services.dart';
import 'package:mauritius_emergency_services/data/repository/mes_cyclone.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/providers/api_providers.g.dart';

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
