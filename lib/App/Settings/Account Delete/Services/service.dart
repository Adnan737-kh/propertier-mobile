import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Profile/Model/profile_model.dart';
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:http/http.dart' as http;

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../Auth/Service/auth_service.dart';
import '../../../Auth/Service/google_sigin_services.dart';

class AccountDeleteApi {
  Future<ProfileModel> doAccountDelete({
    required BuildContext context,
    required String id,
  }) async {
    ProfileModel profileDetailModel = ProfileModel();
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      var token = await auth.currentUser!.getIdToken();
      final response = await http
          .delete(Uri.parse("${API.accountDeleteUrl}$id/"), headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${token!}"
      });
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        AuthService().logout();
        GoogleSiginServices().logout();
        Get.offAllNamed(AppRoutes.navBarView);
        // profileDetailModel = ProfileModel.fromJson(decodedJson);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: appText(
                title: response.body.toString(),
                context: context,
                color: AppColor.white)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: appText(
            title: e.toString(), context: context, color: AppColor.white),
      ));
    }
    return profileDetailModel;
  }
}
