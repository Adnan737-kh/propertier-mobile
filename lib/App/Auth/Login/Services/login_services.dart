import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/App/Auth/Login/View/component/does_not_exist_dialog.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';

import '../Model/user_login_model/user_login_model.dart';

class LoginServices {
  Future<UserLoginModel?> loginUser({
    String? email,
    BuildContext? context,
    bool isLogin = false,
    required String password,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(API.userInfoUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer $password"
        },
      );
      if (kDebugMode) {
        print(API.userInfoUrl);
        print("get info response ${response.body}");
        print("get info response code ${response.statusCode}");
        print("token $password");
      }


      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        log(password);
        if (decodedData['success'] == false) {
          doesNotExist(context: Get.context!, subtitle: decodedData['message']);

          return null;
        } else {
          return UserLoginModel.fromJson(decodedData);
        }
      } else if (response.statusCode == 404) {
        if (isLogin) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: CustomText(
                  title: 'User not exist',
                  color: AppColor.white)));
        } else {
          Get.toNamed(AppRoutes.collectInfoProfile);
        }

        return null;
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            content: CustomText(
                title: 'Something went wrong.',
                color: AppColor.white)));
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: CustomText(
              title: 'Something went wrong. ${e.toString()}',
              color: AppColor.white)));
      return null;
    }
  }
}
