import 'package:get/get.dart';
import '../../../App/Services/Model/ServiceDashboardModel.dart';

class AllServicesScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    services = Get.arguments;
  }

  late List<SellingServices> services;
}
