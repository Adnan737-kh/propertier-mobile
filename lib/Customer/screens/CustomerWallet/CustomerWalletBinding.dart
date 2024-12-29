import 'package:get/get.dart';
import 'package:propertier/Customer/screens/CustomerWallet/CustomerWalletController.dart';

class CustomerWalletBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> CustomerWalletController());
  }
}