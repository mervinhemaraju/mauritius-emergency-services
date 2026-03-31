import 'package:mauritius_emergency_services/data/local/db/mes_service_local.dart';
import 'package:mauritius_emergency_services/data/contracts/services/mes_service_repository.dart';
import 'package:mauritius_emergency_services/data/contracts/services/mes_service_source.dart';
import 'package:mauritius_emergency_services/core/models/app/network_info.dart';
import 'package:mauritius_emergency_services/core/models/service/service.dart';

/// Offline-first strategy:
/// 1. Always read from local cache first.
/// 2. When online, fetch fresh data from remote and update the cache.
/// 3. Return remote data if available, otherwise fall back to cache.
class MesServiceImpl implements MesServiceRepository {
  final MesServiceSource remoteSource;
  final MesServiceLocal localSource;
  final MesNetworkInfo networkInfo;

  const MesServiceImpl({
    required this.remoteSource,
    required this.localSource,
    required this.networkInfo,
  });

  @override
  Future<List<MesService>> getAllServices([
    String lang = defaultLanguage,
  ]) async {
    final localServices = await localSource.getAllServices(lang);
    final isConnected = await networkInfo.isConnectedToInternet;

    if (!isConnected) return localServices;

    final remoteServices = await remoteSource.getAllServices(lang);
    // Fire-and-forget cache update — don't block the return value.
    unawaited(localSource.cacheServices(remoteServices));
    return remoteServices;
  }
}

/// Silences the "unawaited future" lint without importing async.
void unawaited(Future<void> future) {}
