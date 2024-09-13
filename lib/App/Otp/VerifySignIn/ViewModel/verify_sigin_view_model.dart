import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Auth/Sign%20Up/ViewModel/signup_view_model.dart';
import 'package:propertier/constant/toast.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
// import 'package:propertier/RoutesAndBindings/app_routes.dart';

class VeifySigninViewModel extends GetxController {
  RxList<String> numberList =
      <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', ''].obs;

  RxList<String> pin = <String>[].obs;
//  List<String> get pin => _pin.value;
  final RxInt _selectedFieldIndex = 0.obs;
  int get selectedFieldIndex => _selectedFieldIndex.value;
  getSelectedFieldIndex(int index) {
    _selectedFieldIndex.value = index;
  }

  @override
  void onInit() {
    pin.value = List<String>.filled(6, '-');
    super.onInit();
  }

  final RxString _completePin = ''.obs;
  String get completePin => _completePin.value;
  onComplete(BuildContext context, String value, String email) {
    _completePin.value = value;
    print(value);
    if (!value.contains('-')) {
      verifyEmailOTP(otp: _completePin.value, context: context);
    }
  }

  // verifyOtp(BuildContext context, String email, String otpData) async {
  //   PhoneAuthCredential credential =
  //       PhoneAuthProvider.credential(verificationId: email, smsCode: otpData);
  //   print("Em is Ths $email");
  //   if (credential != null) {
  //     Get.offAllNamed(AppRoutes.navBarView);
  //   } else {
  //     toast(title: 'Please Enter Valid Otp', context: context);
  //   }
  // }

  void updatePin(BuildContext context, String value, String email, int index) {
    pin[index] = value;
    if (pin.every((element) => element.isNotEmpty)) {
      onComplete(context, pin.join(), email);
      if (_selectedFieldIndex.value < 5) {
        _selectedFieldIndex.value = _selectedFieldIndex.value + 1;
      }
    }
  }

  var isLoading = false.obs;
  Future verifyEmailOTP(
      {required String otp, required BuildContext context}) async {
    final signupVM = Get.put(SignUpViewModel());
    final result = await signupVM.myAuth.verifyOTP(otp: otp);
    print("Email OTP $result");

    if (result == true) {
      isLoading(true);
      final isSuccess = await signupVM.createUser(
          pinCode: "+92",
          address: signupVM.locationController.text,
          context: Get.context!,
          name: signupVM.usernameController.text,
          email: signupVM.userEmailController.text,
          phoneNumber: signupVM.userNumberController.text,
          password: signupVM.passwordController.text,
          confirmPassword: signupVM.confirmPasswordController.text);

      if (isSuccess == true) {
        Get.offAndToNamed(AppRoutes.navBarView);
        isLoading(false);
      } else if (isSuccess == false) {
        // signupVM.changeLoading(true);
        isLoading(false);

        Get.back();
      }
    } else {
      toast(title: 'Please Enter Valid Pin', context: Get.context!);
    }
  }

  void clearPin(int index) {
    // pin.value = List<String>.filled(length, '-');
    pin[_selectedFieldIndex.value] = '-';
    if (_selectedFieldIndex.value >= 0 &&
        pin[_selectedFieldIndex.value] == '-') {
      if (_selectedFieldIndex.value != 0) {
        _selectedFieldIndex.value = _selectedFieldIndex.value - 1;
      }
    }
    // _selectedFieldIndex.value = 0;
  }
}
