import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:propertier/constant/toast.dart';

class GoogleSigInServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<UserCredential?> loginWithGoogle() async {
    try {
      // GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      if (kDebugMode) {
        print("Error during Google sign in: $error");
      }
      CustomToast.show(title: "Error", context: Get.context!);
      return null;
    }
  }

  Future<String> getIdToken() async {
    return await _auth.currentUser!.getIdToken() ?? '';
  }

  Future logout() async {
    await _googleSignIn.disconnect();
    await _auth.signOut();
  }
}
