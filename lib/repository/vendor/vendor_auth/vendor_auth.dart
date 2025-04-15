import '../../../data/network/network_api_services.dart';
import '../../../res/app_urls/app_url.dart';

class VendorRegisterRepository{

  final _apiServices = NetworkApiService();

  Future<dynamic> registerVendor(var data,String accessToken)async {

    dynamic response = _apiServices.postApi(data,AppUrls.vendorsApi,authToken: accessToken);
    return response;
  }
}