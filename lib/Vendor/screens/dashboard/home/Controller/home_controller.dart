import 'dart:convert';

import 'package:get/get.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/screens/dashboard/home/Model/home_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketController extends GetxController {
  late WebSocketChannel channel;
  RxList<Bid> onlineBids = <Bid>[].obs; // Online bids list
  RxList<Bid> offlineBids = <Bid>[].obs; // Offline bids list (remains empty)


  @override
  void onInit() {
    super.onInit();
    connectToWebSocket(); // Connect to WebSocket on init
  }

  // Establish WebSocket connection
  void connectToWebSocket() {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse(API.baseWebSocketURL),
      );

      channel.stream.listen(
        (data) {
          handleWebSocketData(data);
        },
        onError: (error) {
          print('WebSocket Error: $error');
        },
        onDone: () {
          print('WebSocket connection closed.');
        },
      );
    } catch (e) {
      print('Error connecting to WebSocket: $e');
    }
  }

  // Handle incoming WebSocket data
 void handleWebSocketData(dynamic data) {
  try {
    final jsonData = jsonDecode(data);

    if (jsonData is Map && jsonData.containsKey('bids')) {
      final bidsData = jsonData['bids'] as List;

      List<Bid> newBids = bidsData.map((bidJson) => Bid.fromJson(bidJson)).toList();

      onlineBids.clear();
      onlineBids.addAll(newBids);
    }
  } catch (e) {
    print('Error parsing WebSocket data: $e');
  }
}


  @override
  void onClose() {
    channel.sink.close(); // Close the WebSocket connection
    super.onClose();
  }
}
