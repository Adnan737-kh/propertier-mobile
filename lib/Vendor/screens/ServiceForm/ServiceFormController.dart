import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/screens/ServiceForm/model/ServiceFormModel.dart';
import 'package:propertier/Vendor/screens/ServiceForm/model/TransportModel.dart';
import 'package:propertier/constant/constant.dart';
import '../../../App/Auth/Service/auth_service.dart';
import '../../../App/Auth/Service/google_sigin_services.dart';
import '../../../Handlers/permissions_handler.dart';
import '../../../RoutesAndBindings/app_routes.dart';

class ServiceFormController extends GetxController {
  var data = Get.arguments;

  RxBool isLoading = false.obs;

  // Map to hold field values
  final formFieldValues = <String, dynamic>{}.obs;

  List<ServiceFormModel> fields = [];

  // Method to fetch form requirements
  Future<List<ServiceFormModel>> getRequirements() async {
    final List<ServiceFormModel> formFields = [];
    try {
      final String url = "${API.getServiceForm}?service_id=${data['serviceId']}";
      print(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body) as List<dynamic>;
        formFields.addAll(responseData.map((d) => ServiceFormModel.fromJson(d as Map<String, dynamic>)));
      }
    } catch (e) {
      print("Error fetching form fields: $e");
    }
    fields = formFields;
    return formFields;
  }

  // Method to get all form values
  Map<String, dynamic> getFormValues() {
    return formFieldValues;
  }

  // Method to pick multiple images
  Future<void> multiImagePick(String fieldName) async {
    if (await PermissionsHandler.requestGalleryPermission()) {
      final result = await ImagePicker().pickMultiImage(imageQuality: 50);
      if (result != null && result.isNotEmpty) {
        // Limit to 5 images
        final selectedImages = result.length > 5
            ? result.sublist(0, 5).map((e) => e.path).toList()
            : result.map((e) => e.path).toList();

        // Save images to form field values
        formFieldValues[fieldName] = selectedImages;
      }
    }
  }


  Future<List<TransportModel>> getAllTransport()async{
    List<TransportModel> items = [];
    try{
      String url = API.getTransport;
      var response = await http.get(Uri.parse(url),);

      if(response.statusCode == 200){
        final List<dynamic> responseData = jsonDecode(response.body) as List<dynamic>;
        items.addAll(responseData.map((d) => TransportModel.fromJson(d as Map<String, dynamic>)));
      }

    }
    catch(e){
      print(e);
    }
    return items;
  }


  Rxn selectedTransportName = Rxn();
  List<TransportModel> filteredTransports = [];
  List<TransportModel> allTransports = [];




  Future saveVendorData(Map<String, dynamic> data)async{
    isLoading.value = true;
    for(ServiceFormModel serviceFormModel in fields){
      print(serviceFormModel.id);
      print(data[serviceFormModel.fieldName]);
      print(data[serviceFormModel.fieldName] is List);
      print("-------");
      if(data[serviceFormModel.fieldName] is List){
        await saveListField(serviceFormModel.id??-1, data[serviceFormModel.fieldName]);
      }
      else{
        await saveField(serviceFormModel.id??-1, data[serviceFormModel.fieldName]);
      }
    }

    isLoading.value = false;
    AuthService().logout();
    GoogleSiginServices().logout();
    Get.offAllNamed(AppRoutes.loginView);
  }


  Future saveField(var id, dynamic value)async{
    try{
      String url = API.saveVendorFormField;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.fields['vendor_id'] = data['vendorId'].toString();
      request.fields['requirement'] = id.toString();
      request.fields['value'] = "\"$value\"";
      print(request.fields);
      var streamedResponse = await request.send();
      print("result****");
      print(streamedResponse.statusCode);
      var res = await http.Response.fromStream(streamedResponse);
      print(res.body);
    }
    catch(e){
      print(e);
    }
  }


  Future saveListField(var id, var files)async{
    try{
      String url = API.saveVendorFormField;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.fields['vendor_id'] = data['vendorId'].toString();
      request.fields['requirement'] = id.toString();
      for(String img in files){
        request.files.add(
            await http.MultipartFile.fromPath('value', img));
      }
      var streamedResponse = await request.send();
      print("result****");
      print(streamedResponse.statusCode);
      var res = await http.Response.fromStream(streamedResponse);
      print(res.body);
    }
    catch(e){
      print(e);
    }
  }


}



// import 'dart:convert';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:propertier/Network/api_urls.dart';
// import 'package:propertier/Vendor/screens/ServiceForm/model/ServiceFormModel.dart';
//
// class ServiceFormController extends GetxController{
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//   }
//
//   var data = Get.arguments;
//
//   Future<List<ServiceFormModel>> getRequirements()async{
//     List<ServiceFormModel> formFields = [];
//     try{
//       String url = "${API.getServiceForm}?service_id=${data['serviceId']}";
//       print(url);
//       var response = await http.get(Uri.parse(url));
//       if(response.statusCode == 200){
//         var data = jsonDecode(response.body);
//         for(var d in data){
//           ServiceFormModel serviceFormModel = ServiceFormModel.fromJson(d);
//           formFields.add(serviceFormModel);
//         }
//       }
//     }
//     catch(e){
//       print(e);
//     }
//     return formFields;
//   }
// }