import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditCardMethodViewModel extends GetxController {
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController nameOnCard = TextEditingController();
  final TextEditingController expirationData = TextEditingController();
  final TextEditingController cVV = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    cardNumber.dispose();
    nameOnCard.dispose();
    expirationData.dispose();
    cVV.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
