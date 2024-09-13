import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Model/detail_model.dart';
import 'package:propertier/NetworkServices/network_services.dart';

class VideoDetailViewModel extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final RxList<String> _videosThumbnailList = <String>[].obs;
  List<String> get videosThumbnailList => _videosThumbnailList.value;

  final RxInt _selectedVideoIndex = 0.obs;
  int get selectedVideoIndex => _selectedVideoIndex.value;
  changeVideoIndex(int index) {
    _selectedVideoIndex.value = index;
  }
}
