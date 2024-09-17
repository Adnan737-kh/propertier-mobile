import 'dart:async';
import 'dart:convert';

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:geocoding/geocoding.dart' as geocode;

import 'package:propertier/App/Auth/Login/Services/login_services.dart';

import 'package:propertier/App/Auth/Sign%20Up/Services/signup_services.dart';
import 'package:propertier/App/What%20are%20you%20searching/ViewModel/what_are_viewmodel.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/constant/toast.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:http/http.dart' as http;

import '../../../../Handlers/Auth Handler/auth_handler.dart';
import '../../../../Utils/app_text.dart';
import '../../../../constant/AppButton/text_button.dart';
import '../../../../constant/colors.dart';
import '../../Service/auth_service.dart';

class SignUpViewModel extends GetxController {
  final usernameController = TextEditingController();
  final userNumberController = TextEditingController();
  final userEmailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final locationController = TextEditingController();
  final searchAddressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final callecformKey = GlobalKey<FormState>();

  var isShowPassword = false.obs;
  var isShowConfirmPassword = false.obs;

  RxBool isKeyboard = false.obs;

  @override
  void dispose() {
    userEmailController.dispose();
    userNumberController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final RxDouble _latitude = (0.0).obs;
  double get latitude => _latitude.value;
  final RxDouble _longitude = (0.0).obs;
  double get longitude => _longitude.value;

  void getGeoCode(val) async {
    List<geocode.Location> locations = await geocode.locationFromAddress(val);
    _latitude.value = locations.first.latitude;
    _longitude.value = locations.first.longitude;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool _isSuccess = false.obs;
  bool get isSuccess => _isSuccess.value;
  changeLoading(bool val) {
    _isSuccess.value = val;
  }

  Future<bool> signupUser({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? pinCode,
    String? confirmPassword,
    required BuildContext context,
    String? address,
    bool isGoogleLogin = false,
  }) async {
    try {
      changeLoading(isGoogleLogin);
      final firebaseSignup = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      print("Firebase ID ${firebaseSignup.user!.uid}");
      bool isDone = false;
      if (firebaseSignup.user != null) {
        final result = await SignupServices().signupUserData(
            context: context,
            address: address,
            pinCode: pinCode,
            latitude: _latitude.toString(),
            longitude: _longitude.toString(),
            name: name,
            email: email,
            firebaseID: firebaseSignup.user!.uid,
            phoneNumber: phoneNumber);
        print("Data is Here $result");

        isDone = true;
      }
      return isDone;
    } catch (e) {
      // toast(title: 'User already register with this email', context: context);
      return false;
    }
  }

  Future<bool> createUser({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? pinCode,
    String? confirmPassword,
    required BuildContext context,
    String? address,
    bool isGoogleLogin = false,
  }) async {
    try {
      changeLoading(isGoogleLogin);
      final firebaseSignup = FirebaseAuth.instance.currentUser;
      // print("Firebase ID ${firebaseSignup!.uid}");
      bool isDone = false;
      if (firebaseSignup != null) {
        final result = await SignupServices().signupUserData(
            context: Get.context!,
            address: address,
            pinCode: pinCode,
            latitude: _latitude.toString(),
            longitude: _longitude.toString(),
            name: name,
            email: email,
            firebaseID: firebaseSignup.uid,
            phoneNumber: phoneNumber);
        isDone = true;
        if (result) {
          var token = await firebaseSignup.getIdToken();
          await LoginServices().loginUser(password: token!).then((value) {
            if (value != null) {
              AuthService().registerUser(value, "");
            } else {
              return false;
            }
          });
        }
      }
      return isDone;
    } catch (e) {
      toast(
          title:
              'User already register with this email: ${userEmailController.text}',
          context: context);
      // toast(title: 'User already register with this email', context: context);
      return false;
    }
  }

  // late stt.SpeechToText _speech;

  // // ignore: unused_field
  // final bool _speechEnabled = false;
  // final RxBool _isListening = false.obs;
  // bool get isListening => _isListening.value;
  // final RxString _lastWords = ''.obs;
  // String get lastWord => _lastWords.value;

  void startListening({required int textFieldNo}) async {
    // try {
    //   await _speech.listen(
    //     onResult: (result) {
    //       print("Start Listing");
    //       print(result.recognizedWords);
    //       if (_lastWords != result.recognizedWords) {
    //         _lastWords.value = result.recognizedWords;
    //         _resetIdleTimer(_lastWords.value, textFieldNo);

    //         print('Recognized Text: ${_lastWords.value}');
    //       }
    //     },
    //   );
    // } catch (e) {
    //   print('Error starting listening: $e');
    // }
  }

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

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }

  Future<bool> signUpUserData(
      {required BuildContext context,
      required String email,
      bool isGoogleLogin = false,
      required String password}) async {
    isLoading(true);
    if (!isValidEmail(email)) {
      toast(title: 'Please Enter valid Email', context: context);
      isLoading(false);
      return false;
    }
    bool isDone = false;
    try {
      isLoading(true);
      return await AuthHandler.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      isLoading(false);

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
                              title: "Warning",
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              context: Get.context!),
                          Gap(Get.context!.width * 0.10),
                          appText(
                              title:
                                  "The email address is already in use by another account.",
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

      return isDone;
    }
  }

  RxString verfID = ''.obs;
  // final _auth = FirebaseAuth.instance;
  Future phoneAuthentication({required String phone}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        print("E is Ths $verificationId");

        GetStorage().write('authkey', verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        GetStorage().write('authkey', verificationId);
      },
    );
  }

  EmailOTP myAuth = EmailOTP();
  sendOTPtoEmail({required String email}) async {
    changeLoading(true);

    myAuth.setConfig(
        appEmail: "Propertier@xyz.com",
        appName: "Propertier",
        userEmail: email,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
    myAuth.setTheme(theme: "v3");
    final data = await myAuth.sendOTP();
    print("Email OTP $data");
    if (data == true) {
      changeLoading(false);

      Get.toNamed(AppRoutes.verifySigninView,
          arguments: "SignUpWithEmailAndPassword");
    } else {
      changeLoading(false);
    }
  }

  RxList<Place> places = <Place>[].obs;

  Future<void> searchPlaces(String input,
      {bool isCurrentLocation = false}) async {
    const apiKey = Constant.google_api_key;
    const endpoint =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final url = '$endpoint?input=$input&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.statusCode);
      final data = json.decode(response.body);
      print('Prediction $data');
      final predictions = data['predictions'] as List<dynamic>;
      print("Prediction ${predictions.length}");
      places.value = predictions
          .map((prediction) => Place(
                placeId: prediction['place_id'],
                description: prediction['description'],
              ))
          .toList();
    } else {
      places.value = [];
    }
  }
}
