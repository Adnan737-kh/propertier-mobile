import 'package:get/get.dart';
import 'package:propertier/App/Services/Model/services_model.dart';

class SubServiceViewModel extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    parentServicesModel = Get.arguments;
  }

  late final ParentServicesModel parentServicesModel;
}