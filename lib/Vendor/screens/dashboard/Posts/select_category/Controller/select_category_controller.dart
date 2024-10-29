import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/title_model.dart';

class SelectCategoryController extends GetxController {
  var parentServicesMap = <String, String>{}
      .obs; // Map to store parent_service_name and parent_service_id
  var titles = <TitleModel>[].obs; // Storing TitleModel instead of just String
  var selectedParentServiceId = ''.obs; // To store selected parent_service_id
  var isLoading = false.obs;
  var errorMessage = RxnString();

  final String apiUrl =
      '${API.baseURL}/services/services/';

  Future<void> fetchParentServices() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('API Response: ${response.body}');
        List<dynamic> data = json.decode(response.body);
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
      } else {
        errorMessage.value = 'Failed to load parent services';
      }
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
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('API Response: ${response.body}');
        List<dynamic> data = json.decode(response.body);
        List<TitleModel> titlesList = [];

        // Iterate through the list of parent services
        for (var item in data) {
          // Check if the parent_service_name matches the selected category
          if (item['title'] == parentServiceName) {
            // Check if the parent service has subservices
            if (item['subservices'] != null) {
              List<dynamic> subservices = item['subservices'];

              // Iterate through the subservices
              for (var subservice in subservices) {
                print('Subservice Data: $subservice');

                // Fetch the title and id from the matching subservices
                String title = subservice['title'] ?? '';
                String id = subservice['id'].toString();

                if (title.isNotEmpty && id.isNotEmpty) {
                  titlesList.add(TitleModel(title: title, id: id));
                }
              }
            }
            break;
          }
        }

        titles.value = titlesList;
        selectedParentServiceId.value =
            parentServicesMap[parentServiceName] ?? '';
        print('Fetched Titles for $parentServiceName: $titlesList');
        print('Selected Parent Service ID: ${selectedParentServiceId.value}');
        errorMessage.value = null;
      } else {
        errorMessage.value = 'Failed to load titles';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
