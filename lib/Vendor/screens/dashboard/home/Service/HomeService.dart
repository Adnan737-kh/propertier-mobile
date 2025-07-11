import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/App/Auth/Login/Model/login_response_model.dart';
import '../../../../../Network/api_urls.dart';



class HomeService{

  Future<UserData?> getUser(String id)async{

    try{
      String url = "${API.registerUrl}/$id/";
      final response = await http.get(
        Uri.parse(url),
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        UserData userData = UserData.fromJson(data);
        return userData;
      }
    }
    catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }


  Future<bool> addOffer(String bidId, String amount, String message)async{
    try{
      String url = API.offerByVendor;

      final Map<String, dynamic> data = {
        "bid": bidId,
        "amount": amount,
        "message": message,
        "vendor_id": GetStorage().read('vendorUserId'),
      };

      final encodedData = jsonEncode(data);

      if (kDebugMode) {
        print(encodedData);
      }
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: encodedData,
      );
      if (kDebugMode) {
        print(response.statusCode);
      }
      if(response.statusCode == 201){
        var data = jsonDecode(response.body);
        if (kDebugMode) {
          print(data);
        }
        return true;
      }
    }
    catch(e){
      if (kDebugMode) {
        print(e);
      }
    }

    return false;
  }

}

