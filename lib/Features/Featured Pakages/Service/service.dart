import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Features/Featured%20Pakages/Models/featured_pakages/featured_pakages.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:http/http.dart' as http;

class FeaturedPakageService {
  Future<dynamic> getFeatures() async {
    var profileDetailModel;
    try {
      final response = await http.get(Uri.parse(API.getFeaturesPackagesUrl));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);

        if (kDebugMode) {
          print(decodedJson);
        }
        profileDetailModel = decodedJson
            .map((jsonItem) =>
                FeaturedPakages.fromJson(jsonItem as Map<String, dynamic>))
            .toList();
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content: CustomText(
                title: response.body.toString(),
              
                color: AppColor.white)));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: CustomText(
            title: e.toString(), color: AppColor.white),
      ));
    }
    return profileDetailModel;
  }
}
