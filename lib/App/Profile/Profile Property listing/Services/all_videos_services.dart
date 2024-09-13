import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:propertier/App/PropertiesAndShortVideo/Model/videos_model.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:http/http.dart' as http;

import '../../../PropertiesAndShortVideo/Model/all_properties_model.dart';

// import '../Model/videos_model.dart';

class VideosServices {
  Future<AllPropertiesModel> getVideos({
    required BuildContext context,
  }) async {
    AllPropertiesModel videosModel = AllPropertiesModel();
    try {
      final response = await http.get(Uri.parse(API.allVideosUrl));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        videosModel = AllPropertiesModel.fromJson(decodedJson);
      }
    } catch (e) {}
    return videosModel;
  }
}
