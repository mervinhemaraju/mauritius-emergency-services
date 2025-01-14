import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Provider for PackageInfo
final packageInfoProvider = FutureProvider<PackageInfo>((ref) {
  return PackageInfo.fromPlatform();
});

// Provider for just the version without build number
final appVersion = Provider<AsyncValue<String>>((ref) {
  return ref.watch(packageInfoProvider).whenData((packageInfo) {
    return packageInfo.version;
  });
});
