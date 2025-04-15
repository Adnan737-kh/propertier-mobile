import 'dart:convert';

import '../../../App/Profile/Model/profile_model.dart';
import '../../../Network/api_urls.dart';
import '../../../data/network/network_api_services.dart';
import '../../../res/app_urls/app_url.dart';

class ProfileViewRepository {
  final _apiServices = NetworkApiService();

  Future<dynamic> viewProfileDetails(String accessToken) async {
    dynamic response = await _apiServices.getApi(
      AppUrls.profileDetailUrl,
      authToken: accessToken,
    );
    return response;
  }

  Future<ProfileModel> viewServicesProfileDetails(String agentID) async {
    ProfileModel profileDetailModel = ProfileModel();
    dynamic response = await _apiServices.getApi(
      '${AppUrls.servicesProfileDetailUrl}/$agentID/', // Corrected string interpolation
    );
    print("response from shortVideo Profile $response");
    final decodedJson = response;
    profileDetailModel = ProfileModel.fromJson(decodedJson);
    return profileDetailModel;
  }
}
