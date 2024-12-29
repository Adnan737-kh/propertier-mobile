import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/drawer/EditVendorForm/EditVendorFormController.dart';

class EditVendorFormBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> EditVendorFormController());
  }
}