import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  Future<bool> get isConnectedToInternet async {
    // Gets the connectivity info
    final result = await connectivity.checkConnectivity();

    // Checks if connected to wifi or data
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
  }
}
