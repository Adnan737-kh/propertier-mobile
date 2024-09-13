import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/constant/toast.dart';

import 'Model/isLiked.dart';

class LikeAndUnlikeServices {
  Future<dynamic> likeService({
    required BuildContext context,
    required String agentId,
    required String propertyId,
  }) async {
    try {
      final uri = Uri.parse(API.likePropertyUrl);
      final request = http.MultipartRequest('POST', uri);
      request.fields['agent_id'] = agentId;

      if (propertyId != '') {
        request.fields['property_id'] = propertyId;
      }
      var responsed = await http.Response.fromStream(await request.send());
      // print("Status code is that ${response.statusCode}" );
      if (responsed.statusCode == 200) {
        // toast(title: 'Liked Successfully', context: context);
        return responsed.body;
      } else {
        toast(title: 'Something went wrong', context: context);
      }
    } catch (e) {
      toast(title: 'Something went wrong', context: context);
    }
  }

  Future<IsLiked> getProperty(
      {required String propertyId, required String agentId}) async {
    var Isliked = IsLiked();
    try {
      final uri = Uri.parse(API.isLikedPropertyUrl);
      final request = http.MultipartRequest('POST', uri);
      request.fields['agent_id'] = agentId;

      if (propertyId != '') {
        request.fields['property_id'] = propertyId;
      }
      var responsed = await http.Response.fromStream(await request.send());
      if (responsed.statusCode == 200) {
        var data = jsonDecode(responsed.body);
        Isliked = IsLiked.fromJson(data);
        // return property;
        // toast(title: 'Successfully', context: Get.context!);
      } else {
        toast(title: 'Something went wrong', context: Get.context!);
      }
    } catch (e) {
      toast(title: 'Something went wrong', context: Get.context!);
    }
    return Isliked;
  }
}
