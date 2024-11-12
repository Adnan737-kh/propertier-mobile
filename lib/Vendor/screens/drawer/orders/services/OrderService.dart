import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';
import '../model/OrderModel.dart';

class OrderService{

  Future<List<OrderModel>> getVendorOrders(String id)async{
    List<OrderModel> orders = [];
    try{
      String url = "${API.vendorOrder}$id";
      print(url);
      var response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        for(var d in data){
          OrderModel orderModel = OrderModel.fromJson(d);
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

  Future<bool> submitWork(String id, List<String> images, String extraPrice, String description)async{
    try{
      String url = "${API.createOrder}$id/";
      print(url);
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['work_description'] = description;
      request.fields['extra_price'] = extraPrice;

      for(String img in images){
        var imageFile = await http.MultipartFile.fromPath(
          'images',
          img,
        );
        request.files.add(imageFile);
      }

      // Send the request
      var response = await request.send();

      print(response.statusCode);

      if(response.statusCode == 200){
        return true;
      }

      final responseBody = await response.stream.bytesToString();
      print(responseBody);

    }
    catch(e){
      print(e);
    }
    return false;
  }
}