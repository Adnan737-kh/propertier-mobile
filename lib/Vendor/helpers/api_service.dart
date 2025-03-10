import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/screens/Auth/Service/auth_service.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/title_model.dart';
import 'package:propertier/Vendor/screens/dashboard/dashboard.dart';
import 'package:propertier/Vendor/screens/dashboard/earnings/Model/earning_model.dart';
import 'package:propertier/Vendor/screens/dashboard/fearture_ads/Model/feature_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/award_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/profile_model.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/model/service_model.dart';
import 'package:propertier/Vendor/screens/drawer/review/Model/review_model.dart';
import 'package:propertier/Vendor/screens/drawer/vehicle_list/model/VehicleModel.dart';

import '../screens/dashboard/Posts/add_post/Model/add_post_model.dart';

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

        return vendorUser.id.toString(); 
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
   
    final String apiUrl = '${API.fetchProfile}/$vendorUserId';

    final response = await http.get(
      Uri.parse(apiUrl), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your_token_here',
      }
    );

      print('API Request URL: $API.fetchProifle');
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


 Future<void> updateUserProfile(String vendorUserId, ProfileModel profileModel, ProfileController profileController) async {

     final String apiUrl = '${API.updateUserProfile}/$vendorUserId/'; 

    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(apiUrl),
      );


      request.fields['name'] = profileModel.name?.isNotEmpty == true
          ? profileModel.name!
          : profileController.profile.value.name ?? '';

      request.fields['address'] = profileModel.address?.isNotEmpty == true
          ? profileModel.address!
          : profileController.profile.value.address ?? '';

      request.fields['phone_number'] = profileModel.phoneNumber?.isNotEmpty == true
          ? profileModel.phoneNumber!
          : profileController.profile.value.phoneNumber ?? '';

      request.fields['about'] = profileModel.about?.isNotEmpty == true
          ? profileModel.about!
          : profileController.profile.value.about ?? '';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while updating the profile: $e');
    }
  }


   Future<void> addAwards(AwardModel awardModel) async {

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(API.addAwards),
      );
      request.fields['vendor_id'] = awardModel.vendorId;

     
      if (awardModel.imagePath.isNotEmpty) {
        var imageFile = File(awardModel.imagePath);
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imageFile.path,
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 201) {
        throw Exception(
            'Failed to add service. ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('An error occurred while adding service: $e');
    }
  }


  Future<List<AwardModel>> getAwards(String vendorUserId) async {

   final String apiUrl = '${API.getAwards}/$vendorUserId';


    final response = await http.get(
      Uri.parse(apiUrl),
    );

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

      final String apiUrl = '${API.getServices}/$vendorUserId';
    print('Request URL: $url');

    final response = await http.get(
      Uri.parse(apiUrl),
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

  final String apiUrl = '${API.getFeaturedServices}/$vendorUserId';  

    try {
      final response = await http.get(Uri.parse(apiUrl));

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

   final String apiUrl = '${API.deleteServices}/$serviceId/';  
  
  try {
    var response = await http.delete(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if(response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
      return true; 
    } else {
      print('Failed to delete service. Status: ${response.statusCode}');
      return false; 
    }
  } catch (e) {

    print('Exception occurred: $e');
    return false;
  }
}


  Future<bool> deleteFeaturedService(int serviceId) async {

     final String apiUrl = '${API.deleteFeaturedService}/$serviceId/';  

    try {
      var response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return true;
      } else {
     
        print('Failed to delete service. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('An error occurred while deleting the service: $e');
      return false;
    }
  }

  Future<bool> deleteAward(int awardId) async {

     final String apiUrl = '${API.deleteAward}/$awardId/';  

    try {
      var response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return true;
      } else {
 
        print('Failed to delete Awards. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {

      print('An error occurred while deleting the Awards: $e');
      return false;
    }
  }

Future<void> updateCoverPicture(String vendorUserId, File imageFile,String firebaseid, String email) async {

     final String apiUrl = '${API.updateCoverPicture}/$vendorUserId/';  

    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(apiUrl),
      )..files.add(
          await http.MultipartFile.fromPath('cover_photo', imageFile.path)
        );

      request.fields['type'] = "vendor";
      request.fields['firebase_id'] = firebaseid;
      request.fields['email'] = email;

      var response = await request.send();

      if (response.statusCode != 200) {
        throw Exception('Failed to update cover picture. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while updating the cover picture: $e');
    }
  }
  Future<void> updateDrivingLicense( File? front, File? back, String vendorUserId, String firebaseid, String email) async {

     final String apiUrl = '${API.updateCoverPicture}/$vendorUserId/';

    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(apiUrl),
      );

      if(front != null){
        request.files.add(
          await http.MultipartFile.fromPath(
            'driving_licence_front',
            front.path,
          ),
        );
      }

      if(back != null){
        request.files.add(
          await http.MultipartFile.fromPath(
            'driving_licence_back',
            back.path,
          ),
        );
      }


      request.fields['type'] = "vendor";
      request.fields['firebase_id'] = firebaseid;
      request.fields['email'] = email;

      var response = await request.send();

      if (response.statusCode != 200) {
        throw Exception('Failed to update cover picture. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while updating the cover picture: $e');
    }
  }


  Future<bool> uploadCnicImages(File cnicFront) async {

    try {
      var request = http.MultipartRequest(
          'PUT',
          Uri.parse( API.uploadCnicImages));

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

  Future<Earning> fetchEarningData(String vendorUserId) async {

     final String apiUrl = '${API.fetchEarningData}/$vendorUserId/earnings-summary';  

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        return Earning.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load earning data. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching earning data: $e');
    }
  }


  Future<void> postWithFeaturePackage(
    AddPostModel postModel,
    List<File> selectedImage,
    File? selectedVideo,
    String vendorUserId,
    String featurePackageId,
  ) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );


      var request = http.MultipartRequest(
        'POST',
        Uri.parse(API.postWithoutFeaturePackage),
      );

      request.fields['vendor_id'] = vendorUserId;
      request.fields['service_id'] = postModel.serviceId;
      request.fields['title'] = postModel.title;
      request.fields['visiting_charges'] = postModel.visitingCharges;
      request.fields['fixed_price'] = postModel.fixedPrice;
      // request.fields['video_url'] = postModel.videoUrl;

      for (var service in postModel.selectedSubServices) {
        request.fields['selected_sub_services'] = service;
      }

      for(File f in selectedImage){
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          f.path,
        ));
      }

      if (selectedVideo != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'short_video',
          selectedVideo.path,
        ));
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(responseBody);
        var vendorServiceId = responseData['id'].toString();

        await callNewApi(vendorServiceId, featurePackageId, selectedImage.first.path);
      } else {
        Get.back();
          Get.snackbar(
            'Error', 'You have already added a post in this category.');

            //  remove featurepackageid add here 
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> callNewApi(
    String vendorServiceId,
    String featurePackageId,
    String coverImagePath,
  ) async {
    try {
      var newRequest = http.MultipartRequest(
        'POST',
        Uri.parse(API.postWithFeaturePackage),
      );

      newRequest.fields['vendor_service_id']= vendorServiceId;
      newRequest.fields['feature_package_id'] = featurePackageId;

      newRequest.files.add(await http.MultipartFile.fromPath(
        'cover_image',
        coverImagePath,
      ));

      var newResponse = await newRequest.send();
      if (newResponse.statusCode == 200 || newResponse.statusCode == 201) {
        // Get.snackbar('Success', 'Post added successfully with feature package');
        final box = GetStorage();
        box.remove('featurePackageId');
        Get.back();
        Get.offAll(() => const Dashboard());
            Get.snackbar('Success', 'Post added successfully with fetaure package');
      } else {
        Get.back();
        Get.snackbar('Error', 'Failed to call the new API. Status: ${newResponse.statusCode}');
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> postWithoutFeaturePackage(
    AddPostModel postModel,
    List<File> selectedImage,
    File? selectedVideo,
    String vendorUserId,
  ) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(API.postWithoutFeaturePackage),
      );

      request.fields['vendor_id'] = vendorUserId;
      request.fields['service_id'] = postModel.serviceId;
      request.fields['title'] = postModel.title;
      request.fields['visiting_charges'] = postModel.visitingCharges;
      request.fields['fixed_price'] = postModel.fixedPrice;
        // request.fields['video_url'] = postModel.videoUrl;

      for (var service in postModel.selectedSubServices) {
        request.fields['selected_sub_services'] = service;
      }

      for(File f in selectedImage){
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          f.path,
        ));
      }

       if (selectedVideo != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'short_video',
          selectedVideo.path,
        ));
      }

      var response = await request.send();
       var body = await response.stream.bytesToString();
       print(response.statusCode);
       print(body);
      Get.back();
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Post added successfully without feature package');
        Get.snackbar('Success', 'Post added successfully');
        Get.offAll(() => const Dashboard());
      } else {
        Get.snackbar(
            'Error', 'You have already added a post in this category.');
      }
    } catch (e) {
      Get.back();
      print("Error: $e");
      Get.snackbar('Error', 'An error occurred while adding the post');
    }
  }


 Future<int?> submitFeaturePackage(Map<String, dynamic> featurePackageJson) async {

    try {
      final response = await http.post(
        Uri.parse(API.submitFeaturePackage),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(featurePackageJson),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Feature package submitted successfully: ${response.body}');

        final responseData = jsonDecode(response.body);
        return responseData['id'];
      } else {
        print('Failed to submit feature package: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error submitting feature package: $e');
      return null;
    }
  }
  

  Future<List<dynamic>> fetchParentServices() async {
    final url = Uri.parse(API.fetchParentServices);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load parent services');
    }
  }

  Future<List<TitleModel>> fetchTitlesForParentService(String parentServiceName) async {
    final url = Uri.parse(API.fetchParentServices);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<TitleModel> titlesList = [];

      for (var item in data) {
        if (item['title'] == parentServiceName) {
          if (item['subservices'] != null) {
            List<dynamic> subservices = item['subservices'];

            // Iterate through the subservices
            for (var subservice in subservices) {
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
      return titlesList;
    } else {
      throw Exception('Failed to load titles for the service');
    }
  }


  // Fetch Vendor Feedbacks
  Future<List<Review>> fetchVendorFeedbacks(String vendorUserId) async {

    final String apiUrl = '${API.fetchVendorFeedbacks}/$vendorUserId';  

    final response = await http.get(
      Uri.parse(apiUrl),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); 

    if (response.statusCode == 200) {
      try {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData is List) {
          return jsonData.map((json) => Review.fromJson(json)).toList();
        } else {
          throw Exception('Invalid JSON format');
        }
      } catch (e) {
        throw Exception('Error parsing response data: $e');
      }
    } else {
      throw Exception('Failed to load vendor feedbacks, status code: ${response.statusCode}');
    }
  }

   // Update CNIC Document
  Future<http.Response> uploadCnicDocument(
      File cnicFront, File cnicBack, String vendorUserId, String firebaseId, String email, String type) async {

     final String apiUrl = '${API.uploadDocuments}/$vendorUserId/';  

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(apiUrl),
    )
      ..fields['firebase_id'] = firebaseId
      ..fields['email'] = email
      ..fields['type'] = type
      ..files.add(await http.MultipartFile.fromPath('cnic_front', cnicFront.path))
      ..files.add(await http.MultipartFile.fromPath('cnic_back', cnicBack.path));

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  // Generic Document Upload
  Future<http.Response> uploadDocument(
      File file, String documentType, String vendorUserId, String firebaseId, String email, String type) async {

    final String apiUrl = '${API.uploadDocuments}/$vendorUserId/';  

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(apiUrl),
    )
      ..fields['firebase_id'] = firebaseId
      ..fields['email'] = email
      ..fields['type'] = type
      ..files.add(await http.MultipartFile.fromPath(documentType, file.path));

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }


    // Send Incorporation and Sole Proprietor Documents
   Future<http.Response> sendDocuments({
    required String vendorUserId,
    required String firebaseId,
    required String email,
    required String type,
    required File incorporateDocument,
    required File soleProprietorDocument,
  }) async {

     final String apiUrl = '${API.inCoProDocuments}/$vendorUserId/';


    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(apiUrl),
    );

    request.fields['firebase_id'] = firebaseId;
    request.fields['email'] = email;
    request.fields['type'] = type;

    request.files.add(
      await http.MultipartFile.fromPath('incorporate_document', incorporateDocument.path),
    );
    request.files.add(
      await http.MultipartFile.fromPath('sole_propertiier_document', soleProprietorDocument.path),
    );

    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }



  Future<List<VehicleModel>> fetchMyVehicles(String vendorId) async {
    List<VehicleModel> vehicles = [];
    try{
      final url = Uri.parse("${API.getVendorVehicles}$vendorId/");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        for(var d in data){
          VehicleModel vehicleModel = VehicleModel.fromJson(d);
          // print(vehicleModel.images?.length);
          vehicles.add(vehicleModel);
        }

      } else {
        throw Exception('Failed to load titles for the service');
      }
    }
    catch(e){
      print("Error ::: $e");
    }

    return vehicles;
  }

  Future<http.Response> addVehicle({required String vendorid,required String make, required String model, required String color, required String name, required String capacity, required String fuelType, required String registrationNumber, required String year, required String transmissionType, required List<String> images})async{
    final String apiUrl = '${API.addVehicles}';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(apiUrl),
    )
      ..fields['vendor'] = vendorid
      ..fields['make'] = make
      ..fields['model'] = model
      ..fields['year'] = year
      ..fields['color'] = color
      ..fields['registration_number'] = registrationNumber
      ..fields['owner_name'] = name
      ..fields['capacity'] = capacity
      ..fields['fuel_type'] = fuelType
      ..fields['transmission_type'] = transmissionType;


    for(String img in images){
      request.files.add(
          await http.MultipartFile.fromPath('images', img));
    }

    var streamedResponse = await request.send();
    print(streamedResponse.statusCode);
    return  await http.Response.fromStream(streamedResponse);
  }

  Future updateVendorLocation(LatLng latlng, String id)async{
    try{
      String url = "${API.updateVendorLocation}$id/";
      final Map<String, dynamic> data = {
        "latitude_position": latlng.latitude,
        "longitude_position": latlng.longitude,
      };

      final encodedData = jsonEncode(data);

      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: encodedData,
      );
    }
    catch(e){
      print(e);
    }
  }
}








