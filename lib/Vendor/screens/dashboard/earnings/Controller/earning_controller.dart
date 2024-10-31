import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/dashboard/earnings/Model/earning_model.dart';

class EarningController extends GetxController {
  var isLoading = true.obs;
  var earning = Earning(
    totalEarnings: 0,
    withdrawals: 0,
    deductions: 0,
    monthlyEarning: 0,
    monthlyWidthdrawals: 0,
  ).obs;
  
   final ApiService apiService = ApiService();

  Future<void> fetchEarningData(String vendorUserId) async {
    isLoading(true); 
    try {
      earning.value = await apiService.fetchEarningData(vendorUserId);
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching earning data: $e');
    } finally {
      isLoading(false); 
    }
  }

  @override
  void onInit() {
    super.onInit();
      String vendorUserId = GetStorage().read('vendorUserId') ?? '';
    if (vendorUserId.isNotEmpty) {
      fetchEarningData(vendorUserId);
    } else {
      Get.snackbar('Error', 'Vendor ID is not available');
    }
  }
}
