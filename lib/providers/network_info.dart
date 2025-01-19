import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/providers/network_info.g.dart';

@riverpod
NetworkInfo networkInfo(Ref ref) {
  /*
  * Gets the network info provider
  */

  // Return the network info provider
  return NetworkInfo(Connectivity());
}
