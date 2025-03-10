import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:http/http.dart' as http;

class TransportBidDetailController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addMarkers();
    // addPolyline();
    getRoute();
  }



  static const apiKey = Constant.googleApiKey;
  late GoogleMapController mapController;
  final LatLng startLatLng = LatLng(37.7749, -122.4194); // Example: San Francisco
  final LatLng endLatLng = LatLng(34.0522, -118.2437); // Example: Los Angeles

  final Set<Marker> markers = {};
  RxSet<Polyline> polylines = <Polyline>{}.obs;

  void addMarkers() {
    markers.add(
      Marker(
        markerId: MarkerId("start"),
        position: startLatLng,
        infoWindow: InfoWindow(title: "Start Point"),
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId("end"),
        position: endLatLng,
        infoWindow: InfoWindow(title: "End Point"),
      ),
    );
  }



  void addPolyline() {
    polylines.add(
      Polyline(
        polylineId: PolylineId("route"),
        points: [startLatLng, endLatLng],
        color: AppColor.buttonColor,
        width: 5,
      ),
    );
  }


  void addPolylineAPI(List<LatLng> points) {
    // Create a new Polyline and add it to the set
    final newPolyline = Polyline(
      polylineId: PolylineId("route"),
      points: points,
      color: AppColor.googleColor,
      width: 5,
    );

    // Add the new Polyline to the set and trigger the update
    polylines.assignAll([...polylines.value, newPolyline]);
  }


  Future<void> getRoute() async {
    try{
      final String url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${startLatLng.latitude},${startLatLng.longitude}&destination=${endLatLng.latitude},${endLatLng.longitude}&key=$apiKey';

      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String polyline = data['routes'][0]['overview_polyline']['points'];

        addPolylineAPI(decodePolyline(polyline));
      } else {
        addPolyline();
        throw Exception('Failed to fetch directions');
      }
    }
    catch(e){
      addPolyline();
      print(e);
    }
  }



  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
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