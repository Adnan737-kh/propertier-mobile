import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Vendor/screens/drawer/review/Model/review_model.dart';

class ReviewController extends GetxController {
  var feedbacks = <Review>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVendorFeedbacks();
  }

  void fetchVendorFeedbacks() async {
    final box = GetStorage();
    String? vendorUserId = box.read('vendorUserId');

    if (vendorUserId != null) {
      try {
        isLoading(true);
        List<Review> fetchedFeedbacks =
            await _fetchVendorFeedbacks(vendorUserId);
        feedbacks.assignAll(fetchedFeedbacks);
        if (feedbacks.isEmpty) {
          errorMessage('No reviews available');
        } else {
          errorMessage('');
        }
      } catch (e) {
        errorMessage('Failed to load vendor feedbacks');
      } finally {
        isLoading(false);
      }
    } else {
      errorMessage("Vendor User ID not found");
      isLoading(false);
    }
  }

  Future<List<Review>> _fetchVendorFeedbacks(String vendorUserId) async {
    final response = await http.get(
      Uri.parse(
          'https://propertier-p2wwcx3okq-em.a.run.app/services/vendor-feedbacks/$vendorUserId'),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Log the response body

    if (response.statusCode == 200) {
      try {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Review.fromJson(json)).toList();
      } catch (e) {
        throw Exception('Error parsing response data: $e');
      }
    } else {
      throw Exception(
          'Failed to load vendor feedbacks, status code: ${response.statusCode}');
    }
  }
}
