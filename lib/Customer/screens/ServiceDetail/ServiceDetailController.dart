import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';
import 'package:propertier/extensions/size_extension.dart';


class ServiceDetailController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    service = Get.arguments;
    checkScroll();
  }

  late FixedServicesModel service;
  ScrollController scrollController = ScrollController();
  final RxBool _isCollapsed = false.obs;
  bool get isCollapsed => _isCollapsed.value;

  checkScroll() {
    scrollController.addListener(() {
      _isCollapsed.value = scrollController.offset >
          (Platform.isAndroid
              ? Get.context!.getSize.height * (0.36 - 0.030)
              : Get.context!.getSize.height * (0.31 - 0.030) -
              Get.context!.getSize.height * 0.07);
      if (kDebugMode) {
        print("ISCollapsed ${_isCollapsed.value}");
      }
    });
  }

  final RxInt _selectedVideoIndex = 0.obs;
  int get selectedVideoIndex => _selectedVideoIndex.value;
  changeVideoIndex(int index) {
    _selectedVideoIndex.value = index;
  }
}