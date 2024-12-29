import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../../Handlers/permissions_handler.dart';
import '../../../../Network/api_urls.dart';
import '../../ServiceForm/model/ServiceFormModel.dart';
import '../../ServiceForm/model/TransportModel.dart';
import '../VendorForm/model/VendorFormModal.dart';

class EditVendorFormController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    data = Get.arguments;
  }

  late List<VendorFormModal> data;
  String vendorId = GetStorage().read('vendorUserId');


  // Map to hold field values
  final formFieldValues = <String, dynamic>{}.obs;


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


  Future saveVendorData(Map<String, dynamic> d)async{
    for(VendorFormModal vendorFormModel in data){
      print(vendorFormModel.requirementDetails!.id);
      print(d[vendorFormModel.requirementDetails!.fieldName]);
      print(d[vendorFormModel.requirementDetails!.fieldName] is List);
      print("-------");
      if(d[vendorFormModel.requirementDetails!.fieldName] == null){

      }
      else if(d[vendorFormModel.requirementDetails!.fieldName] is List){
        await saveListField(vendorFormModel.requirementDetails!.id??-1, d[vendorFormModel.requirementDetails!.fieldName]);
      }
      else{
        await saveField(vendorFormModel.requirementDetails!.id??-1, d[vendorFormModel.requirementDetails!.fieldName]);
      }
    }
  }


  Future saveField(var id, dynamic value)async{
    try{
      String url = API.saveVendorFormField;
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(url),
      );
      request.fields['vendor_id'] = vendorId.toString();
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
        'PUT',
        Uri.parse(url),
      );
      request.fields['vendor_id'] = vendorId.toString();
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