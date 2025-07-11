import 'package:propertier/data/network/network_api_services.dart';
import 'package:propertier/res/app_urls/app_url.dart';

class LoginRepository {
  final _apiServices = NetworkApiService();

  Future<dynamic> login(var data) async {
    dynamic response = _apiServices.postApi(data, AppUrls.loginApi);
    return response;
  }

  Future<dynamic> forgotPassword(var data) async {
    dynamic response = _apiServices.postApi(data, AppUrls.sendForgotPasswordOtpUrl);
    return response;
  }

  Future<dynamic> reSetForgotPassword(var data) async {
    String resetConfirmPassword = await AppUrls.restConfirmPasswordFn;
    dynamic response = await _apiServices.postApi(data, resetConfirmPassword);
    return response;
  }

  Future<dynamic> changePassword(var data,String accessToken) async {
    String changePassword =  AppUrls.changePasswordUrl;
    dynamic response = await _apiServices.putApi(data, changePassword,authToken: accessToken);
    return response;
  }
}
