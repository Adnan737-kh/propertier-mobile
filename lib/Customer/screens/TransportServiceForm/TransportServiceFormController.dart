import 'dart:convert';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/constant/colors.dart';
import '../../../App/What are you searching/ViewModel/what_are_viewmodel.dart';
import '../../../constant/constant.dart';
import 'package:geocoding/geocoding.dart' as geocode;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'dart:math' show cos, sqrt, asin;


class TransportServiceFormController extends GetxController{

  static const apiKey = Constant.google_api_key;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController materialController = TextEditingController();

  RxList<Place> places = <Place>[].obs;

  Rxn pickupLocation = Rxn();
  Rxn dropLocation = Rxn();
  LatLng? startPosition;
  LatLng? endPosition;
  Rxn totalDistance = Rxn();
  List<int> possiblePrices = [80, 100, 120];
  Rxn selectedPrice = Rxn();
  Rxn dateTime = Rxn();

  // Future<void> searchPlaces(String input,
  //     {bool isCurrentLocation = false}) async {
  //   const endpoint =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //   final url = '$endpoint?input=$input&key=$apiKey';
  //
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     print(response.statusCode);
  //     final data = json.decode(response.body);
  //     print('Prediction $data');
  //     final predictions = data['predictions'] as List<dynamic>;
  //     print("Prediction ${predictions.length}");
  //     places.value = predictions
  //         .map((prediction) => Place(
  //       placeId: prediction['place_id'],
  //       description: prediction['description'],
  //     ))
  //         .toList();
  //   } else {
  //     places.value = [];
  //   }
  // }

  Future<void> searchPlaces(String input, {bool isCurrentLocation = false}) async {
    const autocompleteEndpoint =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    const detailsEndpoint =
        'https://maps.googleapis.com/maps/api/place/details/json';
    final url = '$autocompleteEndpoint?input=$input&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List<dynamic>;
      print("Predictions count: ${predictions.length}");

      // Fetch details for each place
      List<Place> placesList = [];
      for (var prediction in predictions) {
        final placeId = prediction['place_id'];
        final description = prediction['description'];

        // Fetch lat/lng using Place Details API
        final detailsUrl = '$detailsEndpoint?place_id=$placeId&key=$apiKey';
        final detailsResponse = await http.get(Uri.parse(detailsUrl));

        if (detailsResponse.statusCode == 200) {
          final detailsData = json.decode(detailsResponse.body);
          final location = detailsData['result']['geometry']['location'];
          final latitude = location['lat'];
          final longitude = location['lng'];

          // Add the place to the list
          placesList.add(
            Place(
              placeId: placeId,
              description: description,
              latitude: latitude,
              longitude: longitude,
            ),
          );
        } else {
          print('Failed to fetch details for placeId: $placeId');
        }
      }

      places.value = placesList;
    } else {
      print('Failed to fetch autocomplete predictions: ${response.statusCode}');
      places.value = [];
    }
  }



  Future<String> getDistanceInKm({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    final String origin = '$startLatitude,$startLongitude';
    final String destination = '$endLatitude,$endLongitude';
    const apiKey = Constant.google_api_key;

    final String url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
        '?origins=$origin'
        '&destinations=$destination'
        '&mode=driving'
        '&key=$apiKey';

    try {
      print(url);
      final response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extract the distance text
        final String distanceText = data['rows'][0]['elements'][0]['distance']['text'];
        totalDistance.value = distanceText;
        return distanceText; // e.g., "2.1 km"
      } else {
        print('Failed to fetch distance: ${response.statusCode}');
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      return 'Error: $e';
    }
  }




  void showDateTimePicker(BuildContext context) {
    BottomPicker.dateTime(
      pickerTitle: Text(
        'Set the event exact time and date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      onSubmit: (date) {
        print(date);
        dateTime.value = date;
      },
      onClose: () {
        Get.back();
      },
      minDateTime: DateTime.now(),
      maxDateTime: DateTime.now().add(Duration(days: 7)),
      initialDateTime: DateTime.now(),
      gradientColors: [
        AppColor.buttonColor,
        AppColor.buttonColor,
      ],
    ).show(context);
  }
}