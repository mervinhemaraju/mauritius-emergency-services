import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/network_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'network_info.g.dart';

// Add provider for NetworkInfo
// final networkInfoProvider = Provider<NetworkInfo>((ref) {
//   return NetworkInfo(Connectivity());
// });

@riverpod
NetworkInfo networkInfo(Ref ref) {
  /*
  * Gets the network info provider
  */

  // Return the network info provider
  return NetworkInfo(Connectivity());
}
