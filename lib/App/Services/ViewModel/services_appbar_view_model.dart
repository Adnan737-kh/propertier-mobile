import 'package:get/get.dart';
import '../../../repository/vendor/vendor_auth/vendor_auth.dart';

class ServicesAppBarViewModel extends GetxController{
  final VendorRepository _api =VendorRepository();
  RxBool isLoading = false.obs;
}