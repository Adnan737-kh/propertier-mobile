import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Services/Service/ServicesCore.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/screens/dashboard/home/Model/home_model.dart';
import 'package:propertier/Vendor/screens/dashboard/home/Service/HomeService.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../../App/Auth/Login/Model/login_response_model.dart';
import '../../../../../App/Services/Model/services_model.dart';
import '../../../../helpers/api_service.dart';
import '../../profile/model/profile_model.dart';


class WebSocketController extends GetxController {
  late WebSocketChannel channel;
  RxList<Bid> onlineBids = <Bid>[].obs; // Online bids list
  RxList<Bid> offlineBids = <Bid>[].obs; // Offline bids list (remains empty)
  RxString selectedService = "".obs;

  @override
  void onInit() {
    super.onInit();
    // connectToWebSocket(); // Connect to WebSocket on init
    loadProfile();
  }

  // Establish WebSocket connection
  void connectToWebSocket() {
    try {
      String url = "${API.listenOrderByCustomer}${selectedService.value}/";
      if (kDebugMode) {
        print("**starting**");
        print(url);
      }

      channel = WebSocketChannel.connect(
        Uri.parse(url),
      );

      channel.stream.listen(
        (data) {
          if (kDebugMode) {
            print("data is here");
          }
          handleWebSocketData(data);
        },
        onError: (error) {
          if (kDebugMode) {
            print('WebSocket Error: ${error.hashCode},');
          }
        },
        onDone: () {
          if (kDebugMode) {
            print('WebSocket connection closed.');
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error connecting to WebSocket: $e');
      }
    }
  }

  // Handle incoming WebSocket data
 void handleWebSocketData(dynamic data) {
  try {
    final jsonData = jsonDecode(data);
    if (kDebugMode) {
      print("here is order data: $jsonData");
    }
    if (jsonData is Map && jsonData.containsKey('bids')) {
      final bidsData = jsonData['bids'] as List;

      List<Bid> newBids = bidsData.map((bidJson) => Bid.fromJson(bidJson)).toList();

      onlineBids.clear();
      onlineBids.addAll(newBids);
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error parsing WebSocket data: $e');
    }
  }
}

  Future<List<ParentServicesModel>> getAllParentServices(BuildContext context)async{
    return ServicesCore().getAllParentServices(context: context);
  }

  Future<UserData?> getUser(String id)async{
    return await HomeService().getUser(id);
  }


  var profile = ProfileModel();

  Future<void> loadProfile() async {

    String? vendorUserId = (await ApiService().getVendorUserId());

    if (vendorUserId != null) {
      try {
        ProfileModel profile = await ApiService().fetchProfile(vendorUserId);
        this.profile = profile;
        selectedService.value = profile.professionTypes?[0].toString()??"";
        if(selectedService.value != ""){
          connectToWebSocket();
          Fluttertoast.showToast(msg: "You are live");
        }
        else{
          Fluttertoast.showToast(msg: "Couldn't Get Bids!");
        }

      } catch (e) {
        print('Error loading profile: $e');
      }
    } else {
      print('Vendor user ID not found');
    }
  }

  @override
  void onClose() {
    channel.sink.close(); // Close the WebSocket connection
    super.onClose();
  }
}
