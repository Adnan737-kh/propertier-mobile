import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginServices {
  Future signInWithFacebook() async {
    Map<String, dynamic>? _userData;
    AccessToken _accessToken;
    bool _checking = true;
    final accessToken = await FacebookAuth.instance.accessToken;
    // final LoginResult loginResult = await FacebookAuth.instance.login();
    _checking = false;
    if (accessToken != null) {
      print("AccessTOken ${accessToken.toJson()}");
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
        print(result.status);
        print(result.message);
      }

      _checking = false;
    }

    // final OAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    // final userCrediential = await FirebaseAuth.instance
    //     .signInWithCredential(facebookAuthCredential);
    // print("Facebook Auth ${userCrediential.user!.email}");
  }
}
