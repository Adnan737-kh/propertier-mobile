import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/success_screen.dart';

class VerifyDocumentController extends GetxController {
  var incorporateDocument = Rxn<File>();
  var soleProprietorDocument = Rxn<File>();

  final ApiService apiService = ApiService();  // Create an instance of ApiService

  void setIncorporateDocument(File file) {
    incorporateDocument.value = file;
  }

  void setSoleProprietorDocument(File file) {
    soleProprietorDocument.value = file;
  }

  Future<void> sendDocuments({
    required String firebaseId,
    required String email,
    required String type,
  }) async {
    final box = GetStorage();
    String? vendorUserId = box.read('vendorUserId');

    if (vendorUserId == null) {
      Get.snackbar('Error', 'Vendor ID not found.');
      return;
    }

    if (incorporateDocument.value != null &&
        soleProprietorDocument.value != null) {
      try {
        var response = await apiService.sendDocuments(
          vendorUserId: vendorUserId,
          firebaseId: firebaseId,
          email: email,
          type: type,
          incorporateDocument: incorporateDocument.value!,
          soleProprietorDocument: soleProprietorDocument.value!,
        );

        if (response.statusCode == 200) {
          Get.snackbar('Success', 'Documents sent successfully.');
          Get.to(() => const SuccessScreen(
                text: 'Verify',
              ));
        } else {
          Get.snackbar(
              'Error', 'Failed to send documents. Reason: ${response.body}');
        }
      } catch (e) {
        print('An error occurred: $e');
        Get.snackbar('Error', 'An error occurred: $e');
      }
    } else {
      Get.snackbar('Error', 'Please select both documents before submitting.');
    }
  }
}
