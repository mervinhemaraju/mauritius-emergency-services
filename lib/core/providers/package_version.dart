import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'package_version.g.dart';

// Provider for PackageInfo
// final packageInfoProvider = FutureProvider<PackageInfo>((ref) {
//   return PackageInfo.fromPlatform();
// });

// // Provider for just the version without build number
// final appVersion = Provider<AsyncValue<String>>((ref) {
//   return ref.watch(packageInfoProvider).whenData((packageInfo) {
//     return packageInfo.version;
//   });
// });

@riverpod
Future<PackageInfo> packageInfo(Ref ref) async {
  /*
  * Gets the package info provider
  */

  // Return the package info provider
  return await PackageInfo.fromPlatform();
}
