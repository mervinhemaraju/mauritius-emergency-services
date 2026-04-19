import 'package:connectivity_plus/connectivity_plus.dart';

class MesNetworkInfo {
  static final MesNetworkInfo _instance = MesNetworkInfo._internal();
  final Connectivity connectivity = Connectivity();

  factory MesNetworkInfo() {
    return _instance;
  }

  MesNetworkInfo._internal();

  Future<bool> get isConnectedToInternet async {
    final result = await connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
  }
}
