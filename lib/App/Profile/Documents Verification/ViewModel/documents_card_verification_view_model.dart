import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';

class DocumentsVerficationViewModel extends GetxController {
  final emailController = TextEditingController();
  final emailformKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
