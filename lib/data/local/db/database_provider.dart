import 'package:mauritius_emergency_services/data/local/db/local_database.dart';
import 'package:mauritius_emergency_services/data/local/db/mes_service_local.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/data/local/db/database_provider.g.dart';

@riverpod
LocalDatabase localDatabase(Ref ref) {
  return LocalDatabase.instance;
}

@riverpod
MesServiceLocal mesServiceLocal(Ref ref) {
  return MesServiceLocal(localDatabase: ref.watch(localDatabaseProvider));
}
