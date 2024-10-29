import "dart:convert";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:http/http.dart" as http;
import "package:propertier/Network/api_urls.dart";
import "package:propertier/Utils/app_text.dart";
import "package:propertier/Vendor/screens/Auth/Login/Model/user_login_model/user_login_model.dart";
import "package:propertier/constant/colors.dart";

class SignupServices {
  // Future<bool> signupUserData({
  //   String? name,
  //   required BuildContext context,
  //   required String email,
  //   required String pinCode,
  //   String? address,
  //   String? latitude,
  //   String? longitude,
  //   required String firebaseID,
  //   String? profilePicUrl,
  //   String? phoneNumber,
  //   required String cnicFront,
  //   required String cnicBack,
  // }) async {
  //
  //   final Map<String, dynamic> data = {
  //     "name": name,
  //     "email": email.toLowerCase(),
  //     "phone_number_country_code": pinCode,
  //     "phone_number": phoneNumber,
  //     "firebase_id": firebaseID,
  //     "latitude_position": latitude != null ? latitude.substring(0, 9) : "",
  //     "longitude_position": longitude != null ? longitude.substring(0, 9) : "",
  //     "address": address,
  //     "profile_picture_url": profilePicUrl ?? '',
  //     "type": 'vendor', // Example default value
  //   };
  //
  //   final encodedData = jsonEncode(data);
  //   print("her is encoded data $encodedData");
  //   try {
  //     final response = await http.post(
  //       Uri.parse("${API.venregisterUrl}/"),
  //       headers: <String, String>{'Content-Type': 'application/json'},
  //       body: encodedData,
  //     );
  //
  //     debugPrint("Response Status Code: ${response.statusCode}");
  //     debugPrint("Response Body: ${response.body}");
  //
  //     if (response.statusCode == 201 || response.statusCode == 200) {
  //       final jsonDecodedData = jsonDecode(response.body);
  //
  //       return true;
  //     } else {
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
  //         content: appText(
  //           title: 'Something went wrong: ${response.body}',
  //           context: Get.context!,
  //           color: AppColor.white,
  //         ),
  //       ));
  //       return false;
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
  //       content: appText(
  //         title: 'Something went wrong.',
  //         context: Get.context!,
  //         color: AppColor.white,
  //       ),
  //     ));
  //     debugPrint("Error: $e");
  //     return false;
  //   }
  // }


  Future<bool> signupUserData({
    String? name,
    required BuildContext context,
    required String email,
    required String pinCode,
    String? address,
    String? latitude,
    String? longitude,
    required String firebaseID,
    String? profilePicUrl,
    String? phoneNumber,
    required String cnicFront,
    required String cnicBack,
  }) async {
    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse("${API.venregisterUrl}/"));

      // Add text fields to the request
      request.fields['name'] = name ?? '';
      request.fields['email'] = email.toLowerCase();
      request.fields['phone_number_country_code'] = pinCode;
      request.fields['phone_number'] = phoneNumber ?? '';
      request.fields['firebase_id'] = firebaseID;
      request.fields['latitude_position'] = latitude != null ? latitude.substring(0, 9) : '';
      request.fields['longitude_position'] = longitude != null ? longitude.substring(0, 9) : '';
      request.fields['address'] = address ?? '';
      request.fields['profile_picture_url'] = profilePicUrl ?? '';
      request.fields['type'] = 'vendor';

      // Attach the image files to the request
      request.files.add(await http.MultipartFile.fromPath('cnic_front', cnicFront));
      request.files.add(await http.MultipartFile.fromPath('cnic_back', cnicBack));

      // Send the request
      var response = await request.send();

      // Convert the response to a string to check for success
      var responseString = await response.stream.bytesToString();
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: $responseString");

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: appText(
            title: 'Something went wrong: $responseString',
            context: Get.context!,
            color: AppColor.white,
          ),
        ));
        return false;
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
      return false;
    }
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
