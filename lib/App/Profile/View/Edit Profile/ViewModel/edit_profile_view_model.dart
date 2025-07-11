import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart' as geocode;
import 'package:path/path.dart';

import 'package:propertier/App/Auth/Login/Model/user_login_model/user_login_model.dart';
import 'package:propertier/App/Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import 'package:propertier/App/What%20are%20you%20searching/ViewModel/what_are_viewmodel.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/res/app_urls/app_url.dart';

import '../../../../../constant/toast.dart';
import '../../../../../repository/profile_repo/profile_view/profile_view_repo.dart';
import '../../../Model/profile_model.dart';

class EditProfileViewModel extends GetxController {
  final emailController = TextEditingController();
  final searchAddressController = TextEditingController();
  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final aboutController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
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
  var isLoading = false.obs;
  String? accessToken;
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  Rx<UserLoginModel> userData = UserLoginModel().obs;
  UserPreference userPreference = UserPreference();
  final RxString _profileImage = ''.obs;
  final RxString _coverImage = ''.obs;
  String get profileImage => _profileImage.value;
  String get coverImage => _coverImage.value;
  final RxDouble _latitude = (0.0).obs;
  double get latitude => _latitude.value;
  final RxDouble _longitude = (0.0).obs;
  double get longitude => _longitude.value;
  RxList<Place> places = <Place>[].obs;
  RxBool isKeyboard = false.obs;
  final ProfileViewRepository _profileViewRepository = ProfileViewRepository();

  @override
  void onInit() async {
    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('edit ACCESS   !!! ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        accessToken = value.accessToken;
        profileModel.value = await getProfilePageData(
          context: Get.context!,
          id: value.accessToken!,
        );
      }
    });
    super.onInit();
  }

  Future<ProfileModel> getProfilePageData({
    required BuildContext context,
    required String id,
  }) async {
    isLoading.value = true;
    _profileViewRepository.viewProfileDetails(accessToken!).then((result) async {
      final dataResponse = ProfileModel.fromJson(result);
      profileModel.value = dataResponse;

      nameController.text = profileModel.value.userProfile?.name ?? '';
      numberController.text =
          profileModel.value.userProfile?.phoneNumber ?? '';
      // _initialCode.value = userData!.value.phoneNumberCountryCode ?? "+92";
      emailController.text = profileModel.value.userProfile?.email ?? '';
      // passwordController.text = userData!.value.users?.first.hashedPassword ?? '';
      aboutController.text = profileModel.value.userProfile?.about ?? '';
      addressController.text = profileModel.value.userProfile?.address ?? '';

      isLoading(false);
    }).onError((error, stackTrace) {
      // Get.offAllNamed(AppRoutes.loginView);
      isLoading(false);

      if (kDebugMode) {
        print('$error and $stackTrace');
      }
    });
    return profileModel.value;
  }


  Future<void> editProfile() async {
    isLoading.value = true;

    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(AppUrls.profileApi),
      );

      request.headers['Authorization'] = 'Bearer $accessToken';

      // Add text fields
      request.fields['full_name'] = nameController.text.trim();
      request.fields['email'] = emailController.text.trim();
      request.fields['phone_number'] = numberController.text.trim();
      request.fields['address'] = addressController.text.trim();
      request.fields['about'] = aboutController.text.trim();

      // Attach profile picture file if selected
      if (_profileImage.value.isNotEmpty) {
        File profileFile = File(_profileImage.value);
        request.files.add(await http.MultipartFile.fromPath(
          'profile_picture', // Field name expected by the API
          profileFile.path,
          filename: basename(profileFile.path),
        ));
      }

      // Attach cover photo file if selected
      if (_coverImage.value.isNotEmpty) {
        File coverFile = File(_coverImage.value);
        request.files.add(await http.MultipartFile.fromPath(
          'cover_photo', // Field name expected by the API
          coverFile.path,
          filename: basename(coverFile.path),
        ));
      }

      // Send request
      var response = await request.send();

      // Get response body
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Get.toNamed(AppRoutes.navBarView, arguments: {'initialIndex': 2});

        if (kDebugMode) {
          print('Profile updated successfully: $responseBody');
        }
        CustomToast.show(title: 'Profile Edited Successfully', context: Get.context!);
      } else {
        if (kDebugMode) {
          print('Failed to update profile: ${response.statusCode} - $responseBody');
        }
        CustomToast.show(title: 'Failed to update profile', context: Get.context!);
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print('Error uploading profile: $e');
      }
      CustomToast.show(title: 'Error uploading profile', context: Get.context!);
    } finally {
      isLoading(false);
    }
  }


  changeInitialCode(String code) {
    _initialCode.value = code;
  }



  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    aboutController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  pickImage({required bool isProfileImage}) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      if (isProfileImage == true) {
        _profileImage.value = image.path;
      } else if (isProfileImage == false) {
        _coverImage.value = image.path;
      }
    }
  }

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
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    passwordFocusNode.dispose();
    focusNode6.dispose();
    super.onClose();
  }

  Future<void> searchPlaces(String input,
      {bool isCurrentLocation = false}) async {
    const apiKey = Constant.googleApiKey;
    const endpoint =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final url = '$endpoint?input=$input&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
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
