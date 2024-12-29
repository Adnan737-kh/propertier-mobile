import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/WaterBidDetail/WaterBidDetailController.dart';

class WaterBidDetailBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> WaterBidDetailController());
  }
}