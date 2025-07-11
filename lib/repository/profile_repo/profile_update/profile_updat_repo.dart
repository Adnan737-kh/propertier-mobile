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

    final response = await _apiServices.patchApi(
      data,
      AppUrls.profileUrl,
      authToken: accessToken,
    );

    final statusCode = response['statusCode'];
    final responseBody = response['body'];

    if (kDebugMode) {
      print('🔹 Update Profile Status Code: $statusCode');
      print('🔹 Update Profile Response Body: $responseBody');
    }

    return response;
  }

  Future<Map<String, dynamic>?> idCardVerification(
    File frontImage,
    File backImage,
    String accessToken,
  ) async {
    try {
      var uri = Uri.parse(AppUrls.userVerificationUrl);

      var request = http.MultipartRequest("POST", uri)
        ..headers['Authorization'] = "Bearer $accessToken"
        ..fields['verification_type'] = "id_card"
        ..files.add(
            await http.MultipartFile.fromPath("id_card_front", frontImage.path))
        ..files.add(
            await http.MultipartFile.fromPath("id_card_back", backImage.path));

      var response = await request.send();

      // Convert the streamed response into a string
      String responseString = await response.stream.bytesToString();

      return {
        "statusCode": response.statusCode,
        "body": responseString,
      };
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> faceVerification(
      File selfie, String accessToken) async {
    try {
      var uri = Uri.parse(AppUrls.userVerificationUrl);

      var request = http.MultipartRequest("POST", uri)
        ..headers['Authorization'] = "Bearer $accessToken"
        ..fields['verification_type'] = "selfie"
        ..files.add(await http.MultipartFile.fromPath("selfie", selfie.path));

      var response = await request.send();
      String responseString = await response.stream.bytesToString();

      return {
        "statusCode": response.statusCode,
        "body": responseString,
      };
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      return null;
    }
  }

  Future<Map<String, dynamic>> emailAndNumberVerification(
      var data, String accessToken) async {
    return await _apiServices.postApi(data, AppUrls.userVerificationUrl,
        authToken: accessToken);
  }
}
