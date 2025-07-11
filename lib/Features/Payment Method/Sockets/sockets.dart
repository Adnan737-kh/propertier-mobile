import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:propertier/Features/SelectFeatuedType/Controller/select_featued_type_controller.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PaymentStatusSocketService {
  late WebSocketChannel _channel;

  // Initialize the WebSocket connection
  void connect(String url) {
    _channel = IOWebSocketChannel.connect(url);

    // Listen to incoming messages
    _channel.stream.listen(
      (message) {
        // Handle incoming messages
        var json = jsonDecode(message);
        log('Received: $message');
        String data = message.toString();
        // var msg = PaymentSocketModel.fromJson();
        log('just message Received: $json');
        // log('Received: ${msg.message}');

        if (json['transaction']['status'] == "completed" ||
            data.contains('Payment succeeded')) {
          log('WOo YOo');
          postAdData();
        } else {}
      },
      // onDone: () {
      //   // Handle socket closure
      //   log('WebSocket closed');
      // },
      onError: (error) {
        // Handle errors
        log('WebSocket error: $error');
      },
    );
  }

  // Send a message through the WebSocket
  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  // Close the WebSocket connection
  void disconnect() {
    _channel.sink.close();
  }

  Future<bool> postAdData() async {
    if (Get.find<SelectFeatuedTypeController>().selectedFeaturedType.value ==
        "Feature Ad") {
    } else if (Get.find<SelectFeatuedTypeController>()
            .selectedFeaturedType
            .value ==
        "Blazing Ad") {
    } else {}
    return true;
  }
}
