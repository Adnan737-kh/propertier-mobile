import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/drawer/review/Model/review_model.dart';


class ReviewController extends GetxController {
  var feedbacks = <Review>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final ApiService apiService = ApiService();  // Create an instance of ApiService

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
        List<Review> fetchedFeedbacks = await apiService.fetchVendorFeedbacks(vendorUserId);  // Use ApiService
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
}
