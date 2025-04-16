import 'dart:io';
import 'package:get/get.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../repository/profile_repo/profile_update/profile_updat_repo.dart';
import '../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class IDVerficationViewModel extends GetxController {
  UserPreference userPreference = UserPreference();
  String? _accessToken;
  String? get accessToken => _accessToken;

  @override
  void onInit() async {
    userPreference.getUserAccessToken().then((value) async {
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        _accessToken = value.accessToken;
      }
    });
    super.onInit();
  }

  RxBool isUploading = false.obs;
  final ProfileUpdateRepository _repo = ProfileUpdateRepository();

  Future<void> verifyIdCard(
      File? frontImage, File? backImage, String accessToken) async {
    if (frontImage == null || backImage == null) {
      Get.snackbar("Error", "Please select both images");
      return;
    }

    try {
      isUploading.value = true;

      dynamic response =
          await _repo.idCardVerification(frontImage, backImage, accessToken);

      if (response != null && response["statusCode"] == 201) {
        Get.toNamed(AppRoutes.verificationView);
        Get.snackbar("Success", "Card Verification submited!");
      } else {
        Get.snackbar("Error", "User verification failed.");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isUploading.value = false;
    }
  }
}
