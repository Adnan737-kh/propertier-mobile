import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketPlacePaymentViewModel extends GetxController {
  final mPPformKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  TextEditingController depositPercentageController = TextEditingController();
  TextEditingController currentBalanceController = TextEditingController();

  @override
  void onClose() {
    amountController.dispose();
    depositPercentageController.dispose();
    currentBalanceController.dispose();
    super.onClose();
  }
}
