import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Handlers/Auth%20Handler/auth_handler.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import '../../../../constant/AppButton/text_button.dart';
import '../../../../constant/toast.dart';

class LoginViewModel extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isShowPassword = false.obs;

  RxBool isKeyboard = false.obs;

  @override
  void onClose() {
    usernameController.clear();
    passwordController.clear();
    // _idleTimer?.cancel();
    super.onClose();
  }

  final RxBool _isSuccess = true.obs;
  bool get isSuccess => _isSuccess.value;
  changeLoading(bool val) {
    _isSuccess.value = val;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }

  Future<bool> loginUserData(
      {required BuildContext context,
      required String email,
      bool isGoogleLogin = false,
      required String password}) async {
    changeLoading(isGoogleLogin);
    if (!isValidEmail(email)) {
      toast(title: 'Please Enter valid Email', context: context);
      changeLoading(true);
      return false;
    }
    bool isDone = false;
    try {
      changeLoading(true);
      return await AuthHandler.signInWithEmailAndPassword(email, password);
    } catch (e) {
      Get.defaultDialog(
          backgroundColor: Colors.transparent,
          content: SizedBox(
              width: Get.context!.width,
              height: Get.context!.width,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: Get.context!.width * 0.090),
                    height: Get.context!.width * 0.8,
                    width: Get.context!.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.white,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Gap(Get.context!.width * 0.10),
                          appText(
                              title: "Opps !",
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              context: Get.context!),
                          Gap(Get.context!.width * 0.10),
                          appText(
                              title: "Invalid Credentials",
                              // title: e.toString(),
                              color: AppColor.darkGreyColor,
                              context: Get.context!),
                          Gap(Get.context!.width * 0.10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: customTextButton(
                                buttonColor: Colors.red,
                                title: "Try Again",
                                onTap: () {
                                  Get.back();
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(height: 84, Constant.rerdCross))
                ],
              )));
      changeLoading(true);
      return isDone;
    }
  }

  void startListening({required int textFieldNo}) async {}

  RxBool isGoogleSigninLoading = false.obs;
  loginWithGoogle({required BuildContext context}) async {
    isGoogleSigninLoading.value = true;
    try {
      var isSccuss = await AuthHandler.signInHandler(AuthHandlerEnum.google);
      if (isSccuss) {
        Get.offAndToNamed(AppRoutes.navBarView);
      } else {}
      isGoogleSigninLoading.value = false;
    } catch (e) {
      isGoogleSigninLoading.value = false;
      Get.rawSnackbar(message: e.toString());
    }
  }

  RxBool isLoading = false.obs;
  loginWithApple({required BuildContext context}) async {
    isLoading.value = true;
    try {
      var isSccuss = await AuthHandler.signInHandler(AuthHandlerEnum.apple);
      if (isSccuss) {
        Get.offAndToNamed(AppRoutes.navBarView);
      } else {}
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.rawSnackbar(message: e.toString());
    }
  }
}
