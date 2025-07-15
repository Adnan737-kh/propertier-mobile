import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Model/all_properties_model.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';

class AllPropertiesServices {
  Future<AllPropertiesModel> getAllPropertiesData({
    required BuildContext context,
    required String type,
  }) async {
    if (kDebugMode) {
      print('🔄 Fetching All Properties...');
    }
    AllPropertiesModel allPropertiesModel = AllPropertiesModel(properties: []);

    try {
      final response = await http.get(Uri.parse(API.allPropertiesUrl));

      if (kDebugMode) {
        print('📩 Response Status: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("📜 Raw API Response: ${response.body}");
        }

        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        // ✅ Now correctly parse it
        allPropertiesModel = AllPropertiesModel.fromJson(jsonData);

        if (kDebugMode) {
          print(
              "✅ Properties Found: ${allPropertiesModel.properties?.length ?? 0}");
        }
      } else {
        if (kDebugMode) {
          print(
              "❌ Error: HTTP ${response.statusCode} - ${response.reasonPhrase}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("🔥 Exception: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomText(
            title: 'Something went wrong.',
            color: AppColor.white,
          ),
        ),
      );
    }

    if (kDebugMode) {
      print(
          '📊 Final Properties Count: ${allPropertiesModel.properties?.length ?? 0}');
    }
    return allPropertiesModel;
  }

  Future<AllPropertiesModel> getWitOutContextAllPropertiesData() async {
    AllPropertiesModel allPropertiesModel = AllPropertiesModel();
    try {
      final response = await http.get(Uri.parse(API.allPropertiesUrl));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);

        allPropertiesModel = AllPropertiesModel.fromJson(decodedJson);
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: appText(title: 'Something went wrong.', context: context,color: AppColor.white)));
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: appText(title: 'Something went wrong.', context: context,color: AppColor.white)));
    }
    return allPropertiesModel;
  }
}
