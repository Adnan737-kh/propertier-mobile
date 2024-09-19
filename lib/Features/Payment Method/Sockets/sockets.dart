import 'dart:developer';

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
        log('Received: $message');
      },
      onDone: () {
        // Handle socket closure
        log('WebSocket closed');
      },
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
}
