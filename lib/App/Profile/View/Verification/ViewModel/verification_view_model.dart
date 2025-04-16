import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class VerficationViewModel extends GetxController {
  final usernameController = TextEditingController();
  final userNumberController = TextEditingController();
  final userFullNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _emailVerificationStatus = ''.obs;
  final _numberVerificationStatus = ''.obs;
  final _idCardVerificationStatus = ''.obs;
  final _selfieVerificationStatus = ''.obs;
  RxString get emailVerificationStatus => _emailVerificationStatus;
  RxString get numberVerificationStatus => _numberVerificationStatus;
  RxString get idCardVerificationStatus => _idCardVerificationStatus;
  RxString get selfieVerificationStatus => _selfieVerificationStatus;
  UserPreference userPreference = UserPreference();

  var isShowPassword = false.obs;
  var isShowConfirmPassword = false.obs;
  var isName = false.obs;
  var isEmail = false.obs;
  var isPhone = false.obs;
  var isAddress = false.obs;

  RxBool isKeyboard = false.obs;

  @override
  void onInit() async {
    fetchVerificationStatus();
    super.onInit();
  }

  void fetchVerificationStatus() async {
    final accessToken = await userPreference.getUserAccessToken();
    if (kDebugMode) {
      print('Verification Access Token: ${accessToken.accessToken} ');
    }

    final userData = await userPreference.getUserProfileData();
    print('email status ${userData?.phoneNumberVerificationStatus}');

    if (userData != null) {
      _emailVerificationStatus.value = userData.emailVerificationStatus ?? "";
      _numberVerificationStatus.value =
          userData.phoneNumberVerificationStatus ?? "";
      _idCardVerificationStatus.value = userData.cnicVerificationStatus ?? "";
      _selfieVerificationStatus.value = userData.selfieVerificationStatus ?? "";

      update();
    }
  }

  @override
  void dispose() {
    userFullNameController.dispose();
    userNumberController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
