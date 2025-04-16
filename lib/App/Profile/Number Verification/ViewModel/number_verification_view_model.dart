import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../constant/toast.dart';
import '../../../../repository/profile_repo/profile_update/profile_updat_repo.dart';
import '../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class NumberVerficationViewModel extends GetxController {
  final ProfileUpdateRepository _api = ProfileUpdateRepository();
  UserPreference userPreference = UserPreference();
  RxBool isLoading = false.obs;
  String? _accessToken;
  String? get accessToken => _accessToken;
  final numberController = TextEditingController();
  final emailFormKey = GlobalKey<FormState>();

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

  @override
  void dispose() {
    numberController.dispose();

    super.dispose();
  }

  void phoneNumberVerification(BuildContext context, String accessToken) {
    isLoading(true);

    Map<String, dynamic> data = {
      "verification_type": "phone_number",
    };

    _api.emailAndNumberVerification(data, accessToken).then((onValue) async {
      isLoading(false);

      if (onValue.containsKey('statusCode') &&
          onValue.containsKey('body')) {

        int statusCode = onValue['statusCode'];
        dynamic body = onValue['body'];

        if (kDebugMode) {
          print(' Status Code: $statusCode');
          print('Response Body: $body');
        }

        if (statusCode == 200 || statusCode == 201) {
          toast(title: 'Number Verification Submitted', context: context);
          Get.toNamed(AppRoutes.verificationView);
        } else {
          if (body is Map && body.containsKey('detail')) {
            String errorMessage = body['detail'][0];
            toast(title: errorMessage, context: context);
          } else {
            toast(
              title: 'Verification failed. Please try again.',
              context: context,
            );
          }
        }
      } else {
        toast(
          title: 'Invalid response from server.',
            context: context,
        );
      }
    }).catchError((error, stackTrace) {
      isLoading(false);

      try {
        String errorString = error.toString();
        RegExp regex = RegExp(r'\{.*\}');
        Match? match = regex.firstMatch(errorString);
        String? jsonPart = match?.group(0);

        if (jsonPart != null) {
          var errorResponse = jsonDecode(jsonPart);
          if (errorResponse is Map && errorResponse.containsKey('detail')) {
            String errorMessage = errorResponse['detail'][0];
            toast(title: errorMessage, context: context);
            return;
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(" Error  $e");
        }
      }

      toast(title: "Something went wrong. Please try again.", context: context);

      if (kDebugMode) {
        print(" Error: $error");
        print(" StackTrace: $stackTrace");
      }
    });
  }
}
