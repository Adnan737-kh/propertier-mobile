
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/add_post_model.dart';

import '../../../profile/controller/profile_controller.dart';



  class PostController {
  final ApiService apiService = ApiService(); // Initialize ApiService

  Future<void> addPost(
    AddPostModel postModel,
    List<File> selectedImage,
    File? selectedVideo,
  ) async {
    final vendorid = GetStorage();
    String? vendorUserId = vendorid.read('vendorUserId');

    if (vendorUserId == null) {
      print('Vendor ID could not be retrieved.');
      return;
    }

    if (selectedImage.isEmpty) {
      print("Error: No image selected");
      return;
    }

    final box = GetStorage();
    final featurePackageId = box.read('featurePackageId');

    if (featurePackageId != null) {
      // Call API for post with feature package
      await apiService.postWithFeaturePackage(
        postModel,
        selectedImage,
        selectedVideo,
        vendorUserId,
        featurePackageId.toString()
      );
    } else {
      // Call API for post without feature package
      await apiService.postWithoutFeaturePackage(
        postModel,
        selectedImage,
        selectedVideo,
        vendorUserId,
      );
    }
  }
}
