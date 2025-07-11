import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/constant/toast.dart';

import '../Model/request_model.dart';

class RequestDemandServices {
  Future<CRequests> requestService({
    required BuildContext context,
    required String agentId,
  }) async {
    var responsed = CRequests();
    try {
      final uri = Uri.parse("${API.requestPropertiesUrl}?agent_id=$agentId");
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        responsed = CRequests.fromJson(jsonDecode(response.body));
        CustomToast.show(title: 'Successfully', context: context);
      } else {
        CustomToast.show(title: 'Something went wrong', context: context);
      }
    } catch (e) {
      CustomToast.show(title: 'Something went wrong', context: context);
    }
    return responsed;
  }
}
