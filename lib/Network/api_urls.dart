class API {
  static const mainUrl = "https://www.propertier.com.pk/api/v1";
  static const baseURL = "https://propertier-p2wwcx3okq-em.a.run.app/";
  static const baseWebSocketURL = "ws://propertier-p2wwcx3okq-em.a.run.app/";

  // static const baseURL = "http://127.0.0.1:8000/"; //localhost
  static const secondaryUrl = "api/mob/v1";

  static const userInfoUrl = "$baseURL/accounts/user-info";
  static const registerUrl = "$baseURL/accounts/customers";
  static const uploadPropertyUrl = '$baseURL$secondaryUrl/Properties';
  static const uploadPropertyFeaturesUrl =
      '$baseURL$secondaryUrl/add-features/';
  static const loginUrl = "$mainUrl/login";

  static const homeDataUrl = '$baseURL$secondaryUrl/HomePage';
  static const propertydetailUrl = '$baseURL$secondaryUrl/GetPropertiesDetail';
  static const customerRequestUrl = '$baseURL$secondaryUrl/CustomerRequests/';
  static const allPropertiesUrl = '$baseURL$secondaryUrl/FilteredProperties';
  static const profileDetailUrl = '$baseURL/$secondaryUrl/user-profiles/';
  static const getFeaturesPakagesUrl = '$baseURL/properties/feature-packages/';
  static const accountDeleteUrl = '$baseURL/accounts/delete-user-profile/';
  static const likePropertyUrl = '$baseURL/$secondaryUrl/LikeOrUnlike/';
  static const isLikedPropertyUrl = '$baseURL/$secondaryUrl/isLiked/';
  static const updateProfileUrl =
      '$baseURL/$secondaryUrl/update-customer-info/';
  static const requestPropertiesUrl = '$baseURL/$secondaryUrl/nearby-requests/';
  static const allVideosUrl = '$mainUrl/get-complete-videos-screen-data';
  static const uploadAwardUrl = '$mainUrl/upload-award';
  static const addAwardUrl = '$baseURL/$secondaryUrl/Award/';
  static const unlikePropertyUrl = '$mainUrl/unlike-property';
  static const demandRequestUrl = '$mainUrl/demand-properties';
  static const featuresUrl = '$baseURL/$secondaryUrl/GetAllFeatures';
  static const forgetPasswordUrl = '$mainUrl/forget-password';
  //--------vender-----------//
  static const venregisterUrl = '$baseURL/accounts/vendors';
}

class BaseUrl {
  static const baseURL = "https://propertier-p2wwcx3okq-em.a.run.app/";
  static const baseWebSocketURL = "ws://propertier-p2wwcx3okq-em.a.run.app/";
}

class Finance {
  static const creatIntention = '${BaseUrl.baseURL}/finance/paymob-intention/';
  static const paymentStatusSocket =
      '${BaseUrl.baseWebSocketURL}/ws/finance/payment-status/';
}
