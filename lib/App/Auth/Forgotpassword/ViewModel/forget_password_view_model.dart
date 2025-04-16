import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:propertier/App/Auth/Forgotpassword/View/component/forget_password_success_dialog.dart';
import 'package:propertier/constant/toast.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../repository/auth_repo/login_repo/login_repo.dart';
import '../../response.dart';

class ForgotPasswordViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();
  final LoginRepository _api = LoginRepository();
  TextEditingController emailController = TextEditingController();
  RxBool isKeyboard = false.obs;

  @override
  void onInit() {
    super.onInit();
    // _speech = stt.SpeechToText();
    // _initSpeechRecognizer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  void forgetPasswordViaEmail({
    required String email,
    required BuildContext context,
  }) {
    if (!isValidEmail(email)) {
      toast(title: 'Please Enter valid Email', context: context);
      return;
    }

    isLoading(true);

    Map data = {'email': email};

    _api.forgotPassword(data).then((onValue) async {
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

        Get.toNamed(AppRoutes.otpVerifyView);
        toast(
          title: "Verification Email Sent to Your Gmail!",
          context: context,
        );
      } else {
        if (body is Map && body.containsKey('detail')) {
          toast(title: body['detail'].toString(), context: context);
        } else {
          toast(title: 'Failed to send verification email.', context: context);
        }
      }
    }).onError((error, stackTrace) {
      isLoading(false);

      if (kDebugMode) {
        print('Forgot Password Error: $error\n$stackTrace');
      }

      toast(title: 'An error occurred. Please try again.', context: context);
    });
  }


  void startListening({required int textFieldNo}) async {
    // try {
    //   await _speech.listen(
    //     onResult: (result) {
    //       print("Start Listing");
    //       print(result.recognizedWords);
    //       if (_lastWords != result.recognizedWords) {
    //         _lastWords.value = result.recognizedWords;
    //         _resetIdleTimer(_lastWords.value, textFieldNo);

    //         print('Recognized Text: ${_lastWords.value}');
    //       }
    //     },
    //   );
    // } catch (e) {
    //   print('Error starting listening: $e');
    // }
  }

  // Timer? _idleTimer;

  // void _resetIdleTimer(String msg, int fieldNo) {
  //   _idleTimer?.cancel();
  //   _idleTimer = Timer(const Duration(seconds: 1), () {
  //     print(_lastWords);
  //     if (_lastWords != '') {
  //       emailController.text = msg;
  //     }
  //     //  stopListening();
  //     // initSpeech();
  //     // startListening();
  //   });
  // }

  RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future postForgetPassword(
      {required String email, required BuildContext context}) async {
    if (!isValidEmail(email)) {
      toast(title: 'Please Enter valid Email', context: context);
      return;
    }

    try {
      // Send password reset email and handle success with then
      await _auth.sendPasswordResetEmail(email: email).catchError((e) {
        var status = AuthExceptionHandler.handleAuthException(
            e); // Handle error and update status
        isLoading.value = false; // Assuming you manage loading state somewhere
        toast(
            title: 'Error sending password reset email: $status',
            context: context);
      });
      isLoading.value = false; // Assuming you manage loading state somewhere
      forgetPasswordSuccessDialog(context: context);
    } catch (e) {
      // Handle other exceptions that may occur
      AuthExceptionHandler.generateErrorMessage(e);
      isLoading.value = false; // Assuming you manage loading state somewhere
      toast(title: 'Error sending password reset email', context: context);
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }
}
