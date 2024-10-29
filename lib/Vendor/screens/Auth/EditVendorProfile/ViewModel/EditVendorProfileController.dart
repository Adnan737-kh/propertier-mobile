import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
import 'package:image_picker/image_picker.dart';
import 'package:propertier/App/What%20are%20you%20searching/ViewModel/what_are_viewmodel.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/AppImagePicker.dart';
import 'package:propertier/Vendor/screens/Auth/Service/auth_service.dart';
import 'package:propertier/Vendor/screens/Auth/Sign%20Up/Services/signup_services.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/constant/toast.dart';
import '../../../../../App/Auth/Login/Model/user_login_model/user_login_model.dart' as usr;
import '../Services/EditVendorProfileService.dart';
import 'package:propertier/Vendor/screens/Auth/Login/Model/user_login_model/user_login_model.dart';


class EditVendorProfileController extends GetxController{
  usr.User user = Get.arguments;
  final usernameController = TextEditingController();
  final userNumberController = TextEditingController();
  final userEmailController = TextEditingController();
  final locationController = TextEditingController();
  final searchAddressController = TextEditingController();
  final noteC = TextEditingController();
  final formKey = GlobalKey<FormState>();


  RxString profileImagePath = "".obs;
  RxString cnicFrontPath = "".obs;
  RxString cnicBackPath = "".obs;




  RxBool isKeyboard = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(user.toJson());
    usernameController.text = user.name??"";
    userEmailController.text = user.email??"";
    locationController.text = user.address??"";
    userNumberController.text = user.phoneNumber??"";
    noteC.text = user.about??"";
  }

  @override
  void dispose() {
    userEmailController.dispose();
    userNumberController.dispose();
    usernameController.dispose();
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

  Future<bool> updateUser({
    String? name,
    required String email,
    String? phoneNumber,
    required String pinCode,
    required BuildContext context,
    required String address,
    String? cnicFront,
    String? cnicBack,
    String? profileImage,
    bool isGoogleLogin = false,
  }) async {
    try {
      changeLoading(isGoogleLogin);
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      print(uid);
      if(uid == null) return false;
      final result = await Editvendorprofileservice().updateUserData(
          context: context,
          address: address,
          pinCode: pinCode,
          latitude: _latitude.toString(),
          longitude: _longitude.toString(),
          name: name,
          email: email,
          firebaseID: uid,
          phoneNumber: phoneNumber,
          cnicFront: cnicFront,
          cnicBack: cnicBack,
        id: user.id.toString(),
        profileImage: profileImage
      );
      print("Data is Here $result");
      if(result != null){
        // await AuthService().registerUser(userLoginModel, "");
        return true;
      }
      return false;
    } catch (e) {
      // toast(title: 'User already register with this email', context: context);
      return false;
    }
  }

  Future<File?> pickImage(BuildContext context)async{
    return await showOption(context);
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
        AppRoutes.verifySigninView,
      );
    } else {
      changeLoading(true);
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
          // final isSuccessData = await SignupServices().signupUserData(
          //     context: context,
          //     address: '',
          //     pinCode: '',
          //     name: user.displayName,
          //     email: user.email!,
          //     profilePicUrl: user.photoURL ?? "",
          //     firebaseID: user.uid,
          //     phoneNumber: user.phoneNumber ?? "",
          // );
          // if (isSuccessData != null) {
          // await AuthService().registerUser(isSuccessData, user.email!).then(
          //   (value) {
          //     isGoogleSigninLoading.value = false;
          //     toast(title: "Success in signup", context: context);
          //     Get.offAndToNamed(AppRoutes.navBarView);
          //   },
          // );
          // } else {
          //   toast(title: "Signup not successful", context: Get.context!);
          // }
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