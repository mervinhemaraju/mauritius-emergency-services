import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/package_version.g.dart';

@riverpod
Future<PackageInfo> packageInfo(Ref ref) => PackageInfo.fromPlatform();
