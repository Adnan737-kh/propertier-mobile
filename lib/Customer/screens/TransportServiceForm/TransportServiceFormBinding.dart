import 'package:get/get.dart';
import 'package:propertier/Customer/screens/TransportServiceForm/TransportServiceFormController.dart';

class TransportServiceFormBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> TransportServiceFormController());
  }
}