import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/success_screen.dart';

class DocumentController extends GetxController {
  var isLoading = false.obs;
  File? frontImage;
  ProfileController awardController = Get.put(ProfileController());
  final picker = ImagePicker();
  final ApiService apiService = ApiService();  // Create an instance of ApiService

  Future<void> pickImage(ImageSource source, bool isFront) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      if (isFront) {
        frontImage = File(pickedFile.path);
      }
    }
  }

  Future<void> updateCnic(File cnicFront, File cnicBack, String vendorUserId,
      String firebaseId, String email, String type) async {
    try {
      var response = await apiService.uploadCnicDocument(
        cnicFront, cnicBack, vendorUserId, firebaseId, email, type);  // Use ApiService

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'CNIC picture updated successfully');
        Get.to(() => const SuccessScreen(
              text: 'Verify',
            ));
      } else {
        Get.snackbar('Error', 'Failed to update CNIC picture');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print(e);
    }
  }

  Future<void> updateDocument(File file, String documentType,
      String vendorUserId, String firebaseId, String email, String type) async {
    ProgressDialog progressDialog = ProgressDialog(Get.context!,
        title: null, message: const Text('Please wait'));
    progressDialog.show();

    try {
      var response = await apiService.uploadDocument(
        file, documentType, vendorUserId, firebaseId, email, type);  // Use ApiService

      if (response.statusCode == 200) {
        Get.snackbar('Success', '$documentType updated successfully');
        awardController.loadProfile();
      } else {
        Get.snackbar('Error', 'Failed to update $documentType');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print(e);
    } finally {
      progressDialog.dismiss();
    }
  }

  Future<void> updateIncorporationDocument(
    File incorporation,
    String vendorUserId,
    String firebaseId,
    String email,
    String type,
  ) async {
    await updateDocument(
      incorporation,
      'certificate_of_incorporation',
      vendorUserId,
      firebaseId,
      email,
      type,
    );
  }

  Future<void> updateAssociationDocument(
    File association,
    String vendorUserId,
    String firebaseId,
    String email,
    String type,
  ) async {
    await updateDocument(
      association,
      'artificial_of_association',
      vendorUserId,
      firebaseId,
      email,
      type,
    );
  }

  Future<void> updateMemberofAssociation(
    File association,
    String vendorUserId,
    String firebaseId,
    String email,
    String type,
  ) async {
    await updateDocument(
      association,
      'member_of_association',
      vendorUserId,
      firebaseId,
      email,
      type,
    );
  }
}
