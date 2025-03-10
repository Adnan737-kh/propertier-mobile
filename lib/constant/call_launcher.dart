import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

launchCallandSMS(
    {String type = "tel", String phoneNumber = '+923146800808'}) async {
  Uri url = Uri(scheme: type, path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    if (kDebugMode) {
      print("Can't open dial pad.");
    }
  }
}
