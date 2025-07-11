import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:propertier/constant/toast.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../repository/auth_repo/login_repo/login_repo.dart';

class ForgotPasswordViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();
  final LoginRepository _api = LoginRepository();
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> forgetPasswordViaEmail({
    required String email,
    required BuildContext context,
  }) async {
    if (!isValidEmail(email)) {
      CustomToast.show(title: 'Please Enter valid Email', context: context);
      return;
    }

    isLoading(true);

    Map data = {'email': email};

    await _api.forgotPassword(data).then((onValue) async {
      isLoading(false);

      int statusCode = onValue['statusCode'];
      dynamic body = onValue['body'];

      if (kDebugMode) {
        print('Forgot Password Response: $body');
        print('Status Code: $statusCode');
      }

      if (statusCode == 200 || statusCode == 201) {
        // Extract `uid` and `token`
        String? uid = body['uid'];
        String? token = body['token'];

        SharedPreferences forgotPref = await SharedPreferences.getInstance();
        await forgotPref.setString('uid', uid ?? '');
        await forgotPref.setString('token', token ?? '');

        if (kDebugMode) {
          print('Saved UID and Token: $uid and $token');
        }
        CustomToast.show(
          title: "Verification Email Sent to Your Gmail!",
          context: context,
        );
        Get.toNamed(AppRoutes.otpVerifyView);
      } else {
        if (body is Map && body.containsKey('detail')) {
          CustomToast.show(title: body['detail'].toString(), context: context);
        } else {
          CustomToast.show(title: 'Failed to send verification email.', context: context);
        }
      }
    }).onError((error, stackTrace) {
      isLoading(false);

      if (kDebugMode) {
        print('Forgot Password Error: $error\n$stackTrace');
      }

      CustomToast.show(title: 'An error occurred. Please try again.', context: context);
    });
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }
}
