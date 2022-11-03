

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final internetConnectionObserverProvider = Provider<InternetConnectionObserver>((ref) {
  final connection = InternetConnectionObserver(InternetConnectionChecker(), Connectivity());

  ref.onDispose(() {
    connection.hasConnectionStream.close();
  });

  return connection;
});

class InternetConnectionObserver {
  final InternetConnectionChecker _internetConnectionChecker;
  final Connectivity _connectivity;
  StreamController<bool> hasConnectionStream = StreamController<bool>.broadcast();

  InternetConnectionObserver(this._internetConnectionChecker, this._connectivity) {
    _init();
  }

  Future<void> _init() async {
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.mobile || event == ConnectivityResult.wifi) {
        final isConnected = await _internetConnectionChecker.hasConnection;
        hasConnectionStream.sink.add(isConnected);

      }
      else {
        final isConnected = await _internetConnectionChecker.hasConnection;
        hasConnectionStream.sink.add(isConnected);
      }
    });

  }

  Future<bool> isNetworkConnected() async {
    final isConnected = await _internetConnectionChecker.hasConnection;
    return isConnected;
  }

  

}