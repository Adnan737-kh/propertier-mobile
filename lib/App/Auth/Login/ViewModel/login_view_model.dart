import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Handlers/Auth%20Handler/auth_handler.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/data/app_exception.dart';
import 'package:propertier/extensions/localization_extension.dart';
import '../../../../constant/AppButton/text_button.dart';
import '../../../../constant/toast.dart';
import '../../../../repository/auth_repo/login_repo/login_repo.dart';
import '../../User/model/token_model.dart';
import '../../User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../sign_model/sign_model.dart';

class LoginViewModel extends GetxController {
  final UserPreference userPreference = UserPreference();
  final LoginRepository _api = LoginRepository();
  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isShowPassword = false.obs;

  RxBool isKeyboard = false.obs;

  @override
  void onClose() {
    userEmailController.clear();
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
    isLoading.value = true;
    if (!isValidEmail(email)) {
      CustomToast.show(title: 'Please Enter valid Email', context: context);
      isLoading.value = false;
      return false;
    }
    bool isDone = false;
    try {
      isLoading.value = true;
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
                          CustomText(
                              title: context.local.oops,
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                          ),
                          Gap(Get.context!.width * 0.10),
                          CustomText(
                              title:context.local.invalid_credentials,
                              // title: e.toString(),
                              color: AppColor.darkGreyColor,
                              ),
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
      isLoading.value = false;
      return isDone;
    }
  }

  void startListening({required int textFieldNo}) async {}

  RxBool isGoogleSignInLoading = false.obs;
  loginWithGoogle({required BuildContext context}) async {
    isGoogleSignInLoading.value = true;
    try {
      var isSuccess = await AuthHandler.signInHandler(AuthHandlerEnum.google,
          isLogin: true);
      if (isSuccess) {
        Get.offAndToNamed(AppRoutes.navBarView);
      } else {}
      isGoogleSignInLoading.value = false;
    } catch (e) {
      isGoogleSignInLoading.value = false;
      Get.rawSnackbar(message: e.toString());
    }
  }

  RxBool isLoading = false.obs;
  loginWithApple({required BuildContext context}) async {
    isLoading.value = true;
    try {
      var isSuccess =
          await AuthHandler.signInHandler(AuthHandlerEnum.apple, isLogin: true);
      if (isSuccess) {
        Get.offAndToNamed(AppRoutes.navBarView);
      } else {}
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.rawSnackbar(message: e.toString());
    }
  }

  void loginUser() {
    isLoading(true);

    SignInModel loginUser = SignInModel(
      email: userEmailController.value.text,
      password: passwordController.value.text,
    );

    _api.login(loginUser.toMap()).then((onValue) async {
      isLoading(false);

      int statusCode = onValue['statusCode'];
      dynamic body = onValue['body'];

      if (kDebugMode) {
        print('Login API Response: $body');
        print('Status Code: $statusCode');
      }

      if (statusCode == 200 && body != null && body.containsKey('token')) {
        String? accessToken = body['token']['access'];

        if (kDebugMode) {
          print('Access Token: $accessToken');
        }

        await userPreference.saveUserAccessToken(TokenModel.fromJson(body)).then((onValue) {
          Get.offAllNamed(AppRoutes.navBarView);
          CustomToast.show(title: 'Login Successfully', context: Get.context!);
        }).onError((error, stackTrace) {
          CustomToast.show(title: 'Failed to save token', context: Get.context!);
        });
      } else {
        // handle error message from backend
        if (body is Map && body.containsKey('detail')) {
          CustomToast.show(title: body['detail'].toString(), context: Get.context!);
        } else {
          CustomToast.show(title: 'Login failed. Please try again.', context: Get.context!);
        }
      }
    }).onError((error, stackTrace) {
      isLoading(false);

      if (error is EmailOrPasswordIncorrect) {
        CustomToast.show(title: 'Email Or Password is Incorrect', context: Get.context!);
      } else {
        CustomToast.show(title: 'An error occurred: $error', context: Get.context!);
      }

      if (kDebugMode) {
        print('$error and $stackTrace');
      }
    });
  }
}
