import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/ServiceForm/ServiceFormController.dart';

class ServiceFormBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> ServiceFormController());
  }
}