import 'package:get/get.dart';
import 'package:propertier/Customer/screens/WaterServiceForm/WaterServiceFormController.dart';

class WaterServiceFormBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> WaterServiceFormController());
  }
}