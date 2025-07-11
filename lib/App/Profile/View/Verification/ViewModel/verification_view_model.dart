import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../../../Model/profile_model.dart';
import '../../../ViewModel/profile_view_model.dart';

class VerificationViewModel extends GetxController {
  final usernameController = TextEditingController();
  final userNumberController = TextEditingController();
  final userFullNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final _emailVerificationStatus = ''.obs;
  final _numberVerificationStatus = ''.obs;
  final _idCardVerificationStatus = ''.obs;
  final _selfieVerificationStatus = ''.obs;
  RxString get emailVerificationStatus => _emailVerificationStatus;
  RxString get numberVerificationStatus => _numberVerificationStatus;
  RxString get idCardVerificationStatus => _idCardVerificationStatus;
  RxString get selfieVerificationStatus => _selfieVerificationStatus;
  UserPreference userPreference = UserPreference();
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  final profileVM = Get.put(ProfileViewModel());
  String? _userID;
  String? get userID => _userID;

  String? accessToken;

  var isShowPassword = false.obs;
  var isShowConfirmPassword = false.obs;
  var isName = false.obs;
  var isEmail = false.obs;
  var isPhone = false.obs;
  var isAddress = false.obs;
  RxBool isLoading = false.obs;

  RxBool isKeyboard = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVerificationStatus();
  }

  void fetchVerificationStatus() async {
    isLoading.value = true;
    final accessTokenData = await userPreference.getUserAccessToken();

    if (accessTokenData.accessToken != null &&
        accessTokenData.accessToken!.isNotEmpty &&
        accessTokenData.accessToken != 'null') {
      accessToken = accessTokenData.accessToken;

      final latestProfile = await profileVM.getProfile(
        context: Get.context!,
        accessToken: accessToken!,
      );

      if (latestProfile != null) {
        profileModel.value = latestProfile;

        _userID = latestProfile.userProfile?.id.toString();
        _emailVerificationStatus.value =
            latestProfile.userProfile?.emailVerificationStatus ?? "";
        _numberVerificationStatus.value =
            latestProfile.userProfile?.phoneNumberVerificationStatus ?? "";
        _idCardVerificationStatus.value =
            latestProfile.userProfile?.cnicVerificationStatus ?? "";
        _selfieVerificationStatus.value =
            latestProfile.userProfile?.selfieVerificationStatus ?? "";
      }
    }

    isLoading.value = false;
    update();
  }

  // void fetchVerificationStatus() async {
  //   final accessToken = await userPreference.getUserAccessToken();
  //   if (kDebugMode) {
  //     print('Verification Access Token: ${accessToken.accessToken} ');
  //   }
  //
  //   final userData = await userPreference.getUserProfileData();
  //   print('email status ${userData?.phoneNumberVerificationStatus}');
  //
  //   if (userData != null) {
  //     _emailVerificationStatus.value = userData.emailVerificationStatus ?? "";
  //     _numberVerificationStatus.value =
  //         userData.phoneNumberVerificationStatus ?? "";
  //     _idCardVerificationStatus.value = userData.cnicVerificationStatus ?? "";
  //     _selfieVerificationStatus.value = userData.selfieVerificationStatus ?? "";
  //
  //     update();
  //   }
  // }


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
