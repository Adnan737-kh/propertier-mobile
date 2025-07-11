import '../../../data/network/network_api_services.dart';
import '../../../res/app_urls/app_url.dart';

class VendorRepository{

  final _apiServices = NetworkApiService();

  Future<dynamic> registerVendor(var data,String accessToken)async {

    dynamic response = _apiServices.postApi(data,AppUrls.vendorProfileUrl,authToken: accessToken);
    return response;
  }

  Future<dynamic> viewVendorProfileDetails(String accessToken) async {
    dynamic response = await _apiServices.getApi(
      AppUrls.vendorProfileUrl,
      authToken: accessToken,
    );
    return response;
  }
}