import '../../../data/network/network_api_services.dart';
import '../../../res/app_urls/app_url.dart';

class ViewPropertyDetailsRepository{
  final _apiServices = NetworkApiService();

  Future<dynamic> viewPropertyDetails(int id) async {
    dynamic response = await _apiServices.getApi(
      AppUrls.profileDetailUrl,
      authToken: id.toString(),
    );
    return response;
  }
}