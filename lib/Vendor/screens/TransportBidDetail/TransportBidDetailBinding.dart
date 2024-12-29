import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/TransportBidDetail/TransportBidDetailController.dart';

class TransportBidDetailBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> TransportBidDetailController());
  }
}