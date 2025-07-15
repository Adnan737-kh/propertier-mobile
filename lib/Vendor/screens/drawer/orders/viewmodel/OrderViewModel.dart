import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/Vendor/screens/drawer/orders/services/OrderService.dart';
import '../../../../../Utils/app_text.dart';
import '../../../../../constant/colors.dart';
import '../model/OrderModel.dart';

class OrderViewModel extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVendorOrders(GetStorage().read('vendorUserId'));
  }



  RxList<OrderModel> orders = <OrderModel>[].obs;

  Future getVendorOrders(String id)async{
    orders.value = await OrderService().getVendorOrders(id);
  }

  Future<Map<String,dynamic>?> getSubService(String id)async{
    return await OrderService().getSubService(id);
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
    if (kDebugMode) {
      print("Length ${imageFileList.length}");
    }
  }


  Future submitWork(BuildContext context,String id,)async{
    List<String> imagesPath = [];
    for(XFile file in imageFileList){
      imagesPath.add(file.path);
    }
    bool res = await OrderService().submitWork(id, imagesPath, extraPriceC.text, descriptionController.text);
    if(res){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: CustomText(
              title: "Work submit Successfully",
              color: AppColor.white)));
    }
    Get.back();
  }

}