import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:propertier/App/MyServiceOrder/Model/ServiceOrderModel.dart';

import '../../../Utils/app_text.dart';
import '../../../constant/colors.dart';
import '../Services/ServiceOrderService.dart';

class OrderViewModel extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVendorOrders(GetStorage().read('id').toString());
  }



  RxList<ServiceOrderModel> orders = <ServiceOrderModel>[].obs;

  Future getVendorOrders(String id)async{
    orders.value = await ServiceOrderService().getVendorOrders(id)??[];
  }

  Future<Map<String,dynamic>?> getSubService(String id)async{
    return await ServiceOrderService().getSubService(id);
  }



  TextEditingController descriptionController = TextEditingController();
  TextEditingController extraPriceC = TextEditingController();

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


  void acceptSubmition(BuildContext context,String id)async{
    bool res = await ServiceOrderService().acceptSubmition(id);
    if(res){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: 'Order accepted successfully',
              context: context,
              color: AppColor.white)));
    }
    Get.back();
  }

  void rejectSubmition(BuildContext context,String id)async{
    bool res = await ServiceOrderService().rejectSubmition(id);
    print(res);
    if(res){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: 'Order rejected successfully',
              context: context,
              color: AppColor.white)));
    }
    Get.back();
  }

}