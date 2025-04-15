import 'package:shared_preferences/shared_preferences.dart';

class AppUrls {
  static const baseUrl = "https://api.thepropertier.com";
  static const secondaryUrl = "api/mob/v1";
  static const signUpApi = "$baseUrl/api/auth/user/register/";
  static const loginApi = "$baseUrl/api/auth/user/login/";
  static const profileApi = "$baseUrl/api/auth/user/profile/";
  static const verifyEmail = "$baseUrl/api/auth/verify-email/";
  static const profileUrl = "$baseUrl/api/auth/user/profile/";
  static const profileDetailUrl = '$baseUrl/$secondaryUrl/profile/';
  static const servicesProfileDetailUrl = '$baseUrl/$secondaryUrl/user-profiles';
  static const editProfileUrl = "$baseUrl/api/mob/v1/update-customer-info/";
  static const propertiesUploadUrl = "$baseUrl/api/my-properties/";
  static const userVerificationUrl = "$baseUrl/api/verification-requests/";

  static const sendForgotPasswordOtpUrl =
      "$baseUrl/api/auth/user/send-reset-password-email/";
  static const verifyForgotPasswordOtpUrl =
      "$baseUrl/api/auth/user/reset-password/verify/";
  static const restPasswordUrl =
      "$baseUrl/api/auth/user/reset-password/confirm/";

  // Vendor
  static const vendorsApi = "$baseUrl/api/vendors";


  // ✅ Static getter for verifyOtpApi (fetches OTP token dynamically)
  static Future<String> get verifyOtpApi async {
    final prefs = await SharedPreferences.getInstance();
    String? otpToken = prefs.getString('otp_token');
    print('otpToken $otpToken');
    return "$verifyEmail${otpToken ?? ''}/";
  }

  static Future<String> get verifyForgotPasswordOtpApi async {
    final prefs = await SharedPreferences.getInstance();
    String? otpToken = prefs.getString('token');
    String? uid = prefs.getString('uid');
    return "$verifyForgotPasswordOtpUrl$uid/${otpToken ?? ''}/";
  }

  static Future<String> get restConfirmPasswordFn async {
    final prefs = await SharedPreferences.getInstance();
    String? resetApprovalToken = prefs.getString('reset_approval_token');
    String? uid = prefs.getString('uid');
    return "$restPasswordUrl$uid/${resetApprovalToken ?? ''}/";
  }

}
