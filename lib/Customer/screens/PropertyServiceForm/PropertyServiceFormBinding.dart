import 'package:get/get.dart';
import 'package:propertier/Customer/screens/PropertyServiceForm/PropertyServiceFormController.dart';

class PropertyServiceFormBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> PropertyServiceFormController());
  }
}