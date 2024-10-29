import "dart:convert";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:http/http.dart" as http;
import "package:propertier/App/Auth/Login/Model/user_login_model/user_login_model.dart";
import "package:propertier/Network/api_urls.dart";
import "package:propertier/Utils/app_text.dart";
import "package:propertier/Vendor/screens/Auth/Login/Model/user_login_model/user_login_model.dart";
import "package:propertier/constant/colors.dart";

class Editvendorprofileservice {


  Future<User?> updateUserData({
    required String id,
    String? name,
    required BuildContext context,
    required String email,
    String? pinCode,
    String? address,
    String? latitude,
    String? longitude,
    required String firebaseID,
    String? profilePicUrl,
    String? phoneNumber,
    String? cnicFront,
    String? cnicBack,
    String? profileImage,
  }) async {
    try {
    print("${API.venregisterUrl}/$id");
      // Create a multipart request
      var request = http.MultipartRequest('PUT', Uri.parse("${API.venregisterUrl}/$id/"));

      request.fields['email'] = email.toLowerCase();
      request.fields['firebase_id'] = firebaseID;
      request.fields['type'] = 'vendor';

      // Add text fields to the request
      if(name != null){
        request.fields['name'] = name;
      }
      if(pinCode != null){
        request.fields['phone_number_country_code'] = pinCode??"";
      }
      if(phoneNumber != null){
        request.fields['phone_number'] = phoneNumber ?? '';
      }
      if(latitude != null){
        request.fields['latitude_position'] = latitude;
      }
      if(longitude != null){
        request.fields['longitude_position'] = longitude;
      }
      if(address != null){
        request.fields['address'] = address ?? '';
      }
      if(profilePicUrl != null){
        request.fields['profile_picture_url'] = profilePicUrl ?? '';
      }

      print(request.fields);

      // Attach the image files to the request
      if(cnicFront != null){
        request.files.add(await http.MultipartFile.fromPath('cnic_front', cnicFront));
      }
      if(cnicBack != null){
        request.files.add(await http.MultipartFile.fromPath('cnic_back', cnicBack));
      }
      if(profileImage != null){
        request.files.add(await http.MultipartFile.fromPath('profile_picture', profileImage));
      }

      print("sending request");
      // Send the request
      var response = await request.send();

      // Convert the response to a string to check for success
      var responseString = await response.stream.bytesToString();
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: $responseString");

      if (response.statusCode == 201 || response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(responseString));
        return user;
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: appText(
            title: 'Something went wrong: $responseString',
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
  }
}
