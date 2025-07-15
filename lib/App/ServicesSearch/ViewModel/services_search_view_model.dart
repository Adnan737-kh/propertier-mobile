import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/App/ServicesSearch/Service/ServicesSearch_Service.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/app_text.dart';
import '../../../constant/colors.dart';
import '../../Services/Model/services_model.dart';

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
    final selectedImages =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImages != null) {
      if (isAlsoPicked == true) {
        imageFileList[index] = selectedImages;
      } else {
        imageFileList.add(selectedImages);
      }
    }
    if (kDebugMode) {
      print("Length ${imageFileList.length}");
    }
  }

  Future createBidByCustomer(BuildContext context,ParentServicesModel parentServicesModel, Subservices subservices)async{
    List<String> imagesPath = [];
    for(XFile file in imageFileList){
      imagesPath.add(file.path);
    }
    if(imagesPath.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: CustomText(
              title: 'Upload images',
              color: AppColor.white)));
      return;
    }
    if(descriptionController.text == ""){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: CustomText(
              title: 'Write a description.',
              color: AppColor.white)));
      return;
    }
    String? id =  await ServicesSearchService().createBidByCustomer(context: context, images: imagesPath, description: descriptionController.text, service: parentServicesModel.id.toString(), subService: subservices.id.toString());
    if(id != null){
      Get.toNamed(AppRoutes.servicesSearch2View,
          arguments: {
            'id': id,
            'parentServicesModel': parentServicesModel,
            'subServices': subservices
          });
    }
  }
}
