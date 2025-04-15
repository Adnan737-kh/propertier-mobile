import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:propertier/App/Home/Model/home_model.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:http/http.dart' as http;

import '../../../Model/property.dart';

class HomeServices {
  Future<HomeModel> getHomeData({
    required BuildContext context,
  }) async {
    HomeModel homeModel = HomeModel();
    try {
      print('home data call' );
      final response = await http.get(Uri.parse(API.homeDataUrl));
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        print('home data $decodedJson' );

        homeModel = HomeModel.fromJson(decodedJson);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: 'Something went wrong.',
                context: context,
                color: AppColor.white)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: 'Something went wrong.',
              context: context,
              color: AppColor.white)));
      print('home data ${e}' );

    }
    return homeModel;
  }

  Future<List<Property>> getShortVideoData({
    required BuildContext context,
  }) async {
    List<Property> shortVideoModel = <Property>[];
    try {
      final response = await http.get(Uri.parse(API.homeDataUrl));
      if (response.statusCode == 200) {
        // final decodedJson = jsonDecode(response.body);

        // decodedJson['data']['shortVideos']
        //     .forEach((data) => shortVideoModel.add(Property.fromJson(data)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: 'Something went wrong getShortVideoData.',
                context: context,
                color: AppColor.white)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: appText(
              title: 'Something went wrong getShortVideoData $e.',
              context: context,
              color: AppColor.white)));
    }
    return shortVideoModel;
  }
}
