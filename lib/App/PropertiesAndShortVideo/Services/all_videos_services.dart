import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Model/videos_model.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:http/http.dart' as http;

class VideosServices {
  Future<VideosModel> getVideos({
    required BuildContext context,
  }) async {
    VideosModel videosModel = VideosModel();
    try {
      final response = await http.get(Uri.parse(API.allVideosUrl));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        videosModel = VideosModel.fromJson(decodedJson);
      }
    } catch (e) {}
    return videosModel;
  }
}
