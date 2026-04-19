// lib/data/remote/api/alerts/mes_alert_provider.dart
import 'package:mauritius_emergency_services/data/contracts/alerts/mes_alert_impl.dart';
import 'package:mauritius_emergency_services/data/contracts/alerts/mes_alert_repository.dart';
import 'package:mauritius_emergency_services/data/remote/api/alerts/mes_alert_remote.dart';
import 'package:mauritius_emergency_services/data/remote/api/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../../generated/data/remote/api/alerts/mes_alert_provider.g.dart';

@riverpod
MesAlertRemote mesAlertRemote(Ref ref) {
  return MesAlertRemote(ref.watch(dioProvider));
}

@riverpod
MesAlertRepository mesAlertRepository(Ref ref) {
  return MesAlertImpl(remoteSource: ref.watch(mesAlertRemoteProvider));
}
