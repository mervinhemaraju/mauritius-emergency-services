import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/data/impl/mes_service_impl.dart';
import 'package:mauritius_emergency_services/data/remote/mes_service_remote.dart';
import 'package:mauritius_emergency_services/data/repository/mes_service_repository.dart';
import 'package:mauritius_emergency_services/models/app/network_info.dart';
import 'package:mauritius_emergency_services/models/service/service.dart';
import 'package:mauritius_emergency_services/providers/database_provider.dart';
import 'package:mauritius_emergency_services/providers/dio_provider.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/mes_service_provider.g.dart';

@riverpod
MesServiceRemote mesServiceRemote(Ref ref) {
  return MesServiceRemote(ref.watch(dioProvider));
}

@riverpod
MesServiceRepository mesServiceRepository(Ref ref) {
  return MesServiceImpl(
    remoteSource: ref.watch(mesServiceRemoteProvider),
    localSource: ref.watch(mesServiceLocalProvider),
    networkInfo: NetworkInfo(),
  );
}

/// Simple one-shot provider — use when you just need the list with no
/// manual refresh capability.
@riverpod
Future<List<Service>> mesServices(Ref ref) async {
  final lang = ref.watch(mesSettingsProvider.select((s) => s.locale.lang));
  return ref.watch(mesServiceRepositoryProvider).getAllServices(lang);
}

/// Notifier variant — use when you need pull-to-refresh or manual reload.
@riverpod
class ServicesNotifier extends _$ServicesNotifier {
  @override
  Future<List<Service>> build() => _fetch();

  Future<List<Service>> _fetch() {
    final lang = ref.watch(mesSettingsProvider.select((s) => s.locale.lang));
    return ref.watch(mesServiceRepositoryProvider).getAllServices(lang);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetch);
  }
}
