import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../constant/constant.dart';

class WaterBidDetailController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addMarkers();
  }


  static const apiKey = Constant.googleApiKey;
  late GoogleMapController mapController;
  final LatLng endLatLng = LatLng(34.0522, -118.2437); // Example: Los Angeles
  final Set<Marker> markers = {};


  void addMarkers() {
    markers.add(
      Marker(
        markerId: MarkerId("end"),
        position: endLatLng,
        infoWindow: InfoWindow(title: "Drop Point"),
      ),
    );
  }


  //  SLIDER

  RxInt carousalIndex = 0.obs;
  RxList<String> album = [
    "https://cdn.dribbble.com/userupload/3662351/file/original-22f8cd9a9dd114a84bac4c0029e3ce03.jpg",
    "https://www.solid-run.com/wp-content/uploads/2020/10/Linux-based-IoT-router-for-automotive-1030x667.jpg",
    "https://www.solid-run.com/wp-content/uploads/2020/10/Linux-based-IoT-router-for-automotive-1030x667.jpg",
    "https://cdn.dribbble.com/userupload/3662351/file/original-22f8cd9a9dd114a84bac4c0029e3ce03.jpg",
  ].obs;
}