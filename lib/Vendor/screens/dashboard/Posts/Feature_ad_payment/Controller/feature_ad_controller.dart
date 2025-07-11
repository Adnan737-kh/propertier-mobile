import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/Feature_ad_payment/Model/feature_ad_model.dart';


class FeaturePackageController extends GetxController {
  final ApiService apiService = ApiService(); // Use the ApiService

  int? featurePackageId;

  Future<void> submitFeaturePackage(Featureadd featurePackage) async {

    final featurePackageJson = featurePackage.toJson();

    final packageId = await apiService.submitFeaturePackage(featurePackageJson);

    if (packageId != null) {
      featurePackageId = packageId;
      if (kDebugMode) {
        print('Feature package ID stored: $featurePackageId');
      }
      Get.snackbar('Success', 'Feature selected successfully');

      final box = GetStorage();
      box.write('featurePackageId', featurePackageId);
    } else {
      Get.snackbar('Error', 'Failed to select feature package');
    }
  }
}
