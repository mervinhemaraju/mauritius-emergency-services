import 'package:mauritius_emergency_services/data/impl/rt_permissions_impl.dart';
import 'package:mauritius_emergency_services/data/repository/rt_permissions_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/rt_permissions_provider.g.dart';

@riverpod
RuntimePermissionsRepository runtimePermissions(Ref ref) {
  return const RuntimePermissionsImpl();
}
