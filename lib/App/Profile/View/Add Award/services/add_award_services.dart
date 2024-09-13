import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
// import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/constant/toast.dart';

class AddAwardServices {
  Future<bool> addAward({
    required BuildContext context,
    required String title,
    required File image,
    required String description,
    required String agentId,
    required String date,
  }) async {
    print(date);
    bool responsed = false;
    try {
      print(agentId);
      final uri = Uri.parse(API.addAwardUrl);
      // var stream= http.ByteStream(image.openRead());
      // stream.cast();
      // var length = await image.
      final request = http.MultipartRequest('POST', uri);
      print(title);
      request.fields['agent'] = agentId;
      if (title != '') {
        request.fields['title'] = title;
      }
      // print(
      //     "${DateFormat.y().format(DateTime.parse(date))}-${DateFormat.M().format(DateTime.parse(date))}-${DateFormat.d().format(DateTime.parse(date))}");
      if (date != '') {
        request.fields['date'] = date;
        // "${DateFormat.y().format(DateTime.parse(date))}-${DateFormat.M().format(DateTime.parse(date))}-${DateFormat.d().format(DateTime.parse(date))}";
        // "${DateFormat.y().format(DateTime.parse(date))}-${DateFormat.M().format(DateTime.parse(date))}-${DateFormat.d().format(DateTime.parse(date))}";
      }
      if (description != '') {
        request.fields['description'] = description;
      }
      if (image.path != '') {
        String? mime = lookupMimeType(image.path);

        request.files.add(await http.MultipartFile.fromPath('image', image.path,
            contentType: MediaType.parse(mime!)));
      }

      final response = await http.Response.fromStream(await request.send());
      // final response = await request.send();
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        responsed = true;
        // responsed = response.body;

        toast(title: 'Award Added Successfully', context: context);
      } else {
        toast(title: 'Something went wrong', context: context);
      }
    } catch (e) {
      toast(title: 'Something went wrong', context: context);
    }
    return responsed;
  }
}
