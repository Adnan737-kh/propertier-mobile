import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hex/hex.dart' as hex;
import 'package:propertier/Network/api_urls.dart';
import 'package:propertier/Vendor/screens/Auth/Login/Model/user_login_model/user_login_model.dart';
import 'package:http/http.dart' as http;
import '../../../../App/Auth/Service/google_sigin_services.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/app_text.dart';
import '../../../../constant/colors.dart';

class AuthService {
  final GetStorage _storage = GetStorage();

  Future<void> registerUser(UserLoginModel user, String password) async {
    final hashedPassword =
        password; // Implement secure hashing (explained earlier)

    var userjson = user.toJson();
    print(userjson);
    await _storage.write('id', user.users!.first.id);
    await _storage.write('userName', user.users!.first.name);
    await _storage.write('image', user.users!.first.profilePictureUrl);
    await _storage.write('coverImage', user.users!.first.coverPhotoUrl);
    await _storage.write('type', user.users!.first.type);
    await _storage.write('user', userjson);

    return;
  }

  Future<UserLoginModel?> getCurrentUser() async {
    final storedUser = _storage.read('user');
    if (storedUser != null) {
      return UserLoginModel.fromJson(storedUser);
    }
    return null;
  }

  final _auth = FirebaseAuth.instance;
  Future<void> logout() async {
    await _storage.remove('user');
    await _storage.remove('id');
    await _storage.remove('image');
    await _storage.remove('coverImage');
    await _storage.remove('userName'); // Clear user data on logout
    await _storage.remove('type');
    await _storage.remove('vendorUserId'); // Remove vendorUserId on logout
    await _storage.remove('featurePackageId'); // Remove vendorUserId on logout

    await _auth.signOut();
  }

  Future RegisterVendor(String email, String firebaseID) async {
    String url = API.venregisterUrl;

    final Map<String, dynamic> data = {
      "email": email.toLowerCase(),
      "firebase_id": firebaseID,
      "type": 'vendor', // Example default value
    };

    final encodedData = jsonEncode(data);

    try {
      final response = await http.post(
        Uri.parse("${API.venregisterUrl}/"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: encodedData,
      );

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: appText(
            title: 'Please login again.',
            context: Get.context!,
            color: AppColor.white,
          ),
        ));
        AuthService().logout();
        GoogleSiginServices().logout();
        Get.offAllNamed(AppRoutes.loginView);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: appText(
          title: 'Something went wrong: $e',
          context: Get.context!,
          color: AppColor.white,
        ),
      ));
    }
  }

  Future deleteVender() async {
    int? id;
    UserLoginModel? currentUser = await getCurrentUser();
    print(currentUser?.users?.first.type);
    if (currentUser != null) {
      for (var user in currentUser.users ?? []) {
        if (user.type == "vendor") {
          id = user.id;
        }
      }
    }
    if(id == null) return;

    String url = "${API.deleteVendorProfile}/${id}/";
    print(url);
    try {
      var response = await http.delete(Uri.parse(url));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 204) {
        AuthService().logout();
        GoogleSiginServices().logout();
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: appText(
            title: 'Vendor account deleted',
            context: Get.context!,
            color: AppColor.white,
          ),
        ));
        Get.offAllNamed(AppRoutes.loginView);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: appText(
          title: 'Something went wrong: $e',
          context: Get.context!,
          color: AppColor.white,
        ),
      ));
    }
  }
}

Future<String> decryptPassword(String encryptedPassword) async {
  List<int> encryptedBytes = hex.HEX.decode(encryptedPassword);
  final key = enc.Key.fromUtf8('awdrgyjilzsxdcfvbhjmawsdrfgyhjik');
  final iv = enc.IV.fromLength(16);
  final encrypter = enc.Encrypter(enc.AES(key));

  final decryptedBytes = encrypter.decryptBytes(
      enc.Encrypted(Uint8List.fromList(encryptedBytes)),
      iv: iv); //
  final decrypted = utf8.decode(decryptedBytes);
  return decrypted;
}
