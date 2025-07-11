import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/screens/ServiceForm/model/ServiceFormModel.dart';
import 'package:propertier/Vendor/screens/ServiceForm/model/TransportModel.dart';
import '../../../App/Auth/Service/auth_service.dart';
import '../../../App/Auth/Service/google_sigin_services.dart';
import '../../../App/Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../../../Handlers/permissions_handler.dart';
import '../../../RoutesAndBindings/app_routes.dart';

class ServiceFormController extends GetxController {
  String? _accessToken;
  String? get accessToken => _accessToken;
  var data = Get.arguments;
  late String category;

  UserPreference userPreference = UserPreference();


  RxBool isLoading = false.obs;

  // Map to hold field values
  final formFieldValues = <String, dynamic>{}.obs;

  List<ServiceFormModel> fields = [];

  @override
  void onInit() {
    super.onInit();
    category = Get.arguments['category'];
    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('number verification ACCESS   !!! ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        _accessToken = value.accessToken;
      }
    });
  }

  // Method to fetch form requirements
  // Future<List<ServiceFormModel>> getRequirements() async {
  //
  //   final List<ServiceFormModel> formFields = [];
  //   try {
  //     const String url =
  //         "${API.getServiceForm}?service_id=4";
  //     // print('services id ${data['serviceId']}');
  //
  //     if (kDebugMode) {
  //       print(url);
  //     }
  //     final response = await http.get(Uri.parse(url),
  //         headers: {
  //       "Content-Type": "application/json",
  //       'Authorization' : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMjAxNjA1LCJpYXQiOjE3NDIxMTUyMDUsImp0aSI6IjQ2MTI4YmE3YjdlOTQyNDQ5MWMxMjIxYWM3NDk2N2RjIiwidXNlcl9pZCI6M30.y21Gjev5rH1HwOThtgahdd8a61jy0fOGRBNNfVmzKq4"
  //     });
  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseData =
  //           jsonDecode(response.body) as List<dynamic>;
  //       formFields.addAll(responseData
  //           .map((d) => ServiceFormModel.fromJson(d as Map<String, dynamic>)));
  //       print('get getRequirements ${response.statusCode}');
  //
  //     }else{
  //       print('get getRequirements ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Error fetching form fields: $e");
  //     }
  //   }
  //   fields = formFields;
  //   return formFields;
  // }

  // Method to get all form values
  Map<String, dynamic> getFormValues() {
    return formFieldValues;
  }

  // Method to pick multiple images
  Future<void> multiImagePick(String fieldName) async {
    if (await PermissionsHandler.requestGalleryPermission()) {
      final result = await ImagePicker().pickMultiImage(imageQuality: 50);
      if (result.isNotEmpty) {
        // Limit to 5 images
        final selectedImages = result.length > 5
            ? result.sublist(0, 5).map((e) => e.path).toList()
            : result.map((e) => e.path).toList();

        // Save images to form field values
        formFieldValues[fieldName] = selectedImages;
      }
    }
  }

  Future<List<TransportModel>> getAllTransport() async {
    List<TransportModel> items = [];
    try {
      String url = API.getTransport;
      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            jsonDecode(response.body) as List<dynamic>;
        items.addAll(responseData
            .map((d) => TransportModel.fromJson(d as Map<String, dynamic>)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return items;
  }

  Rxn selectedTransportName = Rxn();
  List<TransportModel> filteredTransports = [];
  List<TransportModel> allTransports = [];

  Future<void> uploadServicesForm(Map<String, dynamic> formData) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse(API.saveVendorFormField);
      var request = http.MultipartRequest('POST', uri);

      // Add headers
      String token = _accessToken!;
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      for (var entry in formData.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value is List<String>) {
          // Handle multiple image files
          for (String path in value) {
            final file = await http.MultipartFile.fromPath(
              key,
              path,
              filename: basename(path),
            );
            request.files.add(file);
          }
        } else if (value is String) {
          // Handle text fields
          request.fields[key] = value;
        }
      }

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        if (kDebugMode) print("✅ Upload success: $responseBody");
        Get.snackbar("Success", "Uploaded successfully");
        Get.toNamed(AppRoutes.vendorDashBoard);

      } else {
        if (kDebugMode) {
          print("❌ Upload failed: ${response.statusCode}");
          print("⚠️ Response body: $responseBody");
        }
        Get.snackbar("Error", "Upload failed: ${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) print("🔥 Upload exception: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
  Future saveVendorData(Map<String, dynamic> data) async {
    isLoading.value = true;
    for (ServiceFormModel serviceFormModel in fields) {
      if (kDebugMode) {
        print(serviceFormModel.id);
        print(data[serviceFormModel.fieldName]);
        print(data[serviceFormModel.fieldName] is List);
        print("-------");
      }

      if (data[serviceFormModel.fieldName] is List) {
        await saveListField(
            serviceFormModel.id ?? -1, data[serviceFormModel.fieldName]);
      } else {
        await saveField(
            serviceFormModel.id ?? -1, data[serviceFormModel.fieldName]);
      }
    }

    isLoading.value = false;
    AuthService().logout();
    GoogleSigInServices().logout();
    Get.offAllNamed(AppRoutes.loginView);
  }

  Future saveField(var id, dynamic value) async {
    try {
      String url = API.saveVendorFormField;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.fields['vendor_id'] = data['vendorId'].toString();
      request.fields['requirement'] = id.toString();
      request.fields['value'] = "\"$value\"";
      if (kDebugMode) {
        print(request.fields);
      }
      var streamedResponse = await request.send();
      if (kDebugMode) {
        print("result****");
      }
      if (kDebugMode) {
        print(streamedResponse.statusCode);
      }
      var res = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(res.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future saveListField(var id, var files) async {
    try {
      String url = API.saveVendorFormField;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.fields['vendor_id'] = data['vendorId'].toString();
      request.fields['requirement'] = id.toString();
      for (String img in files) {
        request.files.add(await http.MultipartFile.fromPath('value', img));
      }
      var streamedResponse = await request.send();
      if (kDebugMode) {
        print("result****");
      }
      if (kDebugMode) {
        print(streamedResponse.statusCode);
      }
      var res = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print(res.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

