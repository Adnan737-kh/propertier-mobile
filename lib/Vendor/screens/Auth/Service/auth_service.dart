import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:get_storage/get_storage.dart';
import 'package:hex/hex.dart' as hex;
import 'package:propertier/Vendor/screens/Auth/Login/Model/user_login_model/user_login_model.dart';

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
}

Future<String> decryptPassword(String encryptedPassword) async {
  List<int> encryptedBytes = hex.HEX.decode(encryptedPassword);
  final key = Key.fromUtf8('awdrgyjilzsxdcfvbhjmawsdrfgyhjik');
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));

  final decryptedBytes = encrypter
      .decryptBytes(Encrypted(Uint8List.fromList(encryptedBytes)), iv: iv); //
  final decrypted = utf8.decode(decryptedBytes);
  return decrypted;
}
