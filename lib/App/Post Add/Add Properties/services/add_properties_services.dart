import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/Model/features_model.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/Network/http_multipart_request.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/res/app_urls/app_url.dart';

import '../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class AddPropertiesServices {
  UserPreference userPreference = UserPreference();
  RxnString accessToken = RxnString();
  final List<OverlayEntry> _overlayEntry = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final vm = Get.put(UploadPropertyViewModel());
  Future<Features> getFeatures() async {
    var features = Features();
    try {
      final response = await http.get(Uri.parse(API.featuresUrl));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (kDebugMode) {
          print("Featured Data ${decodedData['data']}");
        }
        features = Features.fromJson(jsonDecode(response.body));
      } else {
        if (kDebugMode) {
          print("Featured Data Error}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Featured Data $e}");
      }

    }
    return features;
  }

  void getAccessToken() async {
    var user = await userPreference.getUserAccessToken();
    if (kDebugMode) {
      print("@@@@@@ ${user.accessToken}");
    }
    if (user.accessToken != null) {
      accessToken.value = user.accessToken; // Updating observable variable
    }
  }

  Future<bool> uploadProperty({
    required List<String> galleryImage,
    required BuildContext context,
    required String agentID,
    required String title,
    required String price,
    required String purpose,
    required String type,
    required String bedroom,
    required String bathroom,
    required String city,
    required String address,
    required String area,
    required String areatype,
    required String image,
    required String shortVideo,
    required String video,
    required List<int> features,
    required String floor,
    required String description,
    required String areaUnit,
    String? accessToken,
  }) async {
    bool isSuccess = false;

    try {
      final uri = Uri.parse(API.uploadPropertyUrl);
      // Create the Multipart request
      var request = MultipartRequest(
        'POST',
        uri,
        onProgress: (int bytes, int total) {
          vm.showOverlay();
          RxDouble progress = (bytes / total).obs;
          showNotificationWithProgress(progress.value * 100);
          vm.changeValue(progress.value);
        },
      );

      request.fields['agent'] = agentID;
      if (title.isNotEmpty) request.fields['title'] = title;
      if (title.isNotEmpty) request.fields['slug'] = title;
      if (price.isNotEmpty) request.fields['price'] = price;
      if (description.isNotEmpty) request.fields['description'] = description;
      if (bathroom.isNotEmpty) request.fields['bathroom'] = bathroom;
      if (bedroom.isNotEmpty) request.fields['bedroom'] = bedroom;
      if (areaUnit.isNotEmpty) request.fields['area_unit'] = areaUnit;
      if (area.isNotEmpty) request.fields['area'] = area;
      // if (city.isNotEmpty) request.fields['city'] = city;
      // if (city.isNotEmpty) request.fields['city_slug'] = city;
      if (address.isNotEmpty) request.fields['address'] = address;
      if (purpose.isNotEmpty) request.fields['purpose'] = purpose;
      if (type.isNotEmpty) request.fields['type'] = type;
      if (areatype.isNotEmpty) request.fields['area_type'] = areatype;
      if (video.isNotEmpty) request.fields['video'] = video;
      if (floor.isNotEmpty) request.fields['floor'] = floor;

      // Add features list
      for (int i = 0; i < features.length; i++) {
        request.fields['Features[$i]'] = features[i].toString();
      }

      if (image.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          image,
        ));
      }

      if (galleryImage.isNotEmpty) {
        for (var img in galleryImage) {
          request.files
              .add(await http.MultipartFile.fromPath('GalleryImages', img));
        }
      }

      if (shortVideo.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('short_video', shortVideo));
      }
      // request.headers.addAll()

      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("Status COde is That ${response.headers}");
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print("Status COde is That ${response.body}");
        }
        var prprty = jsonDecode(response.body);
        var propertyId = prprty["id"];
        ("Status COde is That $propertyId");
        vm.hideOverlay();
        if (kDebugMode) {
          print("Uploading to: ${AppUrls.propertiesUploadUrl}");
        }
        final uri = Uri.parse(AppUrls.propertiesUploadUrl);
        final headers = {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $accessToken',
        };
        final body = jsonEncode({
          "property_id": propertyId,
          "features": features,
        });

        final responses = await http.post(uri, headers: headers, body: body);

        if (responses.statusCode == 201) {
          if (kDebugMode) {
            print('Features added successfully!');
          }
          Get.toNamed(AppRoutes.profileView);

        }
        if (kDebugMode) {
          print("Property Upload Successfully");
        }
        cancelNotification(0);
        isSuccess = true;
        showNotificationPropertyUpload();
        Future.delayed(const Duration(seconds: 2), () {
          cancelNotification(1);
        });
      } else {
        vm.hideOverlay();
        cancelNotification(0);
        isSuccess = true;

        print("Error is This : ${response.body}");
        //
      }
    } catch (e) {
      vm.hideOverlay();
      cancelNotification(0);
      isSuccess = true;
      if (kDebugMode) {
        print("catch Error is This:$e");
      }
      // toast(title: 'Something went wrong', context: context);
    }
    return isSuccess;
  }

  void showNotificationWithProgress(double progress) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1',
      'Propertier',
      importance: Importance.max,
      priority: Priority.high,
      showProgress: true,
      onlyAlertOnce: true,
      maxProgress: 100,
      progress: progress.toInt(),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'uploading',
      '${progress.toInt()} %',
      platformChannelSpecifics,
    );
  }

  void showNotificationPropertyUpload() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '2',
      'Propertier',
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      playSound: false,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      1,
      'uploaded',
      'Property Upload Successfully',
      platformChannelSpecifics,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  void _hidePersistentToast(BuildContext context) {
    for (var entry in _overlayEntry) {
      entry.remove();
    }
    _overlayEntry.clear();
  }
}

// void _showPersistentToast({
//   required BuildContext context,
//   required RxDouble progress,
// }) {
//   OverlayEntry entry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: context.getSize.height * 0.040,
//       left: 10,
//       // left: context.getSize.width * 0.2,
//       right: 10,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           alignment: Alignment.centerLeft,
//           height: context.getSize.height * 0.07,
//           width: context.getSize.width * 0.8,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10), color: Colors.white),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   appText(title: 'Uploading Property', context: context),
//                   progressText(progress, context)
//                 ],
//               ),
//               Spacer(),
//               loadingProgress(progress, context)
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
//   Future.delayed(const Duration(milliseconds: 300), () {
//     _overlayEntry.add(entry);
//     Overlay.of(context).insert(entry);
//   });
// }
