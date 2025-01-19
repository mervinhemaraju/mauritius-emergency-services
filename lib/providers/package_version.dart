import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/providers/package_version.g.dart';

@riverpod
Future<PackageInfo> packageInfo(Ref ref) async {
  /*
  * Gets the package info provider
  */

  // Return the package info provider
  return await PackageInfo.fromPlatform();
}
