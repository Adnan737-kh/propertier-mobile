import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Profile/Model/profile_model.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:http/http.dart' as http;

import '../../../../RoutesAndBindings/app_routes.dart';

class AccountDeleteServices {
  Future<ProfileModel> doAccountDelete({
    required BuildContext context,
    required String accessToken,
  }) async {
    ProfileModel profileDetailModel = ProfileModel();
    try {
      final response = await http
          .delete(Uri.parse(API.accountDeleteUrl), headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer accessToken"
      });
      if (response.statusCode == 200) {
        jsonDecode(response.body);
        Get.offAllNamed(AppRoutes.navBarView);
        // profileDetailModel = ProfileModel.fromJson(decodedJson);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CustomText(
                title: response.body.toString(),
                color: AppColor.white)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomText(
            title: e.toString(),color: AppColor.white),
      ));
    }
    return profileDetailModel;
  }
}
