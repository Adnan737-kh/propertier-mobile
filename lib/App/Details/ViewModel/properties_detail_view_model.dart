import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Details/Model/specific_property_model.dart';
import 'package:propertier/App/Details/Services/detail_services.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../repository/property_repo/view_property_details/view_property_details_repo.dart';

class DetailsViewModel extends GetxController {

  ScrollController scrollController = ScrollController();
  final RxInt _selectedVideoIndex = 0.obs;
  int get selectedVideoIndex => _selectedVideoIndex.value;
  final RxBool _isCollapsed = false.obs;
  bool get isCollapsed => _isCollapsed.value;
  ViewPropertyDetailsRepository  viewPropertyDetailsRepository =ViewPropertyDetailsRepository();

  changeVideoIndex(int index) {
    _selectedVideoIndex.value = index;
  }

  List<String> otherFeaturesList = <String>[
    "Secuirty Door",
    "Window Conditioning",
    "Swimming Pool",
    "Laundry Room",
    "Fire Safty",
    "Gym",
    "Air Conditioning",
    "Garden",
  ];

  @override
  void onInit() {
    super.onInit();

    checkScroll();
  }

  checkScroll() {
    scrollController.addListener(() {
      _isCollapsed.value = scrollController.offset >
          (Platform.isAndroid
              ? Get.context!.getSize.height * (0.36 - 0.030)
              : Get.context!.getSize.height * (0.31 - 0.030) -
                  Get.context!.getSize.height * 0.07);
    });
  }

  Rx<SpecificPropertyModel> specificPropertyModel = SpecificPropertyModel().obs;
  getSpecificPropertyDetail({required String slug}) async {
    if (kDebugMode) {
      print('Specific ID: $slug');
    }
    final result = await DetailServices().getDetailServices(slug: slug);
    specificPropertyModel.value = result;
  }
}
