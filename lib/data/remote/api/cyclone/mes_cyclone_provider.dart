import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_name.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_report.dart';
import 'package:mauritius_emergency_services/data/contracts/cyclone/mes_cyclone_impl.dart';
import 'package:mauritius_emergency_services/data/contracts/cyclone/mes_cyclone_repository.dart';
import 'package:mauritius_emergency_services/data/remote/api/cyclone/mes_cyclone_remote.dart';
import 'package:mauritius_emergency_services/data/remote/api/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../../generated/data/remote/api/cyclone/mes_cyclone_provider.g.dart';

@riverpod
MesCycloneRemote mesCycloneRemote(Ref ref) {
  return MesCycloneRemote(ref.watch(dioProvider));
}

@riverpod
MesCycloneRepository mesCycloneRepository(Ref ref) {
  return MesCycloneImpl(remoteSource: ref.watch(mesCycloneRemoteProvider));
}

@riverpod
Future<List<MesCycloneGuidelines>> mesCycloneGuidelines(
  Ref ref,
  String lang,
) async {
  return ref.watch(mesCycloneRepositoryProvider).getCycloneGuidelines(lang);
}

@riverpod
Future<MesCycloneReport> mesCycloneReport(Ref ref, String lang) async {
  return ref.watch(mesCycloneRepositoryProvider).getCycloneReport(lang);
}

@riverpod
Future<List<MesCycloneName>> mesCycloneNames(Ref ref, String lang) async {
  return ref.watch(mesCycloneRepositoryProvider).getCycloneNames(lang);
}
