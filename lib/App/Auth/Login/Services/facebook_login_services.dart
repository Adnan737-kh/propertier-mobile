import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginServices {
  Future signInWithFacebook() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      if (kDebugMode) {
        print("AccessTOken ${accessToken.toJson()}");
      }
    } else {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {

      } else {
        if (kDebugMode) {
          print(result.status);
          print(result.message);
        }
      }

    }

    // final OAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    // final userCrediential = await FirebaseAuth.instance
    //     .signInWithCredential(facebookAuthCredential);
    // print("Facebook Auth ${userCrediential.user!.email}");
  }
}
