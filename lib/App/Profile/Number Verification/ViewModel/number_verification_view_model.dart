import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberVerficationViewModel extends GetxController {
  final emailController = TextEditingController();
  final emailformKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }
}
