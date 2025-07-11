
import '../../../data/network/network_api_services.dart';
import '../../../res/app_urls/app_url.dart';

class DeleteAccountRepo {
  final _apiServices = NetworkApiService();

  Future<dynamic> deleteAccount(String accessToken) async {
    dynamic response = _apiServices.deleteApi(AppUrls.deleteAccountApi,authToken: accessToken);
    return response;
  }
}