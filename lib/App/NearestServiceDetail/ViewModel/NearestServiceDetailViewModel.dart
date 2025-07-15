
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/app_text.dart';
import '../../../constant/colors.dart';
import '../../Services/Model/ServiceDashboardModel.dart';
import '../../ServicesSearch/Service/ServicesSearch_Service.dart';

class NearestServiceDetailViewModel extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nearbyServices = Get.arguments;
    loadSubServices();
  }


  late final SellingServices nearbyServices;
  TextEditingController descriptionController = TextEditingController();
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

  RxInt? selectedServiceId = RxInt(0);
  RxList<Map<String,dynamic>> subServices = <Map<String,dynamic>>[].obs;


  Future loadSubServices()async{
    for(int id in nearbyServices.selectedSubServices??[]){
      Map<String,dynamic>? data = await ServicesSearchService().getSubService(id.toString());
      if(data != null){
        subServices.add(data);
      }
    }
  }





  Future createBidByCustomer(BuildContext context)async{
    List<String> imagesPath = [];
    for(XFile file in imageFileList){
      imagesPath.add(file.path);
    }
    if(imagesPath.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(
              title:context.local.upload_image,
              color: AppColor.white)));
      return;
    }
    if(descriptionController.text == ""){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(
              title: context.local.write_a_description,
              color: AppColor.white)));
      return;
    }
    if(selectedServiceId == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(
              title: context.local.select_a_service,
              color: AppColor.white)));
      return;
    }
    String? id =  await ServicesSearchService().createBidByCustomer(context: context, images: imagesPath, description: descriptionController.text, service: nearbyServices.service!.id.toString(), subService: selectedServiceId!.value.toString(), vendorId: nearbyServices.vendor?.id.toString());
    if(id != null){
      Get.toNamed(AppRoutes.bidViewScreen,
          arguments: {
            'id': id,
            'serviceId': nearbyServices.service!.id.toString(),
            'subServiceId': selectedServiceId!.value.toString()
          });
    }
  }



}