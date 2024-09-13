import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as geocode;

import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertier/App/Auth/Service/auth_service.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../extensions/list_of_types.dart';
import '../../Auth/Login/Model/user_login_model/user_login_model.dart';
import '../services/customer_request_services.dart';

class WhatAreYouSearchViewModel extends GetxController {
  var priceValue = const SfRangeValues(10.0, 100.0).obs;
  TextEditingController searchAddressTextController = TextEditingController();
  TextEditingController customAreaSizeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController decriptionController = TextEditingController();
  var areaValue = 100.0.obs;

  var user = User().obs;

  final _selecttype = ListOfTypes().types[0].obs;
  String get selecttype => _selecttype.value;
  setSelecttype(value) => _selecttype.value = value;

  final _selectPurpose = 'sale'.obs;
  get selectPurpose => _selectPurpose.value;
  setSelectPurpose(value) {
    if (value == 0) {
      _selectPurpose.value = "sale";
    } else {
      _selectPurpose.value = "rent";
    }
  }

  final _selectSize = '5 Marla'.obs;
  get selectSize => _selectSize.value;
  setSelectSize(value) => _selectSize.value = value;

  var sizeType = [
    "2.5 Marla",
    "5 Marla",
    "10 Marla",
    "15 Marla",
    "25 Marla",
    "50 Marla",
    "90 Marla"
  ].obs;

  late GoogleMapController mapController;

  var initialCameraPosition =
      const CameraPosition(target: LatLng(6.931970, 79.857750), zoom: 16.0).obs;

  RxList<String> searchList = <String>[].obs;

  searchAddress(String val) {
    if (address.contains(val)) {
      for (var ad in address) {
        searchList.add(ad);
      }
    }
  }

  // RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  // Future getPolyPoints({
  //   required double lat,
  //   required double lng,
  //   required double deslat,
  //   required double deslng,
  // }) async {
  //   print("LAT $lat, LANG $lng");
  //   print("LAT $deslat, LANG $deslng");
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     "AIzaSyDvxDnKdW_m8voPTbPtzYXtDoQmGMnnosg",
  //     PointLatLng(lat, lng),
  //     PointLatLng(deslat, deslng),
  //   );
  //   if (result.points.isNotEmpty) {
  //     for (var point in result.points) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //       update();
  //     }
  //     print("polylineCoordinates ${polylineCoordinates.length}");
  //   }
  // }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void goToInitialPosition() async {
    places.clear();

