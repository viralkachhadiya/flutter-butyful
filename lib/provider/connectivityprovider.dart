import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult connection;

  checkconnection() {
    _connectivity.onConnectivityChanged.listen((val) {
      connection = val;
      notifyListeners();
    });
    return connection;
  }
}
