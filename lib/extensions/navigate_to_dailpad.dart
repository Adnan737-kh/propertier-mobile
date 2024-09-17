import 'package:url_launcher/url_launcher.dart';

void openDialer(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await launchUrl(phoneUri)) {
    // Dialer opened successfully
  } else {
    // Dialer could not be opened
  }
}

textMe(String s) async {
  // Android
  String uri = 'sms:$s?body=hello%20there';
  if (await launchUrl(Uri.parse(uri))) {
    await launchUrl(Uri.parse(uri));
  } else {
    // iOS
    String uri = 'sms:$s?body=hello%20there';
    if (await launchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      throw 'Could not launch $uri';
    }
  }
}

navigateToUrl(String s) async {
  if (await canLaunchUrl(Uri.parse(s))) {
    await launchUrl(Uri.parse(s));
  } else {}
}