    List<geocode.Placemark> placeMark = await geocode.placemarkFromCoordinates(
        _latitude.value, _longitude.value);
    geocode.Placemark place = placeMark[0];
    String addressName = "${place.name}, ${place.locality}, ${place.country}";
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_latitude.value, _longitude.value), zoom: 16.0)));
    markerPosition.add(
      Marker(
        markerId: const MarkerId('currentPosition'),
        position: LatLng(_latitude.value, _longitude.value),
        infoWindow: InfoWindow(
          title: addressName,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  // Function to handle zooming out
  void zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }

  final RxString _selectedPlace = ''.obs;
  final RxBool _locationLoading = false.obs;

  RxBool get locationLoading => _locationLoading;

  String get selectedPlace => _selectedPlace.value;
  Future setSelectedPlace(String value) async {
    _locationLoading.value = true;

    _selectedPlace.value = value;
    searchAddressTextController.text = value;
    places.value = [];
    List<geocode.Location> locations =
        await geocode.locationFromAddress(_selectedPlace.value);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(locations.first.latitude, locations.first.longitude),
        zoom: 14)));
    _locationLoading.value = false;
    // if (!_selectedPlace.contains(value)) _selectedPlace.add(value);
  }

  RxSet<Marker> markerPosition = <Marker>{}.obs;
  RxList<String> address = <String>[].obs;
  void updateMarkerPosition(double lat, double lng) async {
    print("UPDATED MARKER $lat, $lng");
    if (markerPosition.length > 2) {
      markerPosition.clear();
    }
    List<geocode.Placemark> currentPlace = await geocode
        .placemarkFromCoordinates(_latitude.value, _longitude.value);
    geocode.Placemark current = currentPlace[0];
    String currentAddress =
        "${current.name}, ${current.locality}, ${current.country}";
    List<geocode.Placemark> destnationPlace =
        await geocode.placemarkFromCoordinates(lat, lng);
    geocode.Placemark place = destnationPlace[0];
    String destinationAddress =
        "${place.name}, ${place.locality}, ${place.country}";
    address.add("${place.name}, ${place.locality}, ${place.country}");
    // ignore: unnecessary_null_comparison
    if (lat != null || lng != null) {
      markerPosition.clear();
      markerPosition.add(
        Marker(
            infoWindow: InfoWindow(
              title: currentAddress,
            ),
            icon: BitmapDescriptor.defaultMarker,
            markerId: const MarkerId('CurrentMarker'),
            position: LatLng(_latitude.value, _longitude.value)),
      );
      markerPosition.add(
        Marker(
          markerId: const MarkerId("destinationMarker"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: destinationAddress,
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    } else {
      markerPosition.add(
        Marker(
            infoWindow: InfoWindow(
              title: currentAddress,
            ),
            icon: BitmapDescriptor.defaultMarker,
            markerId: const MarkerId('CurrentMarker'),
            position: LatLng(_latitude.value, _longitude.value)),
      );
    }
  }

  final RxDouble _arrivallat = (0.0).obs;
  double get arrivallat => _arrivallat.value;

  final RxDouble _arrivalLang = (0.0).obs;
  double get arrivalLang => _arrivalLang.value;
  Future getArrivalLatLang() async {
    List<geocode.Location> locations =
        await geocode.locationFromAddress(_selectedPlace.value);
    print(locations.first.latitude);
    _arrivallat.value = locations.first.latitude.toDouble();
    _arrivalLang.value = locations.first.longitude.toDouble();
    print("LAtitude is this ${_arrivallat.value}, ${_arrivalLang.value}");
  }

  final RxDouble _latitude = (0.0).obs;
  double get latitude => _latitude.value;
  final RxDouble _longitude = (0.0).obs;
  double get longitude => _longitude.value;

  final RxString _currentAddress = ''.obs;
  String get currentAddress => _currentAddress.value;

  Future<void> showProminentDisclosure(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Access Required'),
          content: const Text(
            'This app collects location data to enable [feature] even when the app is closed or not in use. This data is used to [explain purpose], and will not be shared with third parties.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> getLocation(BuildContext context) async {
    // Show prominent disclosure
    Future.delayed(Durations.long4, () async {
      await showProminentDisclosure(context);
    });

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
      _currentAddress.value =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      print("Current Address ${_currentAddress.value}");

      _latitude.value = position.latitude;
      _longitude.value = position.longitude;
    }
  }

  @override
  Future<void> onInit() async {
    getLocation(Get.context!).whenComplete(() {
      initialCameraPosition.value = CameraPosition(
          target: LatLng(_latitude.value, _longitude.value), zoom: 16.0);
    });
    await AuthService().getCurrentUser().then(
      (value) {
        user.value = value!.users!.first;
      },
    ).then(
      (value) {
        nameController.text = user.value.name!;
        phoneNumberController.text =
            user.value.phoneNumberCountryCode! + user.value.phoneNumber!;
        emailController.text = user.value.email!;
      },
    );

    super.onInit();
  }

  var isLoading = false.obs;
  Future<void> postCustomerRequest() async {
    isLoading(true);
    await CustomerRequest().addRequest(
        context: Get.context!,
        name: nameController.text,
        purpose: selectPurpose,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        description: decriptionController.text,
        city: selectedPlace,
        area: "${areaValue.value}",
        max_price: priceValue.value.end
            .toString()
            .substring(0, priceValue.value.end.toString().indexOf(".")),
        min_price: priceValue.value.start
            .toString()
            .substring(0, priceValue.value.start.toString().indexOf(".")),
        agent: user.value.id!.toString(),
        area_unit: "marla",
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        size: selectSize,
        type: selecttype);
    isLoading(false);
  }

  RxList<Place> places = <Place>[].obs;

  Future<void> searchPlaces(String input,
      {bool isCurrentLocation = false}) async {
    const apiKey = 'AIzaSyC0EAVt8egPftM2_zHoEl6mev3go1NLmx8';
    const endpoint =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final url = '$endpoint?input=$input&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.statusCode);
      final data = json.decode(response.body);
      print('Prediction $data');
      final predictions = data['predictions'] as List<dynamic>;
      print("Prediction ${predictions.length}");
      places.value = predictions
          .map((prediction) => Place(
                placeId: prediction['place_id'],
                description: prediction['description'],
              ))
          .toList();
      List<geocode.Location> locations =
          await geocode.locationFromAddress(places[1].description);
      if (isCurrentLocation == true) {
        initialCameraPosition.value = CameraPosition(
            target:
                LatLng(locations.first.latitude, locations.first.longitude));
        _latitude.value = locations.first.latitude;
        _longitude.value = locations.first.longitude;
      } else {}
    } else {
      places.value = [];
    }
  }
}

class Place {
  final String placeId;
  final String description;
  double? latitude;
  double? longitude;

  Place(
      {this.latitude,
      this.longitude,
      required this.placeId,
      required this.description});
}
