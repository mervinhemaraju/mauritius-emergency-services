import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  static final NetworkInfo _instance = NetworkInfo._internal();
  final Connectivity connectivity = Connectivity();

  factory NetworkInfo() {
    return _instance;
  }

  NetworkInfo._internal();

  Future<bool> get isConnectedToInternet async {
    final result = await connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
  }
}
