import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../repository/profile_repo/profile_update/profile_updat_repo.dart';
import '../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class FaceRecognitionController extends GetxController {
  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  RxString capturedImagePath = ''.obs;
  UserPreference userPreference = UserPreference();
  String? _accessToken;
  String? get accessToken => _accessToken;

  @override
  void onInit() {
    userPreference.getUserAccessToken().then((value) async {
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        _accessToken = value.accessToken;
      }
    });
    requestPermissions();
    super.onInit();
  }

  final ProfileUpdateRepository _repo = ProfileUpdateRepository();
  RxBool isLoading = false.obs;

  Future<void> verifyFace(File? faceImage, String accessToken) async {
    if (faceImage == null) {
      Get.snackbar("Warning", "Please Take a Selfie where your face is clearly visible");
      return;
    }

    isLoading.value = true;

    try {
      final result = await _repo.faceVerification(faceImage, accessToken);

      if (result != null) {
        final statusCode = result['statusCode'];
        final responseBody = result['body'];

        if (statusCode == 201) {
          // ✅ Success - Navigate to next screen
          Get.snackbar("Success", "User verification successful!");
          Get.toNamed(AppRoutes.verificationView);
        } else {
          try {
            final decoded = jsonDecode(responseBody);
            if (decoded is Map && decoded.containsKey('detail')) {
              Get.snackbar("Error", decoded['detail'].toString());
              Get.toNamed(AppRoutes.verificationView);

            } else {
              Get.snackbar("Error", "User verification failed.");
            }
          } catch (_) {
            Get.snackbar("Error", "Unexpected error. Please try again.");
          }
        }
      } else {
        Get.snackbar("Error", "User verification failed.");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }


  // Request camera permission
  Future<void> requestPermissions() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      initializeCamera();
    } else {
      Get.snackbar("Permission Denied", "Camera access is required");
    }
  }

  // Initialize camera
  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraController = CameraController(cameras[1], ResolutionPreset.medium);
      await cameraController!.initialize();
      isCameraInitialized.value = true;
    } else {
      Get.snackbar("Error", "No camera found!");
    }
  }

  // Capture Image Function
  Future<void> captureImage() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      Get.snackbar("Error", "Camera is not initialized");
      return;
    }

    try {
      final XFile image = await cameraController!.takePicture();
      capturedImagePath.value = image.path;
    } catch (e) {
      Get.snackbar("Capture Error", e.toString());
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
