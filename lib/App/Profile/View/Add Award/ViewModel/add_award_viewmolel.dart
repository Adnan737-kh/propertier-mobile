import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../services/add_award_services.dart';

class AddAwardViewModel extends GetxController {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late File image;
  final Rx<String?> selectedDate = Rx(null);
  RxString selectedStringDate = ''.obs;
  UserPreference userPreference = UserPreference();
  String? _accessToken;
  String? get accessToken => _accessToken;

  Future<void> chooseDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      selectedStringDate.value = pickedDate.toString();
      selectedDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    userPreference.getUserAccessToken().then((value) async {
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        _accessToken = value.accessToken;
        if (kDebugMode) {
          print('Add Award Access Token  !!! ${value.accessToken}');
        }

      }
    });
    super.onInit();
  }

  final RxBool _isSuccess = true.obs;
  bool get isSuccess => _isSuccess.value;

  Future<void> postAward(
      {required String accessToken,
      required String title,
      required String description,
      required String date,
      required File imageData,
      required BuildContext context}) async {
    _isSuccess.value = false;
    final result = await AddAwardServices().addAward(
        accessToken: accessToken,
        context: context,
        description: description,
        title: title,
        date: date,
        image: imageData);
    if (result == true) {
      _isSuccess.value = true;
      Get.back();
    } else {
      _isSuccess.value = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
