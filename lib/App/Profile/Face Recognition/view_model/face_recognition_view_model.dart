import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceRecognitionController extends GetxController {
  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  RxString capturedImagePath = ''.obs;

  @override
  void onInit() {
    requestPermissions();
    super.onInit();
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
