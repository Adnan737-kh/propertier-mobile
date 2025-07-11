import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:propertier/App/Auth/User/model/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Profile/Model/profile_model.dart';

class UserPreference {
  RxnString accessToken = RxnString();
  Future<bool> saveUserAccessToken(TokenModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        'access_token', userModel.accessToken.toString());
    return true;
  }

  Future<TokenModel> getUserAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userToken = sharedPreferences.getString('access_token');
    return TokenModel(accessToken: userToken);
  }

  Future<bool> saveUserProfileData(UserProfile userModel) async {
    try {

      if (kDebugMode) {
        print('save number status ${userModel.verificationStatus.toString()}');
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('user_name', userModel.name.toString());
      sharedPreferences.setString('user_email', userModel.email.toString());
      sharedPreferences.setString(
          'user_phone', userModel.phoneNumber.toString());
      sharedPreferences.setString('user_address', userModel.address.toString());
      sharedPreferences.setString(
          'user_profile_picture', userModel.profilePictureUrl.toString());
      sharedPreferences.setString('user_about', userModel.about.toString());
      sharedPreferences.setString('general_verification_status',
          userModel.verificationStatus.toString());
      sharedPreferences.setString(
          'email_verification_status', userModel.emailVerificationStatus.toString());
      sharedPreferences.setString('phone_number_verification_status',
          userModel.phoneNumberVerificationStatus.toString());
      sharedPreferences.setString('cnic_verification_status', userModel.cnicVerificationStatus.toString());
      sharedPreferences.setString('selfie_verification_status', userModel.selfieVerificationStatus.toString());
      sharedPreferences.setString('business_address_verification_status',
          userModel.addressVerificationStatus.toString());
      sharedPreferences.setString('profile_picture_verification_status',
          userModel.profilePictureVerificationStatus.toString());
      sharedPreferences.setString('vendor', userModel.vendor.toString());
      sharedPreferences.setBool('requires_profile_completion', userModel.requiresProfileCompletion!);
      if (userModel.id != null) {
        sharedPreferences.setInt('id', userModel.id!);
      }
      if (userModel.vendor != null) {
        final vendorJson = jsonEncode(userModel.vendor!.toJson());
        sharedPreferences.setString('vendor', vendorJson);
      } else {
        sharedPreferences.setString('vendor', 'no vendor'); // explicitly mark it
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Error in saveUserProfileData: $e");
      }
      return false;
    }
  }

  Future<UserProfile?> getUserProfileData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userName = sharedPreferences.getString('user_name');
    String? email = sharedPreferences.getString('user_email');
    String? phone = sharedPreferences.getString('user_phone');
    String? address = sharedPreferences.getString('user_address');
    String? profilePicture = sharedPreferences.getString('user_profile_picture');
    String? about = sharedPreferences.getString('user_about');
    String? verificationStatus = sharedPreferences.getString('general_verification_status');
    String? emailVerificationStatus = sharedPreferences.getString('email_verification_status');
    bool? requiresProfileCompletion = sharedPreferences.getBool('requires_profile_completion');
    Vendor? vendor;
    String? vendorJson = sharedPreferences.getString('vendor');

    if (vendorJson != null && vendorJson != 'no vendor' && vendorJson != 'null') {
      try {
        final decoded = jsonDecode(vendorJson);
        if (decoded is Map<String, dynamic>) {
          vendor = Vendor.fromJson(decoded);
        } else {
          if (kDebugMode) {
            print("Decoded vendor is not a valid Map.");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error decoding vendor JSON: $e");
        }
      }
    } else {
      if (kDebugMode) {
        print("Vendor is not set or marked as 'no vendor'");
      }
      vendor = null;
    }

    String? phoneNumberVerificationStatus =
        sharedPreferences.getString('phone_number_verification_status');
    String? cnicVerificationStatus = sharedPreferences.getString('cnic_verification_status');
    String? selfieVerificationStatus = sharedPreferences.getString('selfie_verification_status');
    String? addressVerificationStatus =
        sharedPreferences.getString('business_address_verification_status');
    String? profilePictureVerificationStatus =
        sharedPreferences.getString('profile_picture_verification_status');
    int? id = sharedPreferences.getInt('id');

    return UserProfile(
      about: about,
      name: userName,
      email: email,
      phoneNumber: phone,
      address: address,
      profilePictureUrl: profilePicture,
      id: id,
      coverPhotoUrl: null,
      verificationStatus: verificationStatus,
      vendor: vendor,
      emailVerificationStatus: emailVerificationStatus,
      phoneNumberVerificationStatus: phoneNumberVerificationStatus,
      addressVerificationStatus: addressVerificationStatus,
      profilePictureVerificationStatus: profilePictureVerificationStatus,
      cnicVerificationStatus: cnicVerificationStatus,
      selfieVerificationStatus: selfieVerificationStatus,
      requiresProfileCompletion: requiresProfileCompletion,
      createdAt: null,
    );
  }
  Future<bool> logOut() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final success = await sharedPreferences.clear();
    if (kDebugMode) {
      print('🔁 Logout Clear Success: $success');
      // Optional: log remaining keys
      print('🔍 Remaining Keys After Clear: ${sharedPreferences.getKeys()}');

    }


    return success;
  }
}
