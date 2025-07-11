import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/dashboard/fearture_ads/Model/feature_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/award_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../App/Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../../../../../Network/api_urls.dart';
import '../../../../../Utils/App Ad Mob/app_interstitial_ads.dart';
import '../../../../../repository/vendor/vendor_auth/vendor_auth.dart';
import '../../../drawer/vehicle_list/model/VehicleModel.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  RxString selectedCoverPhotoPath = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingProfile = false.obs;
  var profile = ProfileModel().obs;
  var errorMessage = ''.obs;
  List<AwardModel> allAwards = [];
  List<ServiceModel> allServices = [];
  RxList<FeatureAd> allFeaturedServices = <FeatureAd>[].obs;
  bool _isProfileLoaded = false; // Flag to track profile loading
  bool isImageAdded = false; // Flag to check if image is added
  final VendorRepository _profileViewRepository = VendorRepository();
  // Rx<profile_model.ProfileModel> profileModel = profile_model.ProfileModel().obs;
  Rx<VendorProfileModel> profileModel = VendorProfileModel().obs;
  String? accessToken;
  UserPreference userPreference = UserPreference();

  @override
  Future<void> onInit() async {
    super.onInit();
    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('Vendor Access Token  !!! ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        accessToken = value.accessToken;
        profileModel.value = await getVendorProfile(
          context: Get.context!,
          id: value.accessToken!,
        );

        userPreference.getUserProfileData().then((value) async {
          if (value!.email!.isNotEmpty || value.email.toString() != 'null') {
            getAwards(profileModel.value.id!.toString());
            if (kDebugMode) {
              print('user saved id $value.id.toString()');
            }
          }
        });
      }
    });

    if (!_isProfileLoaded) {
      loadProfile();

      String? vendorUserId = (await ApiService().getVendorUserId());

      if (vendorUserId != null) {
        getFeaturedServices(vendorUserId);
        // getServices(vendorUserId);
        getAwards(vendorUserId);
      } else {
        if (kDebugMode) {
          print('Vendor User ID is null');
        }
      }
    }
    loadExpirationDate();
  }

  final ApiService apiService = ApiService();
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  void setImage(XFile? image) {
    _image = image;
    update(); // Notify listeners if using GetX reactive state management
  }

  Future<void> getAwards(String vendorUserId) async {
    if (kDebugMode) {
      print('vendorUserId $vendorUserId');
    }
    try {
      isLoading(true);
      allAwards = await apiService.getAwards(vendorUserId);
    } catch (e) {
      errorMessage.value = 'Failed to load awards';
    } finally {
      isLoading(false);
    }
  }

  Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  Future<String?> getIdToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    return await user?.getIdToken();
  }

  Future pickImage() async {
    isLoading.value = true;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      isImageAdded = false;
      update();
    }
    isLoading.value = false;
  }

  Future<void> addService(
      AwardModel awardModel, String accessToken, BuildContext context) async {
    isLoading.value = true;

    try {
      final result = await apiService.addAwards(awardModel, accessToken);
      final statusCode = result['statusCode'];
      final responseBody = result['body'];

      if (statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Award added successfully')),
        );
        if (kDebugMode) print("responseBody $responseBody");

        await getAwards(profileModel.value.id.toString());
        isImageAdded = true;
        update();
      } else {
        String errorMessage = 'Unknown error occurred';

        // Handle error message based on response type
        if (responseBody is String) {
          try {
            final parsed = jsonDecode(responseBody);
            errorMessage = parsed['detail'] ?? errorMessage;
          } catch (_) {
            errorMessage = 'Error parsing the response';
          }
        } else if (responseBody is Map && responseBody['detail'] != null) {
          errorMessage = responseBody['detail'];
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );

        if (kDebugMode) {
          print('statusCode $statusCode');
          print('response $responseBody');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<VendorProfileModel> getVendorProfile({
    required BuildContext context,
    required String id,
  }) async {
    isLoading.value = true;

    try {
      final result =
          await _profileViewRepository.viewVendorProfileDetails(accessToken!);

      final dataResponse = VendorProfileModel.fromJson(result);
      profileModel.value = dataResponse;

      // await userPreference.saveUserProfileData(profileModel.value.user!);

      if (kDebugMode) {
        print('Vendor Profile Data Saved: $result');
      }

      return profileModel.value;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Error fetching profile: $error');
        print('$stackTrace');
      }

      // Get.offAllNamed(AppRoutes.loginView);
      isLoading(false);
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadProfile() async {
    if (_isProfileLoaded) return;

    String? vendorUserId = (await ApiService().getVendorUserId());

    if (vendorUserId != null) {
      try {
        ProfileModel profile = await ApiService().fetchProfile(vendorUserId);
        this.profile.value = profile;
        _isProfileLoaded = true;

        if (kDebugMode) {
          print('Profile loaded: ${profile.toJson()}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error loading profile: $e');
        }
      }
    } else {
      if (kDebugMode) {
        print('Vendor user ID not found');
      }
    }
  }

  Future<void> getServices(String vendorUserId) async {
    try {
      isLoading.value = true;
      allServices = await apiService.getServices(vendorUserId);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching services: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFeaturedServices(String vendorUserId,
      {bool forceRefresh = false}) async {
    if (!forceRefresh && allFeaturedServices.isNotEmpty) {
      if (kDebugMode) {
        print('Using cached featured services data.');
      }
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final List<FeatureAd> services =
          await apiService.getFeaturedServices(vendorUserId);
      allFeaturedServices.assignAll(services);
    } catch (e) {
      errorMessage.value = 'Failed to load featured services: $e';
      if (kDebugMode) {
        print('Error in fetchVendorFeaturedServices: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteService(int serviceId) async {
    isLoading.value = true;

    final success = await apiService.deleteService(serviceId);

    isLoading.value = false;

    if (success) {
      final box = GetStorage();
      String? vendorUserId = box.read('vendorUserId');
      if (vendorUserId != null) {
        await getServices(vendorUserId);
      }

      Get.snackbar('Success', 'Service deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete service');
    }
  }

  Future<void> deleteFeaturedService(int serviceId) async {
    isLoading.value = true;

    final success = await apiService.deleteFeaturedService(serviceId);

    isLoading.value = false;

    if (success) {
      allFeaturedServices.clear();

      final box = GetStorage();
      String? vendorUserId = box.read('vendorUserId');
      if (vendorUserId != null) {
        await getFeaturedServices(vendorUserId, forceRefresh: true);
      }

      Get.snackbar('Success', 'Service deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete service');
    }
  }

  Future<void> deleteAward(int awardId, String accessToken) async {
    if (kDebugMode) {
      print('award id $awardId');
    }
    isLoading.value = true;

    final success = await apiService.deleteAward(awardId, accessToken);

    isLoading.value = false;

    if (success) {
      await getAwards(profileModel.value.id!.toString());

      Get.snackbar('Success', 'Award deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete Award');
    }
  }

  Future<void> updateUserProfile(String vendorUserId, ProfileModel profileModel,
      ProfileController profileController, BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        title: const Text('Updating Profile'),
        message: const Text('Please wait'));
    progressDialog.show();

    try {
      await apiService.updateUserProfile(
          vendorUserId, profileModel, profileController);

      Get.snackbar('Success', 'Profile updated successfully');

      profileController._isProfileLoaded = false;
      await profileController.loadProfile();
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while updating the profile: $e');
    } finally {
      progressDialog.dismiss();
    }
  }

  Future<void> updateCoverPicture(String vendorUserId, File imageFile) async {
    ProgressDialog progressDialog = ProgressDialog(Get.context!,
        title: const Text('Updating Cover Picture'),
        message: const Text('Please wait'));
    progressDialog.show();
    try {
      await apiService.updateCoverPicture(vendorUserId, imageFile,
          profile.value.firebaseId!, profile.value.email!);

      profile.value = ProfileModel();
      _isProfileLoaded = false;

      await loadProfile();

      Get.snackbar('Success', 'Cover picture updated successfully');
    } catch (e) {
      Get.snackbar(
          'Error', 'An error occurred while updating the cover picture: $e');
    } finally {
      progressDialog.dismiss();
    }
  }

  Future<void> updateDrivingLicense(
      File? front, File? back, String vendorUserId) async {
    ProgressDialog progressDialog = ProgressDialog(Get.context!,
        title: const Text('Updating License Picture'),
        message: const Text('Please wait'));
    progressDialog.show();
    try {
      await apiService.updateDrivingLicense(front, back, vendorUserId,
          profile.value.firebaseId!, profile.value.email!);

      profile.value = ProfileModel();
      _isProfileLoaded = false;

      await loadProfile();

      Get.snackbar('Success', 'License picture updated successfully');
    } catch (e) {
      Get.snackbar(
          'Error', 'An error occurred while updating the cover picture: $e');
    } finally {
      progressDialog.dismiss();
    }
  }

// need to work on this api

  Future<void> updateProfilePicture(File imageFile, String vendorId) async {
    ProgressDialog progressDialog = ProgressDialog(Get.context!,
        title: const Text('Updating Profile Picture'),
        message: const Text('Please wait'));
    progressDialog.show();
    try {
      final String apiUrl = '${API.updateUserProfile}/$vendorId/';
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(apiUrl),
      )..files.add(
          await http.MultipartFile.fromPath('profile_picture', imageFile.path));

      request.fields['type'] = "vendor";
      request.fields['firebase_id'] = profile.value.firebaseId!;
      request.fields['email'] = profile.value.email!;

      var response = await request.send();
      if (kDebugMode) {
        print(apiUrl);
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        // Handle successful response
        Get.snackbar('Success', 'Profile picture updated successfully');
        profile.value = ProfileModel();
        loadProfile(); // Reload the profile to update the image
      } else {
        Get.snackbar('Error', 'Failed to update profile picture');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      if (kDebugMode) {
        print(e);
      }
    } finally {
      progressDialog.dismiss();
    }
  }

  Future<List<VehicleModel>> fetchMyVehicles(String vendorId) async {
    return await apiService.fetchMyVehicles(vendorId);
  }

  // *********** License *****************
  final GetStorage storage = GetStorage();
  static const String expirationKey = 'licenseExpiration';

  // Rx variable for expiration date
  Rx<DateTime?> expirationDate = Rx<DateTime?>(null);

  // Load the expiration date from storage
  void loadExpirationDate() {
    final storedTime = storage.read(expirationKey);
    if (storedTime != null) {
      expirationDate.value = DateTime.parse(storedTime);
    }
  }

  // Check if the license has expired
  bool isLicenseExpired() {
    if (expirationDate.value == null) return true;
    return DateTime.now().isAfter(expirationDate.value!);
  }

  // Renew license by setting a new expiration date
  void renewLicense() async {
    await loadAndShowInterstitialAd(flag: true);
    final newExpiration = DateTime.now().add(const Duration(hours: 24));
    storage.write(expirationKey, newExpiration.toIso8601String());
    expirationDate.value =
        newExpiration; // This will automatically update the UI
  }

  // *********** License *****************
}
