import 'package:get/get.dart';
import 'package:propertier/Customer/screens/HouseWorkForm/HouseWorkFormController.dart';

class HouseWorkFormBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> HouseWorkFormController());
  }
}