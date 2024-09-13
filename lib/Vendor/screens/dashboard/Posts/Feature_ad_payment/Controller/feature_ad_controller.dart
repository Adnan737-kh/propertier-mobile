import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Vendor/screens/dashboard/Posts/Feature_ad_payment/Model/feature_ad_model.dart';

class FeaturePackageController {
  final String apiUrl = 'https://propertier-p2wwcx3okq-em.a.run.app/';

  int? featurePackageId;

  Future<void> submitFeaturePackage(Featureadd featurePackage) async {
    final url = Uri.parse('$apiUrl/services/feature-packages/');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(featurePackage.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Feature package submitted successfully: ${response.body}');

        final responseData = jsonDecode(response.body);
        featurePackageId = responseData['id'];

        print('Feature package ID stored: $featurePackageId');
        Get.snackbar('Sucess', 'Feature selected sucessfully');

        final box = GetStorage();
        box.write('featurePackageId', featurePackageId);
      } else {
        print(
            'Failed to submit feature package: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error submitting feature package: $e');
    }
  }
}
