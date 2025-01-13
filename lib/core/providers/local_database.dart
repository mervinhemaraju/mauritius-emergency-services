// Database provider
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/api/mes_services.dart';
import 'package:mauritius_emergency_services/data/impl/mes_service_impl.dart';
import 'package:mauritius_emergency_services/data/local/mes_services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final databaseProvider = Provider<Database>((ref) {
  throw UnimplementedError('Database must be initialized before use');
});

// Initialize database
Future<Database> initializeDatabase() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'mes_database.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await MesServiceLocalDataSource.createTables(db);
    },
  );
}

// Data sources providers
final mesLocalDataSourceProvider = Provider<MesServiceLocalDataSource>((ref) {
  final database = ref.watch(databaseProvider);
  return MesServiceLocalDataSource(database);
});

final mesRemoteDataSourceProvider = Provider<MesServiceApiDataSource>((ref) {
  return MesServiceApiDataSource(Dio());
});

// Repository provider
final mesRepositoryProvider = Provider<MesCachingRepository>((ref) {
  final remoteDataSource = ref.watch(mesRemoteDataSourceProvider);
  final localDataSource = ref.watch(mesLocalDataSourceProvider);
  return MesCachingRepository(remoteDataSource, localDataSource);
});

// Services provider
final sp = FutureProvider.family<List<Service>, String>((ref, lang) async {
  final repository = ref.watch(mesRepositoryProvider);
  return repository.getAllServices(lang);
});
