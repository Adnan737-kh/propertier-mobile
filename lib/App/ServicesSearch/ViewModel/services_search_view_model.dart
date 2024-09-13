import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ServicesSearhViewModel extends GetxController {
  TextEditingController searchController = TextEditingController();
  TextEditingController yourSelfController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> tabsList = <String>[
    'taps',
    'Automatic Washing Maching',
    'Geysers',
    'Renovation',
  ];
  final RxInt _selectedTabIndex = 0.obs;
  int get selectedTabIndex => _selectedTabIndex.value;
  onChangeTab(int index) {
    _selectedTabIndex.value = index;
  }

  final ImagePicker imagePicker = ImagePicker();
  RxList<XFile> imageFileList = <XFile>[].obs;
  void selectedImage(bool isAlsoPicked, int index) async {
    final selectedimges =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedimges != null) {
      if (isAlsoPicked == true) {
        imageFileList[index] = selectedimges;
      } else {
        imageFileList.add(selectedimges);
      }
    }
    print("Length ${imageFileList.length}");
  }
}
