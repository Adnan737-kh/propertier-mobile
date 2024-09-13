import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/constant/toast.dart';

class CustomerRequest {
  Future<bool> addRequest({
    required BuildContext context,
    required String name,
    required String phoneNumber,
    required String email,
    required String city,
    required String area,
    required String area_unit,
    required String min_price,
    required String max_price,
    required String size,
    required String type,
    required String purpose,
    required String longitude,
    required String latitude,
    required String description,
    required String agent,
  }) async {
    var responsed = false;
    try {
      final uri = Uri.parse(API.customerRequestUrl);

      final request = http.MultipartRequest('POST', uri);
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['phone_number'] = phoneNumber;
      request.fields['city'] = city;
      request.fields['area'] = area;
      request.fields['area_unit'] = area_unit;
      request.fields['max_price'] = max_price;
      request.fields['min_price'] = min_price;
      request.fields['agent'] = agent;
      request.fields['longitude'] = longitude;
      request.fields['latitude'] = latitude;
      request.fields['size'] = size;
      request.fields['type'] = type;
      request.fields['purpose'] = purpose;
      request.fields['description'] = description;

      final response = await http.Response.fromStream(await request.send());
      print("Status code is that ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        toast(title: 'Requested Successfully', context: context);
        responsed = false;
      } else {
        toast(title: 'Something went wrong', context: context);
      }
    } catch (e) {
      toast(title: 'Something went wrong', context: context);
    }
    return responsed;
  }
}
