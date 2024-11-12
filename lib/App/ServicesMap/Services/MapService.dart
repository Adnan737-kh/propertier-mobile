import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';

class MapService{

  Future<Map<String,dynamic>?> getLocation(String id)async{
    try{
      String url = "${API.trackVendorLocation}$id/";
      print(url);
      var response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){
        final body = jsonDecode(response.body);
        print(body);
        return body;
      }
    }
    catch(e){
      print(e);
    }
  }

  Future cancelOrder(String id, String reason)async{
    String url = "${API.createOrder}$id/";
    final Map<String, dynamic> data = {
      "status": "canceled",
      "status_reason": reason,
    };

    final encodedData = jsonEncode(data);

    var response = await http.put(Uri.parse(url),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: encodedData,
    );
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }


}