import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../constant/toast.dart';
import '../../../../repository/profile_repo/profile_update/profile_updat_repo.dart';
import '../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class EmailVerficationViewModel extends GetxController {
  final ProfileUpdateRepository _api = ProfileUpdateRepository();
  UserPreference userPreference = UserPreference();
  RxBool isLoading = false.obs;
  String? _accessToken;
  String? get accessToken => _accessToken;
  final emailController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  void onInit() async {
    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('number verification ACCESS   !!! ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        _accessToken = value.accessToken;
      }
    });
    super.onInit();
  }

  void emailVerification(BuildContext context, String accessToken) {
    isLoading(true);

    Map<String, dynamic> data = {
      "verification_type": "email",
    };

    _api.emailAndNumberVerification(data, accessToken).then((onValue) async {
      isLoading(false);

      int statusCode = onValue['statusCode'];
      dynamic body = onValue['body'];

      if (kDebugMode) {
        print("📦 Status Code: $statusCode");
        print("📦 Response Body: $body");
      }

      if (statusCode == 200 || statusCode == 201) {
        toast(title: 'Email Verification Submitted', context: context);
        Get.toNamed(AppRoutes.verificationView);
      } else {
        // Catch expected API error message
        if (body is Map && body.containsKey('detail')) {
          String errorMessage = body['detail'][0];
          toast(title: errorMessage, context: context);
        } else {
          toast(title: '❌ Verification failed. Please try again.', context: context);
        }
      }
    }).catchError((error, stackTrace) {
      isLoading(false);

      if (kDebugMode) {
        print("❗ Error caught: $error");
      }

      try {
        RegExp regex = RegExp(r'\{.*\}');
        Match? match = regex.firstMatch(error.toString());
        String? jsonPart = match?.group(0);

        if (jsonPart != null) {
          Map<String, dynamic> errorMap = jsonDecode(jsonPart);
          if (errorMap.containsKey('detail')) {
            String message = errorMap['detail'][0];
            toast(title: message, context: context);
            return;
          }
        }

        // If no JSON or 'detail' key
        toast(title: "Something went wrong. Please try again.", context: context);
      } catch (e) {
        // If parsing fails
        toast(title: "Unexpected error occurred.", context: context);
        if (kDebugMode) {
          print("Error parsing the message: $e");
        }
      }
    });

  }
}
