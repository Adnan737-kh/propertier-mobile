import "dart:convert";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:http/http.dart" as http;
import "package:propertier/Network/api_urls.dart";
import "package:propertier/Utils/app_text.dart";
import "package:propertier/Vendor/screens/Auth/Login/Model/user_login_model/user_login_model.dart";
import "package:propertier/constant/colors.dart";

class SignupServices {
  Future<UserLoginModel?> signupUserData({
    String? name,
    required BuildContext context,
    String? email,
    String? pinCode,
    String? address,
    String? latitude,
    String? longitude,
    String? firebaseID,
    String? profilePicUrl,
    String? phoneNumber,
    String? type, // Ensure 'type' matches one of the allowed values
  }) async {
    // Check if the user already exists
    final exists = await _checkUserExists(email, firebaseID);
    if (exists) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: appText(
          title: 'User with this email and Firebase ID already exists.',
          context: Get.context!,
          color: AppColor.white,
        ),
      ));
      return null;
    }

    // If user doesn't exist, proceed with registration
    UserLoginModel signupResponseModel = const UserLoginModel();
    final Map<String, dynamic> data = {
      "name": name,
      "email": email!.toLowerCase(),
      "phone_number": phoneNumber,
      "firebase_id": firebaseID,
      "latitude_position": latitude != null ? latitude.substring(0, 9) : "",
      "longitude_position": longitude != null ? longitude.substring(0, 9) : "",
      "phone_number_country_code": pinCode,
      "address": address,
      "profile_picture_url": profilePicUrl ?? '',
      "type": type ?? 'vendor', // Example default value
    };

    final encodedData = jsonEncode(data);

    try {
      final response = await http.post(
        Uri.parse("${API.venregisterUrl}/"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: encodedData,
      );

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonDecodedData = jsonDecode(response.body);
        signupResponseModel = UserLoginModel.fromJson(jsonDecodedData);
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: appText(
            title: 'Something went wrong: ${response.body}',
            context: Get.context!,
            color: AppColor.white,
          ),
        ));
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: appText(
          title: 'Something went wrong.',
          context: Get.context!,
          color: AppColor.white,
        ),
      ));
      debugPrint("Error: $e");
      return null;
    }

    return signupResponseModel;
  }

  Future<bool> _checkUserExists(String? email, String? firebaseID) async {
    try {
      final response = await http.get(
        Uri.parse("${API.venregisterUrl}/"),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List users = jsonDecode(response.body);
        for (var user in users) {
          if (user['email'] == email && user['firebase_id'] == firebaseID) {
            return true;
          }
        }
      }
    } catch (e) {
      debugPrint("Error while checking user existence: $e");
    }
    return false;
  }
}
