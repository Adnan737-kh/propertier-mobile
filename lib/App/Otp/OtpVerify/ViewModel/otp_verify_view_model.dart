import 'dart:async';

import 'package:get/get.dart';
import 'package:propertier/App/Otp/OtpVerify/Model/social_media_button_model.dart';
import 'package:propertier/constant/constant.dart';

class OTPVerifyViewModel extends GetxController {
  RxList<SocialMediaButtonModel> socialMediaButtonsList =
      <SocialMediaButtonModel>[
    SocialMediaButtonModel(icon: Constant.facebook, onTap: () {}),
    SocialMediaButtonModel(icon: Constant.twitter, onTap: () {}),
    SocialMediaButtonModel(icon: Constant.instagram, onTap: () {}),
    SocialMediaButtonModel(icon: Constant.youtube, onTap: () {}),
  ].obs;
  final RxInt _selectedFieldIndex = 0.obs;
  int get selectedFieldIndex => _selectedFieldIndex.value;
  getSelectedFieldIndex(int index) {
    _selectedFieldIndex.value = index;
  }

  final RxString _completePin = ''.obs;
  String get completePin => _completePin.value;
  onComplete(String value) {
    _completePin.value = value;
    print(value);
  }

  late Timer _timer;

  final RxInt _counterValue = 30.obs;
  int get counterValue => _counterValue.value;
  final RxBool _isTimerStart = true.obs;
  bool get isTimerStart => _isTimerStart.value;
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
    // TODO: implement dispose
    super.dispose();
  }
}
