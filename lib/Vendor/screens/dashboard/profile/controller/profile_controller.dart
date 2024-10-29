import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/dashboard/fearture_ads/Model/feature_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/award_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile_model.dart';

class ProfileController extends GetxController {
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
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${API.baseURL}/services/vendor-awards/'),
      );
      request.fields['vendor_id'] = awardModel.vendorId;

      // Add the image file to the request if available
      if (awardModel.imagePath.isNotEmpty) {
        var imageFile = File(awardModel.imagePath);
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imageFile.path,
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Award added successfully');

        final box = GetStorage();
        String? vendorUserId = box.read('vendorUserId');

        await getAwards(vendorUserId!); // Refresh the awards
        isImageAdded = true; // Set isImageAdded to true after adding the image
        update(); // Update the state after adding the image
      } else {
        Get.snackbar(
            'Error', 'Failed to add service. ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadProfile() async {
    if (_isProfileLoaded) return; // Return if profile is already loaded

    String? vendorUserId = (await ApiService().getVendorUserId());

    if (vendorUserId != null) {
      try {
        ProfileModel profile = await ApiService().fetchProfile(vendorUserId);
        this.profile.value = profile;
        _isProfileLoaded = true; // Set the flag to true once profile is loaded

        print('Profile loaded: ${profile.toJson()}');
      } catch (e) {
        print('Error loading profile: $e');
      }
    } else {
      print('Vendor user ID not found');
    }
  }

  Future<void> updateUseProfile(String vendorUserId, ProfileModel profileModel,
      BuildContext context) async {
    String? token = await getIdToken();

    if (token == null) {
      print('Id is null. Cannot proceed with the request.');
      Get.snackbar('Error', 'Id is null. Cannot proceed with the request.');
      return;
    }

    ProgressDialog progressDialog = ProgressDialog(context,
        title: const Text('Signing Up'), message: const Text('Please wait'));
    progressDialog.show();
    try {
      var response = await http.put(
        Uri.parse(
            '${API.baseURL}/accounts/vendors/$vendorUserId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(profileModel.toJson()),
      );
      print(
          '${API.baseURL}/accounts/vendors/$vendorUserId');
      if (response.statusCode == 200) {
        profile(profileModel);
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update profile: ${response.body}');
        print(response.body);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print(e);
    } finally {
      progressDialog.dismiss();
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

  //
  //

  Future<void> getFeaturedServices(String vendorUserId,
      {bool forceRefresh = false}) async {
    // Check if data should be refreshed or cached data can be used
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

//
//
  Future<void> updateUserProfile(String vendorUserId, ProfileModel profileModel,
      BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        title: const Text('Updating Profile'),
        message: const Text('Please wait'));
    progressDialog.show();

    try {
      // Ensure all required fields are populated
      if (profileModel.firebaseId == null ||
          profileModel.email == null ||
          profileModel.type == null) {
        Get.snackbar('Error', 'Missing required fields');
        print('Error: Missing required fields');
        print('firebase_id: ${profileModel.firebaseId}');
        print('email: ${profileModel.email}');
        print('type: ${profileModel.type}');
        print('vendorUserId: $vendorUserId');
        return;
      }

      // Print values to debug
      print('firebase_id: ${profileModel.firebaseId}');
      print('email: ${profileModel.email}');
      print('type: ${profileModel.type}');
      print('vendorUserId: $vendorUserId');

      // Create a multipart request
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            '${API.baseURL}/accounts/vendors/$vendorUserId'),
      )
        ..fields['firebase_id'] = profileModel.firebaseId!
        ..fields['email'] = profileModel.email!
        ..fields['type'] = profileModel.type!;

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Print response status and body
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        profile(profileModel);
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Error',
            'Failed to update profile. Status: ${response.statusCode}');
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
      print('Exception: $e');
    } finally {
      progressDialog.dismiss();
    }
  }

  Future<void> updateProfilePicture(File imageFile) async {
    ProgressDialog progressDialog = ProgressDialog(Get.context!,
        title: const Text('Updating Profile Picture'),
        message: const Text('Please wait'));
    progressDialog.show();
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            '${API.baseURL}//accounts/vendors'),
      )..files.add(
          await http.MultipartFile.fromPath('profile_picture', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful response
        Get.snackbar('Success', 'Profile picture updated successfully');
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

  Future<void> updateCoverPicture(File imageFile) async {
    ProgressDialog progressDialog = ProgressDialog(Get.context!,
        title: const Text('Updating Cover Picture'),
        message: const Text('Please wait'));
    progressDialog.show();
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            '${API.baseURL}//accounts/vendors'),
      )..files.add(
          await http.MultipartFile.fromPath('cover_photo', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful response
        Get.snackbar('Success', 'Cover picture updated successfully');
        loadProfile(); // Reload the profile to update the image
      } else {
        Get.snackbar('Error', 'Failed to update cover picture');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print(e);
    } finally {
      progressDialog.dismiss();
    }
  }
}
