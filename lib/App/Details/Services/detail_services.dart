import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:propertier/App/Details/Model/specific_property_model.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/api_urls.dart';

class DetailServices {
  Future<SpecificPropertyModel> getDetailServices({required int id}) async {
    SpecificPropertyModel specificPropertyModel = SpecificPropertyModel();

    try {
      final response = await http.get(
        Uri.parse("${API.propertyDetailUrl}?property_id=$id"),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
      if (kDebugMode) {
        print("Property Details Response ${response.body}");
      }
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        specificPropertyModel = SpecificPropertyModel.fromJson(decodedData);
      }
    } catch (e) {}
    return specificPropertyModel;
  }
}
