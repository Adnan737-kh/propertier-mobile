import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../constant/toast.dart';
import '../../../data/app_exception.dart';
import '../../../repository/vendor/vendor_auth/vendor_auth.dart';

class ServicesAppBarViewModel extends GetxController{
  final VendorRegisterRepository _api =VendorRegisterRepository();
  RxBool isLoading = false.obs;



  // void registerVindor() {
  //   isLoading(true);
  //
  //   // Create an instance of the SignUpModel with data from the form
  //   // SignUpModel signUpData = SignUpModel(
  //   //   fullName: nameController.value.text,
  //   //   email: emailController.value.text,
  //   //   password: passwordController.value.text,
  //   //   passwordConfirm: confirmPasswordController.value.text,
  //   // );
  //   final Map<String, dynamic> data = {
  //     "email": email.toLowerCase(),
  //     "firebase_id": firebaseID,
  //     "type": 'vendor',
  //     "profession_types": [serviceId, serviceName]
  //   };
  //
  //   _api.registerVendor(data,).then((onValue) async {
  //     if (kDebugMode) {
  //       print('onValue $onValue');
  //     }
  //     if (onValue != null && onValue.containsKey('otp_token')) {
  //       String otpToken = onValue['otp_token'];
  //       if (kDebugMode) {
  //         print('Save otpToken For Header $otpToken');
  //       }
  //
  //       // 🔹 Save to SharedPreferences
  //       // SharedPreferences prefs = await SharedPreferences.getInstance();
  //       // await prefs.setString('otp_token', otpToken);
  //       //
  //       // print('📌 otp_token stored successfully: $otpToken');
  //     }
  //     toast(title: 'OTP Sent to Your Gmail', context: Get.context!);
  //     Get.toNamed(AppRoutes.otpVerifyView);
  //     isLoading(false);
  //   }).onError((error, stackTrace) {
  //     isLoading(false);
  //     if (error is UserAlreadyExistsException) {
  //       toast(title: 'User with this email already exists', context: Get.context!);
  //     } else {
  //       toast(title: 'An error occurred: $error', context: Get.context!);
  //     }
  //     if (kDebugMode) {
  //       print('$error and $stackTrace');
  //     }
  //   });
  // }
}