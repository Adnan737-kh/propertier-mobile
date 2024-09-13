
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/add_post_model.dart';
import 'package:propertier/Vendor/screens/dashboard/dashboard.dart';

class PostController {
  final String apiUrl = 'https://propertier-p2wwcx3okq-em.a.run.app/';

  Future<void> addPost(
    AddPostModel postModel,
    File? selectedImage,
    File? selectedVideo,
  ) async {
    print("Fetching vendor ID...");
    final vendorid = GetStorage();
    String? vendorUserId = vendorid.read('vendorUserId');

    if (vendorUserId == null) {
      print('Vendor ID could not be retrieved.');
      return;
    }

    print('Vendor ID retrieved: $vendorUserId');

    if (selectedImage == null) {
      print("Error: No image seeeelected");
      return;
    }

    final box = GetStorage();
    final featurePackageId = box.read('featurePackageId');

    if (featurePackageId != null) {
      print('Feature package ID found: $featurePackageId');
      // Call API for post with feature package
      await _postWithFeaturePackage(
        postModel,
        selectedImage,
        selectedVideo,
        vendorUserId,
      );
    } else {
      print('No feature package ID found in storage.');
      // Call API for post without feature package
      await _postWithoutFeaturePackage(
        postModel,
        selectedImage,
        selectedVideo,
        vendorUserId,
      );
    }
  }

  Future<void> _postWithFeaturePackage(
    AddPostModel postModel,
    File selectedImage,
    File? selectedVideo,
    String vendorUserId,
  ) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/services/vendor-services/'),
      );

      request.fields['vendor_id'] = vendorUserId;
      request.fields['service_id'] = postModel.serviceId;
      request.fields['title'] = postModel.title;
      request.fields['visiting_charges'] = postModel.visitingCharges;
      request.fields['fixed_price'] = postModel.fixedPrice;

      for (var service in postModel.selectedSubServices) {
        request.fields['selected_sub_services'] = service;
      }

      request.files.add(await http.MultipartFile.fromPath(
        'images',
        selectedImage.path,
      ));

      if (selectedVideo != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'short_video',
          selectedVideo.path,
        ));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Post added successfully');

        var responseData = jsonDecode(responseBody);
        var vendorServiceId = responseData['id'].toString();

        print('Vendor Service ID: $vendorServiceId');

        final box = GetStorage();
        final featurePackageId = box.read('featurePackageId');

        if (featurePackageId != null) {
          await _callNewApi(
              vendorServiceId, featurePackageId.toString(), selectedImage.path);
        } else {
          print('No feature package ID found in storage.');
          Get.back();
        }
      } else {
        print('Failed to add post');
        print('Response status: ${response.statusCode}');
        print('Response body: $responseBody');

        Get.back();
        Get.snackbar(
            'Error', 'You have already added a post in this category.');
      }
    } catch (e) {
      print("Error: $e");
      Get.back();
      Get.snackbar('Error', 'An error occurred');
    }
  }

  Future<void> _callNewApi(String vendorServiceId, String featurePackageId,
      String coverImagePath) async {
    try {
      var newRequest = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/services/featured-services/'),
      );
      newRequest.fields['vendor_service_id'] = vendorServiceId;
      newRequest.fields['feature_package_id'] = featurePackageId;

      var coverImageFile =
          await http.MultipartFile.fromPath('cover_image', coverImagePath);
      newRequest.files.add(coverImageFile);

      var newResponse = await newRequest.send();
      var responseBody = await newResponse.stream.bytesToString();

      if (newResponse.statusCode == 200 || newResponse.statusCode == 201) {
        Get.snackbar('Success', 'Post added successfully');

        final box = GetStorage();
        box.remove('featurePackageId');
        print('Feature package ID removed from local storage');

        Get.back();
        Get.offAll(() => const Dashboard());
        Get.snackbar('Success', 'Post added successfully');
      } else {
        print('Failed to call the new API');
        print('Response status: ${newResponse.statusCode}');
        print('Response body: $responseBody');

        Get.back();
        Get.snackbar('Error', '');
      }
    } catch (e) {
      // Catch any exception and close loading dialog
      print("Error calling the new API: $e");
      Get.back();
      Get.snackbar('Error', 'An error occurred while processing the request');
    }
  }

  Future<void> _postWithoutFeaturePackage(
    AddPostModel postModel,
    File selectedImage,
    File? selectedVideo,
    String vendorUserId,
  ) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/services/vendor-services/'),
      );

      request.fields['vendor_id'] = vendorUserId;
      request.fields['service_id'] = postModel.serviceId;
      request.fields['title'] = postModel.title;
      request.fields['visiting_charges'] = postModel.visitingCharges;
      request.fields['fixed_price'] = postModel.fixedPrice;

      for (var service in postModel.selectedSubServices) {
        request.fields['selected_sub_services'] = service;
      }

      request.files.add(await http.MultipartFile.fromPath(
        'images',
        selectedImage.path,
      ));

      if (selectedVideo != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'short_video',
          selectedVideo.path,
        ));
      }

      print("Request fields: ${request.fields}");
      print("Request files: ${request.files}");

      var response = await request.send();

      Get.back();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Post added successfully without feature package');
        Get.snackbar('Success', 'Post added successfully');

        // Navigate to Dashboard after saving the post
        Get.offAll(() => const Dashboard());
      } else {
        print('Failed to add post without feature package');
        print('Response status: ${response.statusCode}');
        print('Response body: ${await response.stream.bytesToString()}');

        Get.snackbar(
            'Error', 'You have already added a post in this category.');
      }
    } catch (e) {
      // Close the loading dialog in case of an error
      Get.back();
      print("Error: $e");
      Get.snackbar('Error', 'An error occurred while adding the post');
    }
  }
}
