import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginServices {
  Future signInWithFacebook() async {
    Map<String, dynamic>? userData0;
    AccessToken accessToken0;
    bool checking = true;
    final accessToken = await FacebookAuth.instance.accessToken;
    // final LoginResult loginResult = await FacebookAuth.instance.login();
    checking = false;
    if (accessToken != null) {
      print("AccessTOken ${accessToken.toJson()}");
      final data = await FacebookAuth.instance.getUserData();
      accessToken0 = accessToken;
      userData0 = data;
    } else {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        accessToken0 = result.accessToken!;

        final userData = await FacebookAuth.instance.getUserData();
        userData0 = userData;
      } else {
        print(result.status);
        print(result.message);
      }

      checking = false;
    }

    // final OAuthCredential facebookAuthCredential =
    //     FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    // final userCrediential = await FirebaseAuth.instance
    //     .signInWithCredential(facebookAuthCredential);
    // print("Facebook Auth ${userCrediential.user!.email}");
  }
}
