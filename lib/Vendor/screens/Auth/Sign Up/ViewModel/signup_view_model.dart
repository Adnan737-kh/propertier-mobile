import 'dart:async';
import 'dart:convert';

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:geocoding/geocoding.dart' as geocode;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/App/What%20are%20you%20searching/ViewModel/what_are_viewmodel.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Vendor/screens/Auth/Service/auth_service.dart';
import 'package:propertier/Vendor/screens/Auth/Sign%20Up/Services/signup_services.dart';
import 'package:propertier/constant/toast.dart';

// import 'package:speech_to_text/speech_to_text.dart' as stt;



class SignUpViewModel extends GetxController {
  final usernameController = TextEditingController();
  final userNumberController = TextEditingController();
  final userEmailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final locationController = TextEditingController();
  final searchAddressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isShowPassword = false.obs;
  var isShowConfirmPassword = false.obs;

  RxBool isKeyboard = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // _speech = stt.SpeechToText();
    // _initSpeechRecognizer();
  }

  @override
  void dispose() {
    userEmailController.dispose();
    userNumberController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    // _idleTimer?.cancel();

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
  final RxBool _isSuccess = true.obs;
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
        await AuthService().registerUser(result!, password);
        isDone = true;
      }
      return isDone;
    } catch (e) {
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

  void _initSpeechRecognizer() async {
    // bool available = await _speech.initialize(
    //   onError: (error) => print('Error: $error'),
    // );
    // if (available) {
    //   _isListening.value = false;
    // } else {
    //   print('The user has denied the use of speech recognition.');
    // }
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

  // Timer? _idleTimer;

  // void _resetIdleTimer(String msg, int fieldNo) {
  //   _idleTimer?.cancel();
  //   _idleTimer = Timer(const Duration(seconds: 1), () {
  //     debugPrint(_lastWords.toString());
  //     if (_lastWords != '') {
  //       if (fieldNo == 0) {
  //         usernameController.text = msg;
  //       }
  //       if (fieldNo == 1) {
  //         userEmailController.text = msg;
  //       }
  //     }
  //     //  stopListening();
  //     // initSpeech();
  //     // startListening();
  //   });
  // }

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
      changeLoading(true);

      Get.toNamed(
        AppRoutes.verifySignInView,
      );
    } else {
      changeLoading(true);
    }
  }

  RxList<Place> places = <Place>[].obs;

  Future<void> searchPlaces(String input,
      {bool isCurrentLocation = false}) async {
    const apiKey = 'AIzaSyC0EAVt8egPftM2_zHoEl6mev3go1NLmx8';
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

  RxBool isGoogleSigninLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> sigupWithGoogle({required BuildContext context}) async {
    isGoogleSigninLoading.value = true;
    print("Starting Google Sign-In process...");

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("Google Sign-In result: $googleUser");

      if (googleUser != null) {
        print("GOOGLE MAIL: ${googleUser.email}");

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        print("Google Authentication: $googleAuth");

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;
        // print("User Credential: $user");
        // toast(title: "User Credential: $user", context: context);
        if (user != null) {
          final isSuccessData = await SignupServices().signupUserData(
              context: context,
              address: '',
              pinCode: '',
              name: user.displayName,
              email: user.email,
              profilePicUrl: user.photoURL ?? "",
              firebaseID: user.uid,
              phoneNumber: user.phoneNumber ?? "");
          if (isSuccessData != null) {
            await AuthService().registerUser(isSuccessData, user.email!).then(
              (value) {
                isGoogleSigninLoading.value = false;
                toast(title: "Success in signup", context: context);
                Get.offAndToNamed(AppRoutes.navBarView);
              },
            );
          } else {
            toast(title: "Signup not successful", context: Get.context!);
          }
        } else {
          toast(title: "User sign-in failed", context: Get.context!);

          // print('User sign-in failed');
        }
      } else {
        toast(
            title: "Google Sign-In returned null result",
            context: Get.context!);

        // print('Google Sign-In returned null result');
      }
    } catch (e) {
      toast(title: "Error during Google Sign-In: $e", context: Get.context!);

      debugPrint("Error during Google Sign-In: $e");
    } finally {
      isGoogleSigninLoading.value = false;
    }
  }
}
