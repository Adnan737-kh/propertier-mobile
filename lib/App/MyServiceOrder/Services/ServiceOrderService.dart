import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';
import '../Model/ServiceOrderModel.dart';


class ServiceOrderService{

  Future<List<ServiceOrderModel>> getVendorOrders(String id)async{
    List<ServiceOrderModel> orders = [];
    try{
      String url = "${API.customerOrder}$id";
      print(url);
      var response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        for(var d in data){
          ServiceOrderModel orderModel = ServiceOrderModel.fromJson(d);
          orders.add(orderModel);
        }
      }
    }
    catch(e){
      print(e);
    }
    print(orders.length);
    return orders;
  }

  Future<Map<String,dynamic>?> getSubService(String id)async{
    try{
      String url = "${API.getSubService}$id";
      print(url);
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        return data;
      }
    }
    catch(e){
      print(e);
    }
  }


  Future<bool> acceptSubmition(String id)async{
    try{
      String url = "${API.createOrder}$id/";
      print(url);
      var data = {
        "submission_status": "accepted",
        "status": "completed"
      };
      var encodedData = jsonEncode(data);

      var response = await  http.put(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
        body: encodedData
      );
      print(response.statusCode);
      if(response.statusCode == 200){
        return true;
      }
    }
    catch(e){
      print(e);
    }
    return false;
  }


  Future<bool> rejectSubmition(String id)async{
    try{
      String url = "${API.createOrder}$id/";
      print(url);
      var data = {
        "submission_status": "rejected",
      };
      var encodedData = jsonEncode(data);

      var response = await  http.put(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: encodedData
      );
      print(response.statusCode);
      if(response.statusCode == 200){
        return true;
      }
    }
    catch(e){
      print(e);
    }
    return false;
  }

}