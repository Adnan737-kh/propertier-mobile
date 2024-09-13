import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankPaymentMethodViewModel extends GetxController {
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController cNiCNo = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    accountNumber.dispose();
    cNiCNo.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
