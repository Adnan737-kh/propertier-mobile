import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/colors.dart';
import '../view_model/face_recognition_view_model.dart';

class FaceRecognitionView extends StatelessWidget {
  final FaceRecognitionController faceRecognitionController =
  Get.put(FaceRecognitionController());

  FaceRecognitionView({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Face Recognition"),
        backgroundColor: AppColor.forGroundColor,
      ),
      body: Obx(() {
        if (!faceRecognitionController.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            faceRecognitionController.capturedImagePath.value.isEmpty
                ? Expanded(
              child:
              CameraPreview(faceRecognitionController.cameraController!),
            )
                : Expanded(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.file(
                    File(faceRecognitionController.capturedImagePath.value),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons Section
            if (faceRecognitionController.capturedImagePath.value.isEmpty) ...[
              ElevatedButton.icon(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColor.forGroundColor)

                ),
                icon: const Icon(Icons.camera_alt),
                label: const Text("Capture"),
                onPressed: () {
                  faceRecognitionController.captureImage();
                },
              ),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(

                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppColor.forGroundColor)
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retake",),
                    onPressed: () {
                      faceRecognitionController.capturedImagePath.value = '';
                    },
                  ),
                  Obx(() => ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColor.forGroundColor)

                    ),
                    icon: faceRecognitionController.isLoading.value
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Icon(Icons.check),
                    label: Text(
                      faceRecognitionController.isLoading.value ? "Loading..." : "Submit",
                    ),
                    onPressed: faceRecognitionController.isLoading.value
                        ? null // Disable while loading
                        : () async {
                      if (kDebugMode) {
                        print("FaceVerification access token ${faceRecognitionController.accessToken}");
                        print("picked image ${faceRecognitionController.capturedImagePath}");
                      }

                      await faceRecognitionController.verifyFace(
                        File(faceRecognitionController.capturedImagePath.value),
                        faceRecognitionController.accessToken!,
                      );
                    },
                  ))

                ],
              ),
            ],
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }
}
