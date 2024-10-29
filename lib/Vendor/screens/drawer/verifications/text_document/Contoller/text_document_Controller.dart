import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/success_screen.dart';

class VerifyDocumentController extends GetxController {
  var incorporateDocument = Rxn<File>();
  var soleProprietorDocument = Rxn<File>();

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
      var apiUrl =
          '${API.baseURL}/accounts/vendors/$vendorUserId/';
      var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));

      request.fields['firebase_id'] = firebaseId;
      request.fields['email'] = email;
      request.fields['type'] = type;

      request.files.add(await http.MultipartFile.fromPath(
          'incorporate_document', incorporateDocument.value!.path));
      request.files.add(await http.MultipartFile.fromPath(
          'sole_propertiier_document', soleProprietorDocument.value!.path));

      try {
        print(
            'Sending API request to $apiUrl with fields $firebaseId, $email, $type');

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        // print('Received response with status: ${response.statusCode} and body: ${response.body}');

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
