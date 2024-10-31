import 'package:get/get.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/title_model.dart';


class SelectCategoryController extends GetxController {
  var parentServicesMap = <String, String>{}.obs; // Map to store parent_service_name and parent_service_id
  var titles = <TitleModel>[].obs; // Storing TitleModel instead of just String
  var selectedParentServiceId = ''.obs; // To store selected parent_service_id
  var isLoading = false.obs;
  var errorMessage = RxnString();

  final ApiService apiService = ApiService();  // Instance of ApiService

  // Fetch Parent Services
  Future<void> fetchParentServices() async {
    try {
      isLoading.value = true;
      final data = await apiService.fetchParentServices();  // Use ApiService for API call

      Map<String, String> servicesMap = {};
      for (var item in data) {
        if (item['subservices'] != null) {
          List<dynamic> subservices = item['subservices'];
          for (var subservice in subservices) {
            String name = subservice['parent_service_name'] ?? '';
            String parentId = subservice['parent_service'].toString();

            if (name.isNotEmpty && parentId.isNotEmpty) {
              servicesMap[name] = parentId;
            }
          }
        }
      }

      parentServicesMap.value = servicesMap;
      errorMessage.value = null;
      print('Parsed Parent Services Map: $parentServicesMap');
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // Fetch Titles for a Specific Parent Service
  Future<void> fetchTitlesForParentService(String parentServiceName) async {
    try {
      isLoading.value = true;
      final titlesList = await apiService.fetchTitlesForParentService(parentServiceName);  // Use ApiService

      titles.value = titlesList;
      selectedParentServiceId.value = parentServicesMap[parentServiceName] ?? '';
      print('Fetched Titles for $parentServiceName: $titlesList');
      print('Selected Parent Service ID: ${selectedParentServiceId.value}');
      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
