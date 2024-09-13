import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ServicesReviewViewModel extends GetxController {
  final RxInt _selectedsatisfiedWorkIndex = (-1).obs;
  int get selectedsatisfiedWorkIndex => _selectedsatisfiedWorkIndex.value;
  changeSelectedselectedsatisfiedWorkIndex(int index) {
    _selectedsatisfiedWorkIndex.value = index;
  }

  final RxInt _workFromVandorIndex = (-1).obs;
  int get workFromVandorIndex => _workFromVandorIndex.value;
  changeWorkFromVandorIndex(int index) {
    _workFromVandorIndex.value = index;
  }

  TextEditingController servicesReviewCommentController =
      TextEditingController();
}
