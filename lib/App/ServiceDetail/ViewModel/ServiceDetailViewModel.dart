import 'package:get/get.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';

class ServiceDetailViewModel extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fixedServicesModel = Get.arguments;
  }


  late final FixedServicesModel fixedServicesModel;

}