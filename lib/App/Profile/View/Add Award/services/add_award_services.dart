import 'dart:io';

import 'package:flutter/foundation.dart';
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
    required String accessToken,
    required String date,
  }) async {
    print(date);
    bool response = false;
    try {
      if (kDebugMode) {
        print('user access token uploading award $accessToken');
      }
      final uri = Uri.parse(API.addAwardUrl);
      print('url ${API.addAwardUrl}');
      final request = http.MultipartRequest('POST', uri);
      if (kDebugMode) {
        print(title);
      }

      request.headers['Authorization'] = 'Bearer $accessToken';
      // request.fields['agent'] = accessToken;
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

      final dataResponse = await http.Response.fromStream(await request.send());
      print("award response ${dataResponse.statusCode}");
      if (dataResponse.statusCode == 200 || dataResponse.statusCode == 201) {
        response = true;

        toast(title: 'Award Added Successfully', context: context);
      } else {
        toast(title: 'Something went wrong', context: context);
      }
    } catch (e) {
      toast(title: 'Something went wrong', context: context);
    }
    return response;
  }
}
