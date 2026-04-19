import 'package:mauritius_emergency_services/data/contracts/permissions/rt_permissions_impl.dart';
import 'package:mauritius_emergency_services/data/contracts/permissions/rt_permissions_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/data/local/permissions/rt_permissions_provider.g.dart';

@riverpod
RuntimePermissionsRepository runtimePermissions(Ref ref) {
  return const RuntimePermissionsImpl();
}
