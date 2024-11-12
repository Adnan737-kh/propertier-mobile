import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../Network/api_urls.dart';
import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/app_text.dart';
import '../../../constant/colors.dart';
import '../../Services/Model/ServiceDashboardModel.dart';
import '../../ServicesSearch/Service/ServicesSearch_Service.dart';
import '../../ServicesSearch/model/VendorResponseModel.dart';

class NearestServiceDetailViewModel extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nearbyServices = Get.arguments;
    loadSubServices();
  }


  late final NearbyServices nearbyServices;
  TextEditingController descriptionController = TextEditingController();
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

  RxInt? selectedServiceId = RxInt(0);
  RxList<Map<String,dynamic>> subServices = <Map<String,dynamic>>[].obs;


  Future loadSubServices()async{
    for(int id in nearbyServices.selectedSubServices??[]){
      Map<String,dynamic>? data = await ServicessearchService().getSubService(id.toString());
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
          content: appText(
              title: 'Upload images',
              context: context,
              color: AppColor.white)));
      return;
    }
    if(descriptionController.text == ""){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: 'Write a description.',
              context: context,
              color: AppColor.white)));
      return;
    }
    if(selectedServiceId == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: 'Select a service',
              context: context,
              color: AppColor.white)));
      return;
    }
    String? id =  await ServicessearchService().createBidByCustomer(context: context, images: imagesPath, description: descriptionController.text, service: nearbyServices.service!.id.toString(), subService: selectedServiceId!.value.toString(), vendorId: nearbyServices.vendor?.id.toString());
    if(id != null){
      Get.toNamed(AppRoutes.BidViewScreen,
          arguments: {
            'id': id,
            'serviceId': nearbyServices.service!.id.toString(),
            'subServiceId': selectedServiceId!.value.toString()
          });
    }
  }



}