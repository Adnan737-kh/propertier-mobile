import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController newpasswordController = TextEditingController();
  TextEditingController renewpasswordController = TextEditingController();

  var isShowPassword = false.obs;
  var isShowConfirmPassword = false.obs;

  @override
  void dispose() {
    // TODO: implement dispose
    newpasswordController.dispose();
    renewpasswordController.dispose();
    super.dispose();
  }
}
