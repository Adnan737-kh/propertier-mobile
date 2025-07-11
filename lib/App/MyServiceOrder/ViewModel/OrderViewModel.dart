import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/App/MyServiceOrder/Model/ServiceOrderModel.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../Utils/app_text.dart';
import '../../../constant/colors.dart';
import '../Services/ServiceOrderService.dart';

class OrderViewModel extends GetxController {
  RxList<ServiceOrderModel> orders = <ServiceOrderModel>[].obs;

  Future getVendorOrders(String id) async {
    orders.value = await ServiceOrderService().getVendorOrders(id);
  }

  Future<Map<String, dynamic>?> getSubService(String id) async {
    return await ServiceOrderService().getSubService(id);
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController extraPriceC = TextEditingController();

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

  void acceptSubmission(BuildContext context, String id) async {
    bool res = await ServiceOrderService().acceptSubmition(id);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(
              title: context.local.order_accepted_successfully,
              color: AppColor.white)));
    }
    Get.back();
  }

  void rejectSubmission(BuildContext context, String id) async {
    bool res = await ServiceOrderService().rejectSubmition(id);
    if (kDebugMode) {
      print(res);
    }
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(
              title: context.local.order_rejected_successfully,
              color: AppColor.white)));
    }
    Get.back();
  }
}
