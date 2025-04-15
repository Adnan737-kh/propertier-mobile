import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_model/face_recognition_view_model.dart';

class FaceRecognitionView extends StatelessWidget {
  final FaceRecognitionController faceRecognitionController =
      Get.put(FaceRecognitionController());

  FaceRecognitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KYC - Capture Face")),
      body: Obx(() {
        if (!faceRecognitionController.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // Camera Preview
            Expanded(
              child: CameraPreview(faceRecognitionController.cameraController!),
            ),

            // Captured Image Preview
            faceRecognitionController.capturedImagePath.value.isEmpty
                ? Container()
                : Image.file(
                    File(faceRecognitionController.capturedImagePath.value),
                    height: 200,
                  ),

            const SizedBox(height: 10),

            // Capture Button
            ElevatedButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text("Capture"),
              onPressed: () {
                faceRecognitionController.captureImage();
              },
            ),
          ],
        );
      }),
    );
  }
}
