
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';
import 'package:http/http.dart' as http;
import '../../../Network/api_urls.dart';
import '../../../Utils/app_text.dart';
import '../../../constant/colors.dart';



class ServicessearchService{

  Future<String?> createBidByCustomer({required BuildContext context, required List<String> images, required String service,required String subService, required String description, String? vendorId})async{
    try{
      var request = http.MultipartRequest("POST", Uri.parse(API.createBidByCustomer));

      for(String image in images){
        var imageFile = await http.MultipartFile.fromPath(
          'images',
          image,
          filename: basename(image),
        );
        request.files.add(imageFile);
      }

      request.fields['customer'] = GetStorage().read('id').toString();
      request.fields['service'] = service;
      request.fields['selected_sub_services'] = subService;
      request.fields['location'] = 'sample address, Lahore, Pakistan';
      request.fields['latitude'] = "00.0000";
      request.fields['longitude'] = "00.0000";
      request.fields['description'] = description;
      request.fields['status'] = 'pending';
      if(vendorId != null){
        request.fields['vendor'] = vendorId;
      }
      print(request.fields);
      var response = await request.send();
      print(response.statusCode);
      print(await response.stream.bytesToString());
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: 'Your Request is online, Please Wait...',
                context: context,
                color: AppColor.white)));
        final responseBody = await response.stream.bytesToString();
        var jsonDecodeBody = jsonDecode(responseBody);
        return jsonDecodeBody['id'].toString();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: 'Something went wrong.',
                context: context,
                color: AppColor.white)));
      }
    }
    catch(e){
      print("error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: e.toString(),
              context: context,
              color: AppColor.white)));
    }

    return null;
  }


  Future acceptBid(BuildContext context, String id, String status)async{
    try{
      String url = "${API.offerByVendor}$id/";
      print(url);
      var request = http.MultipartRequest("PATCH", Uri.parse(url));
      request.fields['status'] = status;
      var response = await request.send();
      print(response.statusCode);
    }
    catch(e){
      print("error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: e.toString(),
              context: context,
              color: AppColor.white)));
    }
  }

  Future finalizeBid(BuildContext context, String id,String status, String vendorId)async{
    try{
      String url = "${API.offerByVendor}$id/";
      print(url);
      var request = http.MultipartRequest("PATCH", Uri.parse(url));
      request.fields['status'] = status;
      request.fields['vendor'] = vendorId;
      var response = await request.send();
      print(response.statusCode);
    }
    catch(e){
      print("error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: e.toString(),
              context: context,
              color: AppColor.white)));
    }
  }


  Future<bool> createOrder({required BuildContext context,required String bidId,required String vendorId,required String customerId,required String serviceId,required String subServiceId,required String serviceLocation,required String status, required String paymentStatus})async{
    try{
      String url = "${API.createOrder}";
      print(url);
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.fields['vendor'] = vendorId;
      request.fields['bid'] = bidId;
      request.fields['customer'] = customerId;
      request.fields['service'] = serviceId;
      request.fields['service location'] = serviceLocation;
      request.fields['selected_sub_services'] = subServiceId;
      request.fields['status'] = status;
      request.fields['payment_status'] = paymentStatus;

      print(request.fields);

      var response = await request.send();
      print(response.statusCode);
      var data = await response.stream.bytesToString();
      print(data);
      if(response.statusCode == 201){
        return true;
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: data.toString(),
                context: context,
                color: AppColor.white)));
      }
    }
    catch(e){
      print("error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: e.toString(),
              context: context,
              color: AppColor.white)));
    }

    return false;
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

}
