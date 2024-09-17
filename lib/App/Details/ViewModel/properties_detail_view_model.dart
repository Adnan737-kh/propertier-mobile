import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Details/Model/specific_property_model.dart';
import 'package:propertier/App/Details/Services/detail_services.dart';
import 'package:propertier/extensions/size_extension.dart';

class DetailsViewModel extends GetxController {
  //  RxBool _isLoading = false.obs;
  // bool get isLoading => _isLoading.value;
//   RxList<String> _videosThumbnailList = <String>[].obs;
//   List<String> get videosThumbnailList => _videosThumbnailList.value;

//   generateThumbnailImage(List<String> videoUrls) async {
//     _isLoading.value = true;
// _videosThumbnailList.clear();
//     final data = await NetWorkServcies().generateThumbnails(videosUrls: videoUrls);
//     if (data.isNotEmpty) {
//       _isLoading.value = false;
//       _videosThumbnailList.value = data;
//     } else {
//       _isLoading.value = false;
//     }
//   }
  ScrollController scrollController = ScrollController();
  final RxInt _selectedVideoIndex = 0.obs;
  int get selectedVideoIndex => _selectedVideoIndex.value;
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
  final RxBool _isCollapsed = false.obs;
  bool get isCollapsed => _isCollapsed.value;

  @override
  void onInit() {
    // TODO: implement onInit
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
      print("ISCollapsed ${_isCollapsed.value}");
    });
  }

  Rx<SpecificPropertyModel> specificPropertyModel = SpecificPropertyModel().obs;
  getSpecificPropertyDetail({required int id}) async {
    final result = await DetailServices().getDetailServices(id: id);
    specificPropertyModel.value = result;
  }
}
