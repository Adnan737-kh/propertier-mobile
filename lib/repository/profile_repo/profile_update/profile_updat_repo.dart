import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:propertier/data/network/network_api_services.dart';
import 'package:propertier/res/app_urls/app_url.dart';
import 'package:http/http.dart' as http;

class ProfileUpdateRepository {
  final _apiServices = NetworkApiService();

  Future<dynamic> updateProfile(var data, String accessToken) async {
    if (kDebugMode) {
      print('🔹 Sending request with token: $accessToken');
      print('🔹 Sending request with data: $data');
    }

    dynamic response = await _apiServices.patchApi(
      data,
      AppUrls.profileUrl,
      authToken: accessToken, // ✅ Pass authToken
    );

    return response;
  }

  Future<dynamic> idCardVerification(File frontImage, File backImage, String accessToken) async {
    try {
      var uri = Uri.parse(AppUrls.userVerificationUrl);

      var request = http.MultipartRequest("POST", uri)
        ..headers['Authorization'] = "Bearer $accessToken"
        ..fields['verification_type'] = "id_card"
        ..files.add(await http.MultipartFile.fromPath("id_card_front", frontImage.path))
        ..files.add(await http.MultipartFile.fromPath("id_card_back", backImage.path));

      var response = await request.send();

      // Convert the streamed response into a string
      String responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Response Success: $responseString");
        }
        return responseString;
      } else {
        if (kDebugMode) {
          print("Response Status Code: ${response.statusCode}");
          print("Response Error: $responseString");
        }
        return responseString; // Return the actual response instead of null
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      return null;
    }
  }

  Future<dynamic> emailAndNumberVerification(var data,String accessToken)async {

    dynamic response = _apiServices.postApi(data,AppUrls.userVerificationUrl,authToken:accessToken );
    return response;
  }


}
