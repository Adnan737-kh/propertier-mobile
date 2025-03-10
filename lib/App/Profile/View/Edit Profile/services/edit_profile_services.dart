import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:propertier/App/Auth/Login/Model/login_response_model.dart';
import 'package:propertier/constant/toast.dart';
import '../../../../../res/app_urls/app_url.dart';

class EditProfileServices  {



  Future<UserData?> editProfile({
    required BuildContext context,
    required String id,
    required String password,
    required String profileImage,
    required String coverImage,
    required String name,
    required String email,
    required String phoneNumber,
    required String phoneNumberCountryCode,
    required String latitudePosition,
    required String longitudePosition,
    required String address,
    required String about,
  }) async {
    UserData? model;
    try {
      final uri = Uri.parse(AppUrls.editProfileUrl);
      final request = http.MultipartRequest('POST', uri);
      request.fields['id'] = id;
      if (name != '') {
        request.fields['name'] = name;
      }

      request.fields['email'] = email.toLowerCase();
      if (phoneNumber != '') {
        request.fields['phone_number'] = phoneNumber;
      }
      if (phoneNumberCountryCode != '') {
        request.fields['phone_number_country_code'] = phoneNumberCountryCode;
      }
      if (address != '') {
        request.fields['address'] = address;
      }
      if (latitudePosition != '') {
        request.fields['latitude_position'] = latitudePosition;
      }
      if (address != '') {
        request.fields['longitude_position'] = longitudePosition;
      }
      print("Password is $password");
      if (password != '') {
        request.fields['password'] = password;
      }
      if (about != '') {
        request.fields['about'] = about;
      }
      if (profileImage != '') {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_picture',
          profileImage,
        ));
      }

      if (coverImage != '') {
        request.files.add(await http.MultipartFile.fromPath(
          'cover_picture',
          coverImage,
        ));
      }
      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        model = UserData.fromJson(decodedData);

        toast(title: 'Profile Update Successfully', context: context);
      } else {
        toast(title: 'Something went wrong', context: context);
      }
    } catch (e) {
      toast(title: 'Something went wrong', context: context);
    }
    return model;
  }


}
