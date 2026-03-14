import 'package:mauritius_emergency_services/data/impl/mes_cyclone_impl.dart';
import 'package:mauritius_emergency_services/data/remote/mes_cyclone_remote.dart';
import 'package:mauritius_emergency_services/data/repository/mes_cyclone_repository.dart';
import 'package:mauritius_emergency_services/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/mes_cyclone_provider.g.dart';

@riverpod
MesCycloneRemote mesCycloneRemote(Ref ref) {
  return MesCycloneRemote(ref.watch(dioProvider));
}

@riverpod
MesCycloneRepository mesCycloneRepository(Ref ref) {
  return MesCycloneImpl(remoteSource: ref.watch(mesCycloneRemoteProvider));
}
