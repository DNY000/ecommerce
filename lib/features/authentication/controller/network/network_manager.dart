import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkManager extends GetxController {
  static NetworkManager get to => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  // Observable for connection status
  final Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();

    _streamSubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        if (results.isNotEmpty) {
          _updateConnectionStatus(results.first);
        }
      },
    );
  }

  /// Update connection status and show a notification if disconnected
  void _updateConnectionStatus(ConnectivityResult result) {
    connectionStatus.value = result;
    if (kDebugMode) {
      print('result: $result');
    }
    if (result == ConnectivityResult.none) {
      Get.snackbar(
        'No Internet Connection',
        'Please check your network settings.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  /// Check current connection status
  Future<bool> checkConnection() async {
    try {
      return await InternetConnectionChecker().hasConnection;
    } on PlatformException catch (e) {
      _handleError('Error checking connection: ${e.message}');
      return false;
    }
  }

  /// Handle errors (replace with a logging solution if available)
  void _handleError(String message) {
    if (kDebugMode) {
      print(message); // Replace with logging if applicable
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}
