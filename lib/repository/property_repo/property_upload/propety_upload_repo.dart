import '../../../data/network/network_api_services.dart';
import '../../../res/app_urls/app_url.dart';

class PropertyRepository{
  final _apiServices = NetworkApiService();


  Future<dynamic> uploadProperties(var data,String accessToken) async {
    dynamic response = await _apiServices.postApi(
      data,
      AppUrls.propertiesUploadUrl,
      authToken: accessToken,
    );
    return response;
  }
}