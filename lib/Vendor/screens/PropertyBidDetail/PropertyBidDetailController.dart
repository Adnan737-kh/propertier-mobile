import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../constant/constant.dart';

class PropertyBidDetailController extends GetxController{

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
    "https://media.cnn.com/api/v1/images/stellar/prod/221222080739-11-architecture-projects-in-2023-abrahamic-family-house.jpg?q=w_2000,c_fill",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPGii0YX6Muo2plXLnKmyyPS4mXfFIMzMbUQ&s",
    "https://media.cnn.com/api/v1/images/stellar/prod/221222080739-11-architecture-projects-in-2023-abrahamic-family-house.jpg?q=w_2000,c_fill",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPGii0YX6Muo2plXLnKmyyPS4mXfFIMzMbUQ&s",
    "https://media.cnn.com/api/v1/images/stellar/prod/221222080739-11-architecture-projects-in-2023-abrahamic-family-house.jpg?q=w_2000,c_fill",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPGii0YX6Muo2plXLnKmyyPS4mXfFIMzMbUQ&s",
  ].obs;
}