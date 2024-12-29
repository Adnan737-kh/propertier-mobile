import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/PropertyBidDetail/PropertyBidDetailController.dart';

class PropertyBidDetailBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> PropertyBidDetailController());
  }
}