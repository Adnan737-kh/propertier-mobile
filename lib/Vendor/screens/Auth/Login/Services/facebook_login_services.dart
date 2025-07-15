import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginServices {
  Future signInWithFacebook() async {
    Map<String, dynamic>? _userData;
    AccessToken _accessToken;
    bool _checking = true;
    final accessToken = await FacebookAuth.instance.accessToken;
    _checking = false;
    if (accessToken != null) {
      if (kDebugMode) {
        print("AccessTOken ${accessToken.toJson()}");
      }
      final data = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      _userData = data;
    } else {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        _accessToken = result.accessToken!;

        final userData = await FacebookAuth.instance.getUserData();
        _userData = userData;
      } else {
        if (kDebugMode) {
          print(result.status);
          print(result.message);
        }
      }

      _checking = false;
    }
  }
}
