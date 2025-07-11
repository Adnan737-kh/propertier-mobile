import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';

import 'model/VendorFormModal.dart';


class VendorFormController extends GetxController{


  List<VendorFormModal> items = [];

  Future<List<VendorFormModal>> getMyData()async{
    try{
      var id = GetStorage().read('vendorUserId');
      String url = "${API.getVendorFormData}$id";
      print(url);
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        items.clear();
        for(var data in jsonDecode(response.body)){
          VendorFormModal vendorFormModal = VendorFormModal.fromJson(data);
          items.add(vendorFormModal);
        }
      }
    }
    catch(e){
      print(e);
    }
    return items;
  }

}