import "dart:convert";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:http/http.dart" as http;

import "package:propertier/Network/api_urls.dart";
import "package:propertier/Utils/app_text.dart";
import "package:propertier/constant/colors.dart";

class SignupServices {
  Future<bool> signupUserData(
      {String? name,
      required BuildContext context,
      String? email,
      String? pinCode,
      String? address,
      String? latitude,
      String? longitude,
      String? firebaseID,
      String? profilePicUrl,
      String? phoneNumber}) async {
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
      "type": "customer"
    };

    final encodedData = jsonEncode(data);
    try {
      final response = await http.post(
        Uri.parse("${API.registerUrl}/"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: encodedData,
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 201) {
        debugPrint("data is available ${response.body}");
        jsonDecode(response.body);
        return true;
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content: CustomText(
                title: 'Something went wrong: ${response.body} ',
                color: AppColor.white)));
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: CustomText(
              title: 'Something went wrong.',
              color: AppColor.white)));
      debugPrint(e.toString());
      return false;
    }
  }
}
