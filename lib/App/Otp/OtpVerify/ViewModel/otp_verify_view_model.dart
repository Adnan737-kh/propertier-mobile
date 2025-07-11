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
  final SignUpRepository _api = SignUpRepository();

  TextEditingController otpController = TextEditingController();

  final RxInt _selectedFieldIndex = 0.obs;
  int get selectedFieldIndex => _selectedFieldIndex.value;

  RxBool isLoading = false.obs;
  final RxString _completePin = ''.obs;
  String get completePin => _completePin.value;

  Timer? _timer;
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

  void getSelectedFieldIndex(int index) {
    _selectedFieldIndex.value = index;
  }

  void onComplete(String value) {
    _completePin.value = value;
  }

  @override
  void onInit() {
    startCounter();
    super.onInit();
  }

  void startCounterAgain() {
    _counterValue.value = 30;
    startCounter();
  }

  void startCounter() {
    _isTimerStart.value = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => decrement());
  }

  void decrement() {
    if (_counterValue.value > 0) {
      _counterValue.value--;
    } else {
      _timer?.cancel();
      _isTimerStart.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();

    super.onClose();
  }

  Future<void> verifyOtp({required String code}) async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid');
    final token = prefs.getString('token');

    isLoading(true);
    try {
      if (uid != null || token != null) {
        await _api.verifyForgotPasswordOtp({"otp": code}).then(
          (onValue) async {
            int statusCode = onValue['statusCode'];
            dynamic body = onValue['body'];
            if (kDebugMode) {
              print('verifyOtp Response: $body');
              print('verifyOtp Status Code: $statusCode');
            }

            String? resetToken = body['reset_approval_token'];

            await prefs.setString('reset_approval_token', resetToken!);
            if (kDebugMode) {
              print('reset_approval_token $resetToken');
            }

            CustomToast.show(title: 'OTP Verified Successfully', context: Get.context!);
            Get.offAllNamed(AppRoutes.newPasswordView);
            isLoading(false);
          },
        );
      } else {
        if (kDebugMode) {
          print("status code }");
        }
        await _api.verifyOtp({"code": code});
        CustomToast.show(title: 'OTP Verified Successfully', context: Get.context!);
        Get.offAllNamed(AppRoutes.navBarView);
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Error verifying OTP: $error\n$stackTrace');
      }
      CustomToast.show(title: '$error', context: Get.context!);
    } finally {
      isLoading(false);
    }
  }
}
