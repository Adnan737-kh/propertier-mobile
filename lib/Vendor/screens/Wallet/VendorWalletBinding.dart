import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/Wallet/VendorWalletController.dart';

class VendorWalletBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut( ()=> VendorWalletController());
  }
}