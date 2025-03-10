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
      toast(title: 'Please Enter valid Email', context: context);
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
      isLoading.value = false;
      return isDone;
    }
  }

  void startListening({required int textFieldNo}) async {}

  RxBool isGoogleSignInLoading = false.obs;
  loginWithGoogle({required BuildContext context}) async {
    isGoogleSignInLoading.value = true;
    try {
      var isSccuss = await AuthHandler.signInHandler(AuthHandlerEnum.google,
          isLogin: true);
      if (isSccuss) {
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

    // Create an instance of the SignUpModel with data from the form
    SignInModel loginUser = SignInModel(
      email: userEmailController.value.text,
      password: passwordController.value.text,
    );

    // // Send the model data as a Map to the API
    _api.login(loginUser.toMap()).then((onValue) async {
      print('only API Response: $onValue');
      if (onValue != null && onValue.containsKey('token')) {
        print('the API Response: $onValue');
        String? accessToken = onValue['token']['access'];
        if (kDebugMode) {
          print('the access token !!! $accessToken');
        }

        if (accessToken != null) {
          await userPreference
              .saveUserAccessToken(TokenModel.fromJson(onValue))
              .then((onValue) {
            Get.toNamed(AppRoutes.navBarView);
            toast(title: 'Login Successfully', context: Get.context!);
          }).onError((error, stackTrace) {});

        }
      }
      // else if(onValue != null && onValue.containsKey('errors')){
      //   print('the msg is !!! ');
      //   List<dynamic>? errorMessages = onValue['errors']['non_field_errors'];
      //   if (errorMessages != null && errorMessages.isNotEmpty) {
      //     String msg = errorMessages.first.toString();  // Extracts first error message
      //     if (kDebugMode) {
      //       print('the msg is !!! $msg');
      //     }
      //     toast(title: msg, context: Get.context!);
      //   }
      // }
      isLoading(false);
    }).onError((error, stackTrace) {
      if (error is EmailOrPasswordIncorrect) {
        toast(title: 'Email Or Password is Incorrect', context: Get.context!);
      } else {
        toast(title: 'An error occurred: $error', context: Get.context!);
      }
      isLoading(false);
      if (kDebugMode) {
        print('$error and $stackTrace');
      }
    });
  }
}
