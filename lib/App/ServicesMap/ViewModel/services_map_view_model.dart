import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertier/App/ServicesMap/Services/MapService.dart';
import 'package:propertier/extensions/localization_extension.dart';

class ServicesMapViewModel extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<LatLng> animation;
  var markerPosition = const LatLng(37.7749, -122.4194).obs; // Initial position
  BitmapDescriptor customIcon;
  GoogleMapController? mapController; // Add map controller

  ServicesMapViewModel(this.customIcon);

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _showMap.value = true;
  }

  // Method to update the map controller when Google Map is created
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void startTracking(String? id) async {
    if (id == null) {
      return;
    }
    if (kDebugMode) {
      print("******** Starting ********");
    }
    Map<String, dynamic>? data = await MapService().getLocation(id);
    if (data != null) {
      double lat = double.parse(data['latitude_position'] ?? "37.7749");
      double lng = double.parse(data['longitude_position'] ?? "-122.4194");
      if (kDebugMode) {
        print(lat);
        print(lng);
      }
      moveMarker(LatLng(lat, lng));
      await Future.delayed(const Duration(seconds: 10));
      startTracking(id);
    }
  }

  // Move marker and update camera position
  void moveMarker(LatLng newPosition) {
    final LatLng oldPosition = markerPosition.value;

    animation = Tween<LatLng>(begin: oldPosition, end: newPosition).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animation.addListener(() {
      // Update marker position
      markerPosition.value = animation.value;

      // Move the camera to follow the marker
      mapController?.animateCamera(
        CameraUpdate.newLatLng(animation.value),
      );
    });

    animationController.forward(from: 0.0);
  }

  Future cancelOrder(String id, String reason) async {
    MapService().cancelOrder(id, reason);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  final RxBool _showMap = false.obs;
  bool get showMap => _showMap.value;

  final RxInt _selectedCancelIssue = 0.obs;
  int get selectedCancelIssue => _selectedCancelIssue.value;
  changeSelectedIssue(int index) {
    _selectedCancelIssue.value = index;
  }

  final RxBool _showCaneclButton = true.obs;
  bool get showCancelButton => _showCaneclButton.value;
  isShowCancelButton(bool val) {
    _showCaneclButton.value = val;
  }

  RxList<String> cencelJobIssue = <String>[
    Get.context!.local.not_answering,
    Get.context!.local.change_decision,
    Get.context!.local.not_reached
  ].obs;
}

