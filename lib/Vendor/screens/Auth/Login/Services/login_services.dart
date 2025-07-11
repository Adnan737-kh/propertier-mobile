import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Vendor/screens/Auth/Login/Model/user_login_model/user_login_model.dart';
import 'package:propertier/Vendor/screens/Auth/Login/View/component/does_not_exist_dialog.dart';
import 'package:propertier/constant/colors.dart';



class LoginServices {
  Future<UserLoginModel?> loginUser({
    required String email,
    BuildContext? context,
    required String password,
  }) async {
    try {
      UserLoginModel loginResponseModel;
      final response = await http.get(
        Uri.parse(API.userInfoUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer $password"
        },
      );

      if (kDebugMode) {
        print("StatusCode: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (kDebugMode) {
          print("Decoded Data: $decodedData");
        }

        if (decodedData['success'] == false) {
          doesNotExist(context: Get.context!, subtitle: decodedData['message']);
          loginResponseModel = const UserLoginModel();
        } else {
          loginResponseModel = UserLoginModel.fromJson(decodedData);
        }

        debugPrint(loginResponseModel.message ?? "No message in response");
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: CustomText(
            title: 'Something went wrong. Status code: ${response.statusCode}',
            color: AppColor.white,
          ),
        ));
        loginResponseModel = const UserLoginModel();
      }
      return loginResponseModel;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: CustomText(
          title: 'Something went wrong. Error: ${e.toString()}',
          color: AppColor.white,
        ),
       
      ));
      return const UserLoginModel();
    }
  }
}
