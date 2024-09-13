import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:propertier/Vendor/screens/Auth/Service/auth_service.dart';
import 'package:propertier/Vendor/screens/dashboard/fearture_ads/Model/feature_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/award_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/profile_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/service_model.dart';

class ApiService {
  var isLoading = false.obs;
  Future<String?> getVendorUserId() async {
    var currentUser = await AuthService().getCurrentUser();

    if (currentUser != null) {
      var userList = currentUser.users;

      var vendorUser = userList?.firstWhere((user) => user.type == "vendor");

      if (vendorUser != null) {
        print('User with type "vendor" found:');
        print('ID: ${vendorUser.id}');

        final box = GetStorage();
        await box.write('vendorUserId', vendorUser.id.toString());
        print('Vendor ID written to storage: ${vendorUser.id}');

        return vendorUser.id.toString(); // Return the vendor's ID as a String
      } else {
        print('No user with type "vendor" found.');
        return null;
      }
    } else {
      print('No current user found.');
      return null;
    }
  }

  Future<ProfileModel> fetchProfile(String vendorUserId) async {
    try {
      final String apiUrl =
          'https://propertier-p2wwcx3okq-em.a.run.app/accounts/vendors/$vendorUserId';

      final response =
          await http.get(Uri.parse(apiUrl), headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your_token_here',
      });

      print('API Request URL: $apiUrl');
      print('API Response Status: ${response.statusCode}');
      print('API Response Bodydfdsfsdfdsf: ${response.body}');

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);
        if (jsonBody is Map<String, dynamic>) {
          return ProfileModel.fromJson(jsonBody);
        } else {
          print(
              'Unexpected response format: expected a map, got ${jsonBody.runtimeType}');
          throw Exception(
              'Unexpected response format: expected a map, got ${jsonBody.runtimeType}');
        }
      } else {
        print('Failed to load profile: ${response.statusCode}');
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching profile: $e');
      rethrow;
    }
  }

  Future<List<AwardModel>> getAwards(String vendorUserId) async {
    String url =
        'https://propertier-p2wwcx3okq-em.a.run.app/services/awards-for-vendor/$vendorUserId';
    print(url);
    final response = await http.get(
      Uri.parse(url),
    );

    // log(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);
      final List<AwardModel> list =
          body.map<AwardModel>((award) => AwardModel.fromJson(award)).toList();
      return list;
    }
    throw Exception('Error');
  }

  Future<List<ServiceModel>> getServices(String vendorUserId) async {
    String url =
        'https://propertier-p2wwcx3okq-em.a.run.app/services/services-for-vendor/$vendorUserId';
    print('Request URL: $url');

    final response = await http.get(
      Uri.parse(url),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      print('Parsed JSON Body: $body');

      final List<ServiceModel> list = body
          .map<ServiceModel>((json) => ServiceModel.fromJson(json))
          .toList();
      return list;
    } else {
      throw Exception('Failed to fetch services: ${response.statusCode}');
    }
  }

  Future<List<FeatureAd>> getFeaturedServices(String vendorUserId) async {
    String url =
        'https://propertier-p2wwcx3okq-em.a.run.app/services/vendor-featured-services/$vendorUserId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List<FeatureAd> list =
            body.map<FeatureAd>((item) => FeatureAd.fromJson(item)).toList();
        return list;
      } else {
        throw Exception(
            'Failed to load featured services. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getFeaturedServices: $e');
      throw Exception('Error fetching featured services');
    }
  }

  Future<bool> deleteService(int serviceId) async {
    var response = await http.delete(
      Uri.parse(
          'https://propertier-p2wwcx3okq-em.a.run.app/services/vendor-services/$serviceId/'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFeaturedService(int serviceId) async {
    try {
      var response = await http.delete(
        Uri.parse(
            'https://propertier-p2wwcx3okq-em.a.run.app/serices/featured-services/$serviceId/'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return true;
      } else {
        // Log or handle unsuccessful status codes
        print('Failed to delete service. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('An error occurred while deleting the service: $e');
      return false;
    }
  }

  Future<bool> uploadCnicImages(File cnicFront) async {
    try {
      var request = http.MultipartRequest(
          'PUT',
          Uri.parse(
              'https://propertier-p2wwcx3okq-em.a.run.app/accounts/vendors'));

      // No need to add Content-Type header manually
      request.files.add(await http.MultipartFile.fromPath(
          'cnic_front_url', cnicFront.path,
          filename: basename(cnicFront.path)));

      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
        return false;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return false;
    }
  }
}
