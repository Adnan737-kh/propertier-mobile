
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';
import 'package:http/http.dart' as http;

import '../../../Network/api_urls.dart';
import '../../../Utils/app_text.dart';
import '../../../constant/colors.dart';



class ServicesCore{

  Future<List<FixedServicesModel>> getFixedServices({required BuildContext context})async{
    List<FixedServicesModel> services = [];
    // try{
      final response = await http.get(Uri.parse(API.fixedServices));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        // print("home data response: ${decodedJson}");
        for(var data in decodedJson){
          services.add(FixedServicesModel.fromJson(data));
        }
        return services;

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: 'Something went wrong.',
                context: context,
                color: AppColor.white)));
      }
    // }
    // catch(e){
    //   print("error: $e");
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: appText(
    //           title: e.toString(),
    //           context: context,
    //           color: AppColor.white)));
    // }

    return services;
  }
}
