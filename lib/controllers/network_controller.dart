import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  // Observable variable to track connectivity status
  var isConnected = true.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    _startListening();
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  void _startListening() {
    // Check initial connectivity
    _checkInitialConnectivity();
    // TODO: Implement connectivity subscription
    // Listen to connectivity changes
    // _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      // (ConnectivityResult result) {
      // Update connectivity status based on the result
      // isConnected.value = (result != ConnectivityResult.none);
    // }
    // );
  }

  // Check initial connectivity status when the app starts
  Future<void> _checkInitialConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    isConnected.value = (result != ConnectivityResult.none);
  }
}
