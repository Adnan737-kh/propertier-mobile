import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../App/Auth/Login/Services/login_services.dart';
import '../../App/Auth/Service/auth_service.dart';

class AuthHandler {
  static Future<bool> signInHandler(AuthHandlerEnum type) async {
    bool isSuccess = false;
    try {
      if (type == AuthHandlerEnum.google) {
        var user = await signInWithGoogle();
        if (user?.credential != null) {
          var token = await user?.user!.getIdToken();
          await LoginServices()
              .loginUser(context: Get.context!, password: token ?? '')
              .then((value) {
            if (value != null) {
              AuthService().registerUser(value, "");
              return isSuccess = true;
            } else {
              return false;
            }
          });
        } else {
          return false;
        }
      } else if (type == AuthHandlerEnum.facebook) {
      } else if (type == AuthHandlerEnum.apple) {
        var user = await signInWithApple();
        if (user?.credential != null) {
          var token = await user?.user!.getIdToken();

          await LoginServices()
              .loginUser(context: Get.context!, password: token!)
              .then((value) {
            if (value != null) {
              AuthService().registerUser(value, "");
              return isSuccess = true;
            } else {
              return false;
            }
          });
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
    return isSuccess;
  }

  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // export PATH="$PATH":"$HOME/.pub-cache/bin"

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<bool> signInWithEmailAndPassword(
      String email, String password) async {
    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (user.credential != null) {
      var token = await user.user!.getIdToken();
      await LoginServices()
          .loginUser(context: Get.context!, email: email, password: token ?? '')
          .then((value) {
        if (value != null) {
          AuthService().registerUser(value, "");
        } else {
          return false;
        }
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> signUpWithEmailAndPassword(
      String email, String password) async {
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (user.user != null) {
      var token = await user.user!.getIdToken();
      await LoginServices()
          .loginUser(context: Get.context!, email: email, password: token ?? '')
          .then((value) {
        if (value != null) {
          AuthService().registerUser(value, "");
        } else {
          return false;
        }
      });
      return true;
    } else {
      return false;
    }
  }

  static Future<UserCredential?> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    try {
      return await FirebaseAuth.instance.signInWithProvider(appleProvider);
    } catch (e) {
      return null;
    }
  }
}

enum AuthHandlerEnum {
  google,
  apple,
  facebook,
}
