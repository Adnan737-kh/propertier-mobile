import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/drawer/VendorForm/VendorFormController.dart';

class VendorFormBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> VendorFormController());
  }
}