import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';

class ForgetPasswordServices {
  Future<bool> forgetPassword({required String email}) async {
    bool isSuccess = false;
    try {
      final response = await http
          .post(Uri.parse(API.forgetPasswordUrl), body: {'email': email});
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("ResIS THIS ${response.body}");
        }
        isSuccess = true;
      } else {
        isSuccess = false;
      }
    } catch (e) {}
    return isSuccess;
  }
}
