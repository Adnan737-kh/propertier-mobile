import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/res/app_urls/app_url.dart';
import 'dart:convert';

import '../../../../App/Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../model/service_details_model.dart';

class ServiceDetailsController extends GetxController {
  var serviceDetails = ServiceDetailsModel().obs;

  final RxBool _isCollapsed = false.obs;
  RxBool isLoading = true.obs;
  bool get isCollapsed => _isCollapsed.value;
  UserPreference userPreference = UserPreference();
  String? accessToken;

  @override
  void onInit() {
    super.onInit();

    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('View Services Details Access Token: ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty && value.accessToken != 'null') {
        accessToken = value.accessToken;
      }
    });

    final service = Get.arguments;
    if (service != null && service.id != null) {
      fetchServiceDetails(service.id);
    } else {
      if (kDebugMode) print('No service argument or missing ID!');
    }

    update();
  }

  void fetchServiceDetails(int id) async {
    final url = Uri.parse('${AppUrls.serviceDetailsUrl}$id/');

    try {
      isLoading.value = true;
      final response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        serviceDetails.value = ServiceDetailsModel.fromJson(data);
        if (kDebugMode) {
          print('Services response body ${response.body}');
          print('Services response statusCode ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Services response body ${response.body}');
          print('Services response statusCode ${response.statusCode}');
        }
      } else {
        if (kDebugMode) {
          print('Services response body ${response.body}');
          print('Services response statusCode ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Services Catch Error $e');
      }
    } finally {
      isLoading.value = false;
    }
    update();
  }
}
