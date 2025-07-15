import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Vendor/screens/Auth/Login/Services/login_services.dart';
import 'package:propertier/Vendor/screens/Auth/Login/View/login_view.dart';
import 'package:propertier/Vendor/screens/Auth/Service/auth_service.dart';
import 'package:propertier/Vendor/screens/Auth/Service/google_sigin_services.dart';
import 'package:propertier/Vendor/screens/Auth/Sign%20Up/Services/signup_services.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/constant/AppButton/text_button.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/toast.dart';
import 'package:propertier/extensions/localization_extension.dart';



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

  final FirebaseAuth _auth = FirebaseAuth.instance;
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
      final login = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (login.user != null) {
        // toast(title: "Verified 😊", context: Get.context!);
        final token = await login.user!.getIdToken();
        debugPrint("AUTH TOKEN $token");
        final result = await LoginServices().loginUser(
            context: Get.context!, email: email, password: token ?? '');
        // print(result!.id);
        isDone = true;
        AuthService().registerUser(result!, password);
        debugPrint(result.toJson().toString());

        debugPrint("Data is true");
      }
      changeLoading(true);

      return isDone;
    } catch (e) {
      // toast(title: "Error: $e", context: Get.context!);
      Get.defaultDialog(
          backgroundColor: Colors.transparent,
          content: SizedBox(
              width: context.width,
              height: context.width,
              child: Stack(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: context.width * 0.090),
                    height: context.width * 0.8,
                    width: context.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.white,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Gap(context.width * 0.10),
                          CustomText(
                              title: context.local.oops,
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              ),
                          Gap(context.width * 0.10),
                          CustomText(
                              title: context.local.invalid_credentials,
                              // title: e.toString(),
                              color: AppColor.darkGreyColor,
                              ),
                          Gap(context.width * 0.10),
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
                  const Align(
                      alignment: Alignment.topCenter,
                      //  child: Image.asset(height: 84, Constant.rerdCross)
                      )
                ],
              )));
      changeLoading(true);
      return isDone;
    }
  }

  void startListening({required int textFieldNo}) async {}

  RxBool isGoogleSigninLoading = false.obs;
  final GoogleSignInServices _googleSiginServices = GoogleSignInServices();
  loginWithGoogle({required BuildContext context}) async {
    isGoogleSigninLoading.value = true;
    try {
      final result = await _googleSiginServices.loginWithGoogle();
      if (result!.user != null) {
        var token = await result.user!.getIdToken();
        debugPrint("AUTH TOKEN $token");
        var user = await LoginServices().loginUser(
            context: Get.context!,
            email: result.user!.email ?? '',
            password: token!);
        if (user != null) {
          // toast(title: "Verified 😊", context: Get.context!);
          isGoogleSigninLoading.value = false;
          AuthService().registerUser(user, result.user!.email ?? '');
          isGoogleSigninLoading.value = false;
          
              Get.offAllNamed(AppRoutes.vendorDashBoard);
               Get.put(ProfileController());
        } else if (user != null) {
          final isSuccessData = await SignupServices().signupUserData(
              context: Get.context!,
              address: '',
              pinCode: '',
              name: result.user!.displayName,
              email: result.user!.email,
              profilePicUrl: result.user!.photoURL ?? "",
              firebaseID: result.user!.uid,
              phoneNumber: result.user!.phoneNumber ?? "");
          if (isSuccessData != null) {
            await AuthService()
                .registerUser(isSuccessData, result.user!.email!)
                .then(
              (value) {
                isGoogleSigninLoading.value = false;
                toast(title: "Success in signup", context: context);
                Get.put(ProfileController());
                Get.offAndToNamed(AppRoutes.vendorDashBoard);
                 Get.put(ProfileController());
           Navigator.of(context).pushReplacement(
               MaterialPageRoute(
              builder: (context) => LoginView (), // Replace with your new page class
              ),
                );
              },
            );
          } else {
            toast(title: "Signup not successful", context: Get.context!);
          }
          isGoogleSigninLoading.value = false;
        }
      } else {
        isGoogleSigninLoading.value = false;
      }
    } catch (e) {
      Get.rawSnackbar(message: e.toString());
    }
  }
}
