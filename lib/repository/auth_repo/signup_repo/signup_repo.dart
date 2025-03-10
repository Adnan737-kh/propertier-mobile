import 'package:propertier/data/network/network_api_services.dart';
import 'package:propertier/res/app_urls/app_url.dart';

class SignUpRepository{

  final _apiServices = NetworkApiService();

  Future<dynamic> signup(var data)async {

    dynamic response = _apiServices.postApi(data,AppUrls.signUpApi);
    return response;
  }


  Future<dynamic> verifyOtp(var data) async {
    String verifyUrl = await AppUrls.verifyOtpApi;  // ✅ Await the URL before using it
    dynamic response = await _apiServices.postApi(data, verifyUrl);  // ✅ Await API call
    return response;
  }

  Future<dynamic> verifyForgotPasswordOtp(var data,) async {
    String verifyUrl = await AppUrls.verifyForgotPasswordOtpApi;  // ✅ Await the URL before using it
    dynamic response = await _apiServices.postApi(data, verifyUrl);  // ✅ Await API call
    return response;
  }

}