import 'dart:convert';

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
    print('🔄 Fetching All Properties...');
    AllPropertiesModel allPropertiesModel = AllPropertiesModel();

    try {
      final response = await http.get(Uri.parse(API.allPropertiesUrl));

      print('📩 Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        // Log the raw API response
        print("📜 Raw API Response: ${response.body}");

        final dynamic jsonData = jsonDecode(response.body);

        if (jsonData is List) {
          // If API returns a list, wrap it into a map with 'properties' key
          allPropertiesModel = AllPropertiesModel.fromJson(jsonData);
        } else if (jsonData is Map<String, dynamic>) {
          // If API returns a map, use it directly
          // allPropertiesModel = AllPropertiesModel.fromJson(jsonData);
        } else {
          print("⚠️ Unexpected JSON format: $jsonData");
        }

        print("✅ Properties Found: ${allPropertiesModel.properties?.length ?? 0}");

      } else {
        print("❌ Error: HTTP ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("🔥 Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: appText(
          title: 'Something went wrong.',
          context: context,
          color: AppColor.white,
        ),
      ));
    }

    print('📊 Final Properties Count: ${allPropertiesModel.properties?.length ?? 0}');
    return allPropertiesModel;
  }


  // Future<List<PropertyModel>> getAllPropertiesData({
  //   required BuildContext context,
  //   required String type,
  // }) async {
  //   print('ALl Proper Out Function Called');
  //   List<PropertyModel> allPropertiesList = []; // Initialize as an empty list
  //   try {
  //     final response = await http.get(Uri.parse(API.allPropertiesUrl));
  //     if (response.statusCode == 200) {
  //       final decodedJson = jsonDecode(response.body);
  //       print("ALl Proper 200 $decodedJson");
  //
  //       // Ensure the response is a list
  //       for (var item in decodedJson) {
  //         allPropertiesList.add(PropertyModel.fromJson(item)); // Add each PropertyModel to the list
  //       }
  //     } else {
  //       print("ALl Proper error ${response.body}");
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: appText(
  //               title: 'Something went wrong.',
  //               context: context,
  //               color: AppColor.white)));
  //     }
  //   } catch (e) {
  //     print("ALl Proper Catch ${e.toString()}");
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: appText(
  //             title: 'Something went wrong.',
  //             context: context,
  //             color: AppColor.white)));
  //   }
  //   return allPropertiesList; // Return the list
  // }

  Future<AllPropertiesModel> getWitoutContextAllPropertiesData() async {
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
