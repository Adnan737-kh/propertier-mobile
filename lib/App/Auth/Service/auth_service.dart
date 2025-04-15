
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
// import '../Login/Model/login_response_model.dart';
// import 'package:hex/hex.dart' as hex;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../Login/Model/user_login_model/user_login_model.dart';

class AuthService {
  final GetStorage _storage = GetStorage();

  Future<void> registerUser(UserLoginModel user, String password) async {
    var userJson = user.toJson();
    log(userJson.toString());
    await _storage.write('id', user.users!.first.id);
    await _storage.write('userName', user.users!.first.name);
    await _storage.write('image', user.users!.first.profilePictureUrl);
    await _storage.write('coverImage', user.users!.first.coverPhotoUrl);
    await _storage.write('user', userJson);
    await _storage.write('user_type', user.users?.first.type);

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
    await _auth.signOut();
  }
}
