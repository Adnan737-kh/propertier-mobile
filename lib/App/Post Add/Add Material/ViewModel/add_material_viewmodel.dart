import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMaterialViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    unitsController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
