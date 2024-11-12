import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/dashboard/fearture_ads/Model/feature_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/award_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Network/api_urls.dart';
import '../../../../../Utils/App Ad Mob/app_interstitial_ads.dart';
import '../../../drawer/vehicle_list/model/VehicleModel.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  RxString selectedCoverPhotoPath = ''.obs;
  RxBool isLoading = false.obs;
  var profile = ProfileModel().obs;
  var errorMessage = ''.obs;
  List<AwardModel> allAwards = [];
  List<ServiceModel> allServices = [];
  RxList<FeatureAd> allFeaturedServices = <FeatureAd>[].obs;
  bool _isProfileLoaded = false; // Flag to track profile loading
  bool isImageAdded = false; // Flag to check if image is added

  @override
  Future<void> onInit() async {
    super.onInit();
    if (!_isProfileLoaded) {
      loadProfile();

      String? vendorUserId = (await ApiService().getVendorUserId());

      if (vendorUserId != null) {
        getFeaturedServices(vendorUserId);
        getServices(vendorUserId);
        getAwards(vendorUserId);
      } else {
        print('Vendor User ID is null');
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



  Future<void> addService(AwardModel awardModel) async {

  isLoading.value = true; 

  try {
    await apiService.addAwards(awardModel); 
    Get.snackbar('Success', 'Award added successfully');

    final box = GetStorage();
    String? vendorUserId = box.read('vendorUserId');

    await getAwards(vendorUserId!); 
    isImageAdded = true; 
    update(); 

  } catch (e) {
    Get.snackbar('Error', 'An error occurred while adding service: $e');

  } finally {
    isLoading.value = false; 
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

        print('Profile loaded: ${profile.toJson()}');
      } catch (e) {
        print('Error loading profile: $e');
      }
    } else {
      print('Vendor user ID not found');
    }
  }

  Future<void> getServices(String vendorUserId) async {
    try {
      isLoading.value = true;
      allServices = await apiService.getServices(vendorUserId);
    } catch (e) {
      print('Error fetching services: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFeaturedServices(String vendorUserId,
      {bool forceRefresh = false}) async {
    if (!forceRefresh && allFeaturedServices.isNotEmpty) {
      print('Using cached featured services data.');
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
      print('Error in fetchVendorFeaturedServices: $e');
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


  Future <void> deleteAward(int awardId) async{
    isLoading.value=true;

    final success= await apiService.deleteAward(awardId);

     isLoading.value = false;

    if (success) {


      final box = GetStorage();
      String? vendorUserId = box.read('vendorUserId');
      if (vendorUserId != null) {
        await getAwards(vendorUserId);
      }

      Get.snackbar('Success', 'Award deleted successfully');
    } else {
      Get.snackbar('Error', 'Failed to delete Award');
    }
  }




Future<void> updateUserProfile(String vendorUserId, ProfileModel profileModel, ProfileController profileController, BuildContext context) async {
  ProgressDialog progressDialog = ProgressDialog(context,
      title: const Text('Updating Profile'),
      message: const Text('Please wait'));
  progressDialog.show();

  try {
    await apiService.updateUserProfile(vendorUserId, profileModel, profileController); 

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
    await apiService.updateCoverPicture(vendorUserId, imageFile,profile.value.firebaseId!, profile.value.email!);

    profile.value = ProfileModel(); 
    _isProfileLoaded = false;       

    await loadProfile(); 

    Get.snackbar('Success', 'Cover picture updated successfully');
  } catch (e) {
    Get.snackbar('Error', 'An error occurred while updating the cover picture: $e');
  } finally {
     progressDialog.dismiss();
  }
}

Future<void> updateDrivingLicense(File? front, File? back, String vendorUserId) async {
    ProgressDialog progressDialog = ProgressDialog(Get.context!,
        title: const Text('Updating License Picture'),
        message: const Text('Please wait'));
    progressDialog.show();
     try {
    await apiService.updateDrivingLicense(front, back, vendorUserId, profile.value.firebaseId!, profile.value.email!);

    profile.value = ProfileModel();
    _isProfileLoaded = false;

    await loadProfile();

    Get.snackbar('Success', 'License picture updated successfully');
  } catch (e) {
    Get.snackbar('Error', 'An error occurred while updating the cover picture: $e');
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
      print(apiUrl);
      print(response.statusCode);
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
      print(e);
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
    final newExpiration = DateTime.now().add(Duration(hours: 24));
    storage.write(expirationKey, newExpiration.toIso8601String());
    expirationDate.value = newExpiration; // This will automatically update the UI
  }

  // *********** License *****************

}
