import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geocode;

import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertier/Vendor/screens/dashboard/home/Service/HomeService.dart';

class DetailScreenController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLocation(Get.context!).whenComplete(() {
      // initialCameraPosition.value = CameraPosition(
      //     target: LatLng(latitude.value, longitude.value), zoom: 16.0);
      showMyLocation();
    });
  }

  void showMyLocation(){
    print("Moving...");
    mapController.moveCamera(CameraUpdate.newLatLng(LatLng(latitude.value, longitude.value)));
  }

  late GoogleMapController mapController;

  var initialCameraPosition =
      const CameraPosition(target: LatLng(6.931970, 79.857750), zoom: 16.0).obs;
  final RxDouble latitude = (0.0).obs;

  final RxDouble longitude = (0.0).obs;


  final RxString currentAddress = ''.obs;

  Future<void> getLocation(BuildContext context) async {
    // Show prominent disclosure

    // Request permission
    geolocator.LocationPermission permission =
    await geolocator.Geolocator.requestPermission();

    if (permission == geolocator.LocationPermission.denied ||
        permission == geolocator.LocationPermission.deniedForever) {
      // Handle the scenario if location permission is denied or denied forever
      return;
    }

    if (permission == geolocator.LocationPermission.whileInUse ||
        permission == geolocator.LocationPermission.always) {
      // Get the current position
      geolocator.Position position =
      await geolocator.Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high,
      );

      List<geocode.Placemark> placemarks = await geocode
          .placemarkFromCoordinates(position.latitude, position.longitude);

      geocode.Placemark place = placemarks[0];
      currentAddress.value =
      "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

      latitude.value = position.latitude;
      longitude.value = position.longitude;
      markers.add(
          Marker(
            markerId: const MarkerId('start'),
            position: LatLng(latitude.value, longitude.value),
          )
      );
    }
  }
  final TextEditingController amountC = TextEditingController();
  RxString amount = "".obs;

  RxSet<Marker> markers = <Marker>{}.obs;

  Future addOffer(String bidId)async{
    if(amount.value == ""){
      Get.showSnackbar(const GetSnackBar(title: "Amount required", message: "Enter your offer",));
      return;
    }
    bool res = await HomeService().addOffer(bidId, amount.value, "-");
    if(res){
      Get.showSnackbar(const GetSnackBar(title: "Successfull", message: "Bid placed.",));
      Get.back();
    }
  }
}