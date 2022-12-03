import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_connection_state.dart';

class CheckConnectionCubit extends Cubit<CheckConnectionState> {
  CheckConnectionCubit() : super(CheckConnectionInitial()) {
    checkConnection();
  }

  final Connectivity connectivity = Connectivity();
  ConnectivityResult result = ConnectivityResult.none;

  void checkConnection() async {
    result = await connectivity.checkConnectivity();
    connectivityChecker(result: result);
    connectivity.onConnectivityChanged.listen((event) {
      connectivityChecker(result: event);
    });
  }

  void connectivityChecker({required ConnectivityResult result}) {
    if (result == ConnectivityResult.none) {
      emit(CheckConnectionNone());
    } else if (result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      emit(CheckConnectionInternet());
    }
  }
}
