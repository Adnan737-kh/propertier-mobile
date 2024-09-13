import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart' as geocode;

import 'package:propertier/App/Auth/Login/Model/user_login_model/user_login_model.dart';
import 'package:propertier/App/Auth/Service/auth_service.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/App/Profile/View/Edit%20Profile/services/edit_profile_services.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/App/What%20are%20you%20searching/ViewModel/what_are_viewmodel.dart';
import 'package:http/http.dart' as http;

import '../../../../Auth/Login/Services/login_services.dart';
import '../../../../Auth/Service/google_sigin_services.dart';

class EditProfileViewModel extends GetxController {
  final usernameController = TextEditingController();
  final searchAddressController = TextEditingController();
  final userNumberController = TextEditingController();
  final userFullNameController = TextEditingController();
  final userAboutController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  final FocusNode focusNode6 = FocusNode();
  var isShowPassword = false.obs;
  var isShowConfirmPassword = false.obs;
  var isName = false.obs;
  var isEmail = false.obs;
  var isPassword = false.obs;
  var isPhone = false.obs;
  var isAbout = false.obs;
  var isAddress = false.obs;
  final RxString _initialCode = '+92'.obs;
  String get initialCode => _initialCode.value;
  changeInitialCode(String code) {
    _initialCode.value = code;
  }

  RxBool isKeyboard = false.obs;
  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  // final GetStorage _storage = GetStorage();
  Rx<UserLoginModel> userData = UserLoginModel().obs;
  getUserData() async {
    // final user = await _storage.read('user');
    userData.value = await AuthService().getCurrentUser() ?? UserLoginModel();
    print("User is ${userData.value}");
    if (userData.value.users != null) {
      userFullNameController.text = userData.value.users?.first.name ?? '';
      userNumberController.text = userData.value.users?.first.phoneNumber ?? '';
      // _initialCode.value = userData!.value.phoneNumberCountryCode ?? "+92";
      usernameController.text = userData.value.users?.first.email ?? '';
      // passwordController.text = userData!.value.users?.first.hashedPassword ?? '';
      userAboutController.text = userData.value.users?.first.about ?? '';
      addressController.text = userData.value.users?.first.address ?? '';
    }
  }

  @override
  void dispose() {
    userFullNameController.dispose();
    userNumberController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    userAboutController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final RxBool _isSuccess = true.obs;
  bool get isSuccess => _isSuccess.value;
  Future editProfileData({
    required BuildContext context,
    required String id,
    required String password,
    required String profileImage,
    required String coverImage,
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String about,
  }) async {
    _isSuccess.value = false;
    final result = await EditProfileServices().editProfile(
        context: context,
        phoneNumberCountryCode: _initialCode.value,
        latitudePosition: _latitude.value.toString(),
        longitudePosition: _longitude.value.toString(),
        id: id,
        password: password,
        profileImage: profileImage,
        coverImage: coverImage,
        name: name,
        email: email.toLowerCase(),
        phoneNumber: phoneNumber,
        address: address,
        about: about);
    // _isSuccess.value = true;

    if (result != null) {
      var token = await GoogleSiginServices().getIdToken();
      await LoginServices()
          .loginUser(
        email: result.email ?? '',
        password: token,
      )
          .then(
        (value) {
          AuthService().registerUser(value!, "").whenComplete(() {
            final vm = Get.put(ProfileViewModel());
            final homeVM = Get.put(HomeViewModel());
            homeVM.getHomePageData(context: context);
            vm.getProfilePageData(
                context: context, id: value.users!.first.id!.toString());
            getUserData();
            Get.back();
          });
        },
      );
    }
    _isSuccess.value = true;

    // print("New user = ${newUser.cover}");

    _profileImage.value = '';
    _coverImage.value = '';
  }

  final RxString _profileImage = ''.obs;

  String get profileImage => _profileImage.value;
  final RxString _coverImage = ''.obs;

  String get coverImage => _coverImage.value;
  pickImage({required bool isPorfileImage}) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      if (isPorfileImage == true) {
        _profileImage.value = image.path;
      } else if (isPorfileImage == false) {
        _coverImage.value = image.path;
      }
    }
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

  void focusTextField(FocusNode focusNode, BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void onClose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    passwordFocusNode.dispose();
    focusNode6.dispose();
    super.onClose();
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
      final predictions = data['predictions'] as List<dynamic>;
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

  String removeFirstThreeLetters(String str) {
    if (str.length <= 3) {
      return ''; // If the string has 3 or fewer characters, return an empty string
    }
    return str.substring(3); // Remove the first 3 characters
  }
}
