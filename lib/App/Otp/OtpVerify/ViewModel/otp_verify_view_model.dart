import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Otp/OtpVerify/Model/social_media_button_model.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/constant/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../repository/auth_repo/signup_repo/signup_repo.dart';

class OTPVerifyViewModel extends GetxController {
  final _api = SignUpRepository();
  final List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  final RxInt _selectedFieldIndex = 0.obs;
  int get selectedFieldIndex => _selectedFieldIndex.value;
  RxBool isLoading = false.obs;
  final RxString _completePin = ''.obs;
  String get completePin => _completePin.value;
  late Timer _timer;
  final RxInt _counterValue = 30.obs;
  int get counterValue => _counterValue.value;
  final RxBool _isTimerStart = true.obs;
  bool get isTimerStart => _isTimerStart.value;

  RxList<SocialMediaButtonModel> socialMediaButtonsList =
      <SocialMediaButtonModel>[
    SocialMediaButtonModel(icon: Constant.facebook, onTap: () {}),
    SocialMediaButtonModel(icon: Constant.twitter, onTap: () {}),
    SocialMediaButtonModel(icon: Constant.instagram, onTap: () {}),
    SocialMediaButtonModel(icon: Constant.youtube, onTap: () {}),
  ].obs;

  getSelectedFieldIndex(int index) {
    _selectedFieldIndex.value = index;
  }

  onComplete(String value) {
    _completePin.value = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit

    startCounter();
    super.onInit();
  }

  startCounterAgain() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _isTimerStart.value = true;
      decrement();
    });
  }

  void startCounter() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      decrement();
    });
  }

  void decrement() {
    if (_counterValue.value > 0) {
      _counterValue.value--;
    } else {
      _timer.cancel();
      _isTimerStart.value = false;
      _counterValue.value = 30;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _counterValue.value = 30;
    super.dispose();
  }

  // Future<void> verifyOtp({required String code, required String otpToken}) async {
  //   print('$otpToken and $code');
  //   final url = Uri.parse('${Constant.baseUrl}api/auth/user/verify/$otpToken/');
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({
  //         "code": code, // Sending the code in the request body
  //       }),
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print("OTP verified successfully: ${response.body}");
  //     } else {
  //       print("OTP verification failed: ${response.body}");
  //     }
  //   } catch (error) {
  //     print("Error verifying OTP: $error");
  //   }
  // }

  void verifyOtp({required String code})async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    String? token = prefs.getString('token');

    if (kDebugMode) {
      print("Stored Token: $token");
      print("Stored UID: $uid");

    }

    isLoading(true);


    if(uid != null || token!= null){

      Map data = {
        "otp": code,
      };

      _api.verifyForgotPasswordOtp(data).then((onValue) async {
        // ✅ Extract and store otp_token

        String? resetApprovalToken = onValue['reset_approval_token'];

        SharedPreferences forgotPref = await SharedPreferences.getInstance();
        await forgotPref.setString('reset_approval_token', resetApprovalToken ?? '');
        isLoading(false);
        toast(title: 'OTP Verify Successfully', context: Get.context!);
        Get.offAllNamed(AppRoutes.newPasswordView);
      }).onError((error, stackTrace) {
        isLoading(false);
        if (kDebugMode) {
          print('$error and $stackTrace');
        }
      });
    }else{
      Map data = {
        "code": code,
      };
      _api.verifyOtp(data).then((onValue) async {
        isLoading(false);
        toast(title: 'OTP Verify Successfully', context: Get.context!);
        Get.offAllNamed(AppRoutes.navBarView);
      }).onError((error, stackTrace) {
        isLoading(false);
        if (kDebugMode) {
          print('$error and $stackTrace');
        }
      });
    }

  }
}
