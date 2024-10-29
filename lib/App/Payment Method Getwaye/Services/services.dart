import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:propertier/Features/Featured%20Pakages/Models/featured_pakages/featured_pakages.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:http/http.dart' as http;

class FeaturedService {
  Future<dynamic> getFeatures() async {
    var profileDetailModel;
    try {
      final response = await http.get(Uri.parse(API.getFeaturesPakagesUrl));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        profileDetailModel = decodedJson
            .map((jsonItem) =>
                FeaturedPakages.fromJson(jsonItem as Map<String, dynamic>))
            .toList();
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content: appText(
                title: response.body.toString(),
                context: Get.context!,
                color: AppColor.white)));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: appText(
            title: e.toString(), context: Get.context!, color: AppColor.white),
      ));
    }
    return profileDetailModel;
  }

  Future<bool> buyFeaturedAd( String featureId, String propertyId, String status, String? image) async {
    bool flag = false;
    final Map<String, dynamic> data = {
      "feature_package_id": featureId,
      "property_id": propertyId,
      "status": status,
      "cover_image": image
    };

    final encodedData = jsonEncode(data);
    try {
      String url = "${CreateFeatureAd.createFeaturedProperty}";
      print(url);
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: encodedData,
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 201){
        flag = true;
      }
    } catch (e) {
      print(e);
    }
    return flag;
  }

  Future<bool> buyFeaturedProfileAd(
      String agentId,
      String featureId,
      String status,
      String imagePath, // Local file path of the image
      ) async {
    bool flag = false;

    try {
      String url = "${CreateFeatureAd.createFeaturedProfile}";
      print(url);

      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add form fields
      request.fields['agent_id'] = agentId;
      request.fields['feature_package_id'] = featureId;
      request.fields['status'] = status;

      // Add image file to the request
      var imageFile = await http.MultipartFile.fromPath(
        'cover_image',
        imagePath,
        filename: basename(imagePath),
      );
      request.files.add(imageFile);

      // Send the request
      var response = await request.send();

      // Get the response data
      if (response.statusCode == 201) {
        flag = true;
      } else {
        print('Failed with status code: ${response.statusCode}');
      }

      // Print response body
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
    } catch (e) {
      print('Error: $e');
    }

    return flag;
  }
}
