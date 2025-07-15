import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import 'package:propertier/App/Profile/Model/profile_model.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/res/app_urls/app_url.dart';

class ProfileService {
  UserPreference userPreference = UserPreference();
  Future<ProfileModel> getProfileDetail({
    required BuildContext context,
    required String agentID,
  }) async {
    ProfileModel profileDetailModel = ProfileModel();
    try {
      // final response = await http.get(Uri.parse("${API.profileDetailUrl}$id/"));
      final response = await http.get(
        Uri.parse(API.profileDetailUrl),
        // Uri.parse(AppUrls.profileDetailUrl),
        headers: {
          // "Authorization": "Bearer $id",
          "Content-Type": "application/json", // Optional, but good practice
        },
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("userprofile*${response.body}");
        }
        final decodedJson = jsonDecode(response.body);
        profileDetailModel = ProfileModel.fromJson(decodedJson);
        await userPreference
            .saveUserProfileData(UserProfile.fromJson(decodedJson))
            .then((onValue) {
          if (kDebugMode) {
            print("save profile data Globally ${decodedJson['full_name']}");
          }
        }).onError((error, stackTrace) {});
      } else {
        if (kDebugMode) {
          print("userprofile*${response.statusCode}");
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CustomText(
                title: response.body.toString(), color: AppColor.white)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomText(title: e.toString(), color: AppColor.white),
      ));
    }
    return profileDetailModel;
  }

  Future<bool> deleteProperty({
    required BuildContext context,
    required String id,
    required String accessToken,
  }) async {
    print('delete token $accessToken');
    var isSuccess = false;
    try {
      final response = await http.delete(
        Uri.parse("${AppUrls.propertiesUploadUrl}$id/"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print('status code1 ${response.statusCode}');
        print('status code ${response.body}');
      }
      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                CustomText(title: context.local.property_deleted, color: AppColor.white)));
        isSuccess = true;
        Get.back();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CustomText(
                title: response.body.toString(), color: AppColor.white)));
        Get.back();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomText(title: e.toString(), color: AppColor.white),
      ));
    }
    return isSuccess;
  }
}
