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
    AllPropertiesModel allPropertiesModel = AllPropertiesModel();
    try {
      final response = await http.get(Uri.parse(API.allPropertiesUrl));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        allPropertiesModel = AllPropertiesModel.fromJson(decodedJson);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: 'Something went wrong.',
                context: context,
                color: AppColor.white)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: 'Something went wrong.',
              context: context,
              color: AppColor.white)));
    }
    return allPropertiesModel;
  }

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
