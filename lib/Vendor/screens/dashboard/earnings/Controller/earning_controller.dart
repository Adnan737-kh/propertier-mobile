import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Vendor/screens/dashboard/earnings/Model/earning_model.dart';

class EarningController extends GetxController {
  var isLoading = true.obs;
  var earning = Earning(
    totalEarnings: 0,
    withdrawals: 0,
    deductions: 0,
    totalIncome: 0,
    totalExpenses: 0,
    recentTransactions: [],
  ).obs;

  Future<void> fetchEarningData(int userId) async {
    try {
      isLoading(true);

      final response = await http.get(Uri.parse(
          'https://propertier-p2wwcx3okq-em.a.run.app/finance/wallet-overview/$userId'));

      if (response.statusCode == 200) {
        earning.value = Earning.fromJson(json.decode(response.body));
      } else {
        Get.snackbar('Error', 'Failed to load earning data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchEarningData(40); // Fetch data for user ID 40
  }
}
