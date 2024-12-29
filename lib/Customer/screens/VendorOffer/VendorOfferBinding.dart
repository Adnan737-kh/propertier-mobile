import 'package:get/get.dart';
import 'package:propertier/Customer/screens/VendorOffer/VendorOfferController.dart';

class VendorOfferBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> VendorOfferController());
  }
}