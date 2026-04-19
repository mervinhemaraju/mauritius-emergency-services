import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/outage/mes_district_outage.dart';
import 'package:mauritius_emergency_services/data/contracts/outages/mes_outage_impl.dart';
import 'package:mauritius_emergency_services/data/contracts/outages/mes_outage_repository.dart';
import 'package:mauritius_emergency_services/data/local/preferences/settings_provider.dart';
import 'package:mauritius_emergency_services/data/remote/api/dio_provider.dart';
import 'package:mauritius_emergency_services/data/remote/api/outage/mes_outage_remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../../generated/data/remote/api/outage/mes_outage_provider.g.dart';

@riverpod
CebOutageRemote cebOutageRemote(Ref ref) {
  return CebOutageRemote(ref.watch(dioProvider));
}

@riverpod
CebOutageRepository cebOutageRepository(Ref ref) {
  return CebOutageImpl(remoteSource: ref.watch(cebOutageRemoteProvider));
}

/// One-shot provider — reacts automatically to locale changes.
@riverpod
Future<List<CebDistrictOutage>> cebOutagesList(Ref ref) {
  final lang = ref.watch(mesSettingsProvider.select((s) => s.locale.lang));
  return ref.watch(cebOutageRepositoryProvider).getOutages(lang);
}

/// Notifier variant — use when you need pull-to-refresh.
@riverpod
class CebOutagesNotifier extends _$CebOutagesNotifier {
  @override
  Future<List<CebDistrictOutage>> build() => _fetch();

  Future<List<CebDistrictOutage>> _fetch() {
    final lang = ref.watch(mesSettingsProvider.select((s) => s.locale.lang));
    return ref.watch(cebOutageRepositoryProvider).getOutages(lang);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetch);
  }
}
