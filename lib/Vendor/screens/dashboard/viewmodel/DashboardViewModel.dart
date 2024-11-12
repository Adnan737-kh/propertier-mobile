import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../helpers/api_service.dart';

class DashboardViewModel extends GetxController {
  bool _isLoopActive = false;

  @override
  void onInit() {
    super.onInit();
  }

  void startLocationLoop() {
    if (_isLoopActive) return; // Prevent starting the loop multiple times
    _isLoopActive = true;
    _locationLoop();
  }

  void stopLocationLoop() {
    _isLoopActive = false; // Set to false to stop the loop
  }

  Future<void> _locationLoop() async {
    while (_isLoopActive) {
      final position = await Geolocator.getCurrentPosition();
      await updateVendorLocation(LatLng(position.latitude, position.longitude));
      await Future.delayed(Duration(seconds: 10));
    }
  }

  Future<void> updateVendorLocation(LatLng latLng) async {
    ApiService().updateVendorLocation(latLng, GetStorage().read('vendorUserId').toString());
  }
}
