import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerficationViewModel extends GetxController {
  final usernameController = TextEditingController();
  final userNumberController = TextEditingController();
  final userFullNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isShowPassword = false.obs;
  var isShowConfirmPassword = false.obs;
  var isName = false.obs;
  var isEmail = false.obs;
  var isPhone = false.obs;
  var isAddress = false.obs;

  RxBool isKeyboard = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    userFullNameController.dispose();
    userNumberController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