// import 'dart:convert';
// import 'dart:ui' as ui;
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import 'package:flutter/services.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'package:propertier/constant/constant.dart';
// import 'package:propertier/extensions/localization_extension.dart';
//
// class ServicesMapViewModel extends GetxController with GetTickerProviderStateMixin {
//
//   @override
//   void onInit() {
//     _loadMapStyle();
//     // setCustomMarker();
//     // getPolyPoints();
//     getCurrentLocation();
//     super.onInit();
//   }
//
//
//   late GoogleMapController mapController;
//   final initialCameraPosition =
//       const CameraPosition(target: LatLng(28.402219, 70.314078), zoom: 16.0)
//           .obs;
//
//   final RxBool _showMap = false.obs;
//   bool get showMap => _showMap.value;
//
//   static const LatLng sourceLocation = LatLng(28.402219, 70.312447);
//   static const LatLng destinationLocation = LatLng(28.401667, 70.315171);
//
//   // final LatLng currentLocation = LatLng(28.402219, 70.314078);
//   Marker marker1 =
//       const Marker(markerId: MarkerId('source'), position: sourceLocation);
//   Marker marker2 = const Marker(
//       markerId: MarkerId('destination'), position: destinationLocation);
//
//   // Marker currentMarket = Marker(
//   //     markerId: MarkerId('CurrentMarker'),
//   //     icon: currentLocationMarker.value,
//   //     position: currentLocation);
//   RxList<dynamic> customMapStyle = [].obs;
//   Future<void> _loadMapStyle() async {
//     String jsonString = await rootBundle.loadString('assets/map.json');
//
//     customMapStyle.value = json.decode(jsonString);
//   }
//
//   RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
//   void getPolyPoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//
//     // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//     //   googleApiKey: Constant.google_api_key,
//     //   request: PolylineRequest(
//     //       origin:
//     //           PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//     //       destination: PointLatLng(
//     //           destinationLocation.latitude, destinationLocation.longitude),
//     //       mode: TravelMode.transit),
//     // );
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleApiKey: Constant.google_api_key,
//         request: PolylineRequest(
//             origin:
//                 PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//             destination: PointLatLng(
//                 destinationLocation.latitude, destinationLocation.longitude),
//             mode: TravelMode.transit));
//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//       debugPrint("polylineCoordinates ${polylineCoordinates.length}");
//     }
//   }
//
//   void onMapCreated(GoogleMapController controller) {
//     debugPrint('Map is Created');
//     mapController = controller;
//     // mapController.
//     mapController.setMapStyle(jsonEncode(customMapStyle));
//   }
//
//   Rx<Position>? _currentLocation = Position(latitude: 0.2, longitude: 2.2, timestamp: DateTime.now(), accuracy: 100, altitude: 10, altitudeAccuracy: 50, heading: 10, headingAccuracy: 50, speed: 0, speedAccuracy: 50).obs;
//   Position get currentLocation => _currentLocation!.value;
//
//   Future getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     await Geolocator.getCurrentPosition().then((value) {
//       debugPrint("Current location ${value.longitude}");
//       _currentLocation!.value = value;
//       _showMap.value = true;
//     });
//   }
//
//   Rx<BitmapDescriptor> currentLocationMarker =
//       BitmapDescriptor.defaultMarker.obs;
//   void setCustomMarker() {
//     _getCustomMarkerIcon(Constant.cycle, 80, 80, Colors.white).then((icon) {
//       currentLocationMarker.value = icon;
//     });
//   }
//
//   Future<BitmapDescriptor> _getCustomMarkerIcon(
//       String assetPath, int width, int height, Color color) async {
//     ByteData byteData = await rootBundle.load(assetPath);
//     Uint8List byteList = byteData.buffer.asUint8List();
//     final ui.Codec codec = await instantiateImageCodec(byteList,
//         targetWidth: width, targetHeight: height);
//     final ui.FrameInfo frameInfo = await codec.getNextFrame();
//     final ByteData? customMarkerBytes =
//         await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
//
//     ui.Image image = await _applyColorFilterToImage(
//       customMarkerBytes!,
//       color,
//     );
//     ByteData? imageData =
//         await image.toByteData(format: ui.ImageByteFormat.png);
//
//     return BitmapDescriptor.fromBytes(imageData!.buffer.asUint8List());
//   }
//
//   Future<ui.Image> _applyColorFilterToImage(
//       ByteData imageData, Color color) async {
//     final ui.Codec codec =
//         await ui.instantiateImageCodec(imageData.buffer.asUint8List());
//     final ui.FrameInfo frameInfo = await codec.getNextFrame();
//     final ui.Image image = frameInfo.image;
//
//     final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//     final ui.Canvas canvas = ui.Canvas(pictureRecorder);
//     final Paint paint = Paint()
//       ..colorFilter = ColorFilter.mode(color, BlendMode.srcIn);
//     canvas.drawImage(image, Offset.zero, paint);
//
//     return pictureRecorder.endRecording().toImage(image.width, image.height);
//   }
//
//
//
//   final RxInt _selectedCancelIssue = 0.obs;
//   int get selectedCancelIssue => _selectedCancelIssue.value;
//   changeSelectedIssue(int index) {
//     _selectedCancelIssue.value = index;
//   }
//
//   final RxBool _showCaneclButton = true.obs;
//   bool get showCancelButton => _showCaneclButton.value;
//   isShowCancelButton(bool val) {
//     _showCaneclButton.value = val;
//   }
//
//   RxList<String> cencelJobIssue = <String>[
//     Get.context!.local.notAnswering,
//     Get.context!.local.changeDecision,
//     Get.context!.local.notReached
//   ].obs;
// }
