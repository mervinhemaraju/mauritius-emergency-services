import 'package:mauritius_emergency_services/data/helpers/database_helper.dart';
import 'package:mauritius_emergency_services/data/local/mes_service_local.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/database_provider.g.dart';

@riverpod
LocalDatabase localDatabase(Ref ref) {
  return LocalDatabase.instance;
}

@riverpod
MesServiceLocal mesServiceLocal(Ref ref) {
  return MesServiceLocal(localDatabase: ref.watch(localDatabaseProvider));
}
