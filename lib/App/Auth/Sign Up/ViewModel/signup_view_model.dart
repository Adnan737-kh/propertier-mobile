import 'dart:async';
import 'dart:convert';

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geocode;

import 'package:propertier/App/Auth/Login/Services/login_services.dart';

import 'package:propertier/App/Auth/Sign%20Up/Services/signup_services.dart';
import 'package:propertier/App/What%20are%20you%20searching/ViewModel/what_are_viewmodel.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/constant/toast.dart';

import 'package:http/http.dart' as http;
import 'package:propertier/repository/auth_repo/signup_repo/signup_repo.dart';

import '../../../../Handlers/Auth Handler/auth_handler.dart';
import '../../../../data/app_exception.dart';
import '../../Service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../Model/signup_model.dart';

class SignUpViewModel extends GetxController {
  String? isVendor = Get.arguments;
  UserPreference userPreference = UserPreference();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController searchAddressController = TextEditingController();
  EmailOTP myAuth = EmailOTP();
  final _api = SignUpRepository();
  final RxBool _isSuccess = false.obs;
  final formKey = GlobalKey<FormState>();
  final calledFormKey = GlobalKey<FormState>();
  var isShowPassword = false.obs;
  var isShowConfirmPassword = false.obs;
  RxBool isKeyboard = false.obs;
  RxBool isLoading = false.obs;
  bool get isSuccess => _isSuccess.value;
  RxString verifyID = ''.obs;
  final RxDouble _latitude = (0.0).obs;
  double get latitude => _latitude.value;
  final RxDouble _longitude = (0.0).obs;
  double get longitude => _longitude.value;
  RxBool isGoogleSigninLoading = false.obs;
  RxList<Place> places = <Place>[].obs;


  @override
  void dispose() {
    emailController.dispose();
    numberController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void getGeoCode(val) async {
    List<geocode.Location> locations = await geocode.locationFromAddress(val);
    _latitude.value = locations.first.latitude;
    _longitude.value = locations.first.longitude;
  }

  changeLoading(bool val) {
    _isSuccess.value = val;
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
      CustomToast.show(
          title:
              'User already register with this email: ${emailController.text}',
          context: context);
      return false;
    }
  }

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

  loginWithGoogle({required BuildContext context}) async {
    isGoogleSigninLoading.value = true;
    try {
      var isSuccess = await AuthHandler.signInHandler(AuthHandlerEnum.google);
      if (isSuccess) {
        Get.offAndToNamed(AppRoutes.navBarView);
      } else {}
      isGoogleSigninLoading.value = false;
    } catch (e) {
      isGoogleSigninLoading.value = false;
      Get.rawSnackbar(message: e.toString());
    }
  }

  loginWithApple({required BuildContext context}) async {
    isLoading.value = true;
    try {
      var isSuccess = await AuthHandler.signInHandler(AuthHandlerEnum.apple);
      if (isSuccess) {
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
    if (kDebugMode) {
      print("Email OTP $data");
    }
    if (data == true) {
      changeLoading(false);

      Get.toNamed(AppRoutes.verifySignInView,
          arguments: "SignUpWithEmailAndPassword");
    } else {
      changeLoading(false);
    }
  }


  Future<void> searchPlaces(String input,
      {bool isCurrentLocation = false}) async {
    const apiKey = Constant.googleApiKey;
    const endpoint =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final url = '$endpoint?input=$input&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print("******* $apiKey");
      print(response.body);
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.statusCode);
      }
      final data = json.decode(response.body);
      if (kDebugMode) {
        print('Prediction $data');
      }
      final predictions = data['predictions'] as List<dynamic>;
      if (kDebugMode) {
        print("Prediction ${predictions.length}");
      }
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

  void signUp() {
    isLoading(true);

    SignUpModel signUpData = SignUpModel(
      fullName: nameController.value.text,
      email: emailController.value.text,
      password: passwordController.value.text,
      passwordConfirm: confirmPasswordController.value.text,
    );

    _api.signup(signUpData.toMap()).then((onValue) async {
      isLoading(false);

      int statusCode = onValue['statusCode'];
      dynamic body = onValue['body'];

      if (kDebugMode) {
        print('StatusCode: $statusCode');
        print('Body: $body');
      }

      if (statusCode == 200 || statusCode == 201) {
        if (body != null && body.containsKey('otp_token')) {
          String otpToken = body['otp_token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('otp_token', otpToken);

          if (kDebugMode) {
            print(' otp_token stored: $otpToken');
          }

          CustomToast.show(title: 'OTP Sent to Your Gmail', context: Get.context!);
          Get.toNamed(AppRoutes.otpVerifyView);
        } else {
          CustomToast.show(
              title: 'Signup successful, but no OTP token found.',
              context: Get.context!);
        }
      } else {
        if (body is Map && body.containsKey('detail')) {
          CustomToast.show(title: body['detail'].toString(), context: Get.context!);
        } else {
          CustomToast.show(
              title: 'Signup failed. Please try again.', context: Get.context!);
        }
      }
    }).onError((error, stackTrace) {
      isLoading(false);

      if (error is UserAlreadyExistsException) {
        CustomToast.show(
            title: 'User with this email already exists',
            context: Get.context!);
      } else {
        CustomToast.show(title: 'An error occurred: $error', context: Get.context!);
      }

      if (kDebugMode) {
        print('Signup error: $error\n$stackTrace');
      }
    });
  }
}
