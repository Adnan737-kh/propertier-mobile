import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/HouseWorkBidDetail/HouseWorkBidDetailController.dart';

class HouseWorkBidDetailBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> HouseWorkBidDetailController());
  }
}