import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/success_screen.dart';

import '../../../../dashboard/profile/controller/profile_controller.dart';

class DocumentController extends GetxController {
  var isLoading = false.obs;
  File? frontImage;
  ProfileController awardController = Get.put(ProfileController());
  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source, bool isFront) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      if (isFront) {
        frontImage = File(pickedFile.path);
      } else {
        // backImage = File(pickedFile.path);
      }
    }
  }
  // void pickImage(ImageSource source, bool isFront) async {
  //   final pickedFile = await _picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     if (isFront) {
  //       cnicFront = File(pickedFile.path);
  //     } else {
  //       // cnicBack = File(pickedFile.path);
  //     }
  //     update();
  //   }
  // }

  // void pickImage(ImageSource source, bool isFront) async {
  //   final pickedFile = await _picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     if (isFront) {
  //       cnicFront = File(pickedFile.path);
  //     }
  //     update();
  //   }
  // }

  // void uploadImages() async {
  //   if (cnicFront == null) {
  //     Get.snackbar('Error', 'Please select both images');
  //     return;
  //   }
  //   isLoading.value = true;
  //   ApiService apiService = ApiService();
  //   bool success = await apiService.uploadCnicImages(cnicFront!);
  //   isLoading.value = false;

  //   if (success) {
  //     Get.snackbar('Success', 'Images uploaded successfully');
  //     Get.to(() => const SuccessScreen(
  //           text: 'ID Card Verification',
  //         ));
  //   } else {
  //     Get.snackbar('Error', 'Failed to upload images');
  //   }
  // }

  //
  //

  // Future<void> updateCnicPicture(File cnicFront) async {
  //   ProgressDialog progressDialog = ProgressDialog(Get.context!,
  //       title: null, message: const Text('Please wait'));
  //   progressDialog.show();
  //   try {
  //     var request = http.MultipartRequest(
  //       'PUT',
  //       Uri.parse(
  //           '${Api.baseUrl}//accounts/vendors/${13}/'),
  //     )..files.add(await http.MultipartFile.fromPath(
  //         AwardController.profile.value.cnicFrontUrl.toString(),
  //         cnicFront.path));

  //     var response = await request.send();
  //     print(response);
  //     if (response.statusCode == 200) {
  //       // Handle successful response
  //       Get.snackbar('Success', 'Cnic front picture updated successfully');
  //       Get.to(() => SuccessScreen(text: 'ID Card Verification'));
  //       awardController.loadProfile(); // Reload the profile to update the image
  //     } else {
  //       Get.snackbar('Error', 'Failed to update cnic picture');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'An error occurred: $e');
  //     print(e);
  //   } finally {
  //     progressDialog.dismiss();
  //   }
  // }
  // //

  Future<void> updateCnic(File cnicFront, File cnicBack, String vendorUserId,
      String firebaseId, String email, String type) async {
    try {
      var request = http.MultipartRequest(
          'PUT',
          Uri.parse(
              '${API.baseURL}/accounts/vendors/$vendorUserId/'))
        ..fields['firebase_id'] = firebaseId
        ..fields['email'] = email
        ..fields['type'] = type
        ..files.add(
            await http.MultipartFile.fromPath('cnic_front', cnicFront.path))
        ..files
            .add(await http.MultipartFile.fromPath('cnic_back', cnicBack.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

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
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            '${API.baseURL}/accounts/vendors/$vendorUserId/'),
      )
        ..fields['firebase_id'] = firebaseId
        ..fields['email'] = email
        ..fields['type'] = type
        ..files.add(await http.MultipartFile.fromPath(documentType, file.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

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
