class API {
  static const mainUrl = "https://www.propertier.com.pk/api/v1";
  // static const baseURL = "https://propertier-p2wwcx3okq-em.a.run.app/";
  static const baseURL = "https://propertier-cloud-run-882044310734.asia-south2.run.app"; //localhost
  // static const baseWebSocketURL = "ws://propertier-p2wwcx3okq-em.a.run.app/";
  static const baseWebSocketURL = "ws://propertier-cloud-run-882044310734.asia-south2.run.app/";

  static const secondaryUrl = "api/mob/v1";

  static const userInfoUrl = "$baseURL/accounts/user-info";
  static const registerUrl = "$baseURL/accounts/customers";
  static const uploadPropertyUrl = '$baseURL/$secondaryUrl/Properties';
  static const uploadPropertyFeaturesUrl = '$baseURL/$secondaryUrl/add-features/';
  static const loginUrl = "$mainUrl/login";

  static const homeDataUrl = '$baseURL/$secondaryUrl/HomePage';
  static const propertydetailUrl = '$baseURL/$secondaryUrl/GetPropertiesDetail';
  static const customerRequestUrl = '$baseURL/$secondaryUrl/CustomerRequests/';
  static const allPropertiesUrl = '$baseURL/$secondaryUrl/FilteredProperties';
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

  //------------------------------------------------------vender-----------------------------------------------------------------------------//
  static const venregisterUrl = '$baseURL/accounts/vendors';
  static const fetchProfile = '$baseURL/accounts/vendors';
  static const updateUserProfile = '$baseURL/accounts/vendors';
  static const deleteVendorProfile = '$baseURL/accounts/vendors';
  static const updateCoverPicture = '$baseURL/accounts/vendors';
  static const addAwards = '$baseURL/services/vendor-awards/';
  static const getAwards = '$baseURL/services/awards-for-vendor';
  static const getServices = '$baseURL/services/services-for-vendor';
  static const getFeaturedServices = '$baseURL/services/vendor-featured-services';
  static const deleteServices = '$baseURL/services/vendor-services';
  static const deleteFeaturedService= '$baseURL/services/featured-services';
  static const deleteAward = '$baseURL/services/vendor-awards';
  static const uploadCnicImages = '$baseURL/accounts/vendors';
  static const fetchEarningData = '$baseURL/services/vendor';
  static const postWithoutFeaturePackage = '$baseURL/services/vendor-services/';
  static const postWithFeaturePackage = '$baseURL/services/featured-services/';
  static const submitFeaturePackage = '$baseURL/services/feature-packages/';
  static const fetchVendorFeedbacks = '$baseURL/services/vendor-feedbacks';
  static const uploadDocuments = '$baseURL/accounts/vendors'; //cnic and otherdocuments
  static const incoProDocuments = '$baseURL/accounts/vendors'; //Incorporation and Proprietor Documents

  // *************  Services *****************
  static const serviceMobileDashboard = '$baseURL/services/mobile-dashboard/';
  static const socketSubservice = '$baseURL/services/service';
  static const fixedServices = '$baseURL/services/fixed-services/';
  static const fetchParentServices = '$baseURL/services/services/';
  static const createBidByCustomer = '$baseURL/services/bids/';
  static const listenBidByVendor = '${baseWebSocketURL}ws/bid-responses/';
  static const listenOrderByCustomer = '${baseWebSocketURL}ws/bids/filtered-bids/';
  static const offerByVendor = '$baseURL/services/bid-responses/';
  static const getvendorvehicles = '$baseURL/services/transportcars/vendor/';
  static const addvehicles = '$baseURL/services/transportcars/';
  static const createOrder = '$baseURL/services/orders/';
  static const trackVendorLocation = '$baseURL/services/track-vendor-location/';
  static const updateVendorLocation = '$baseURL/services/update-vendor-location/';
  static const vendorOrder = '$baseURL/services/vendor-orders/';
  static const customerOrder = '$baseURL/services/customer-orders/';
  static const getSubService = '$baseURL/services/sub-services/';
  static const servicesWithPagination = '$baseURL/services/vendor-services-with-pagination/';
  static const getServiceForm = '$baseURL/services/get-requirments-by-serviceId/';
  static const getTransport = '$baseURL/services/get-all-VehicleType/';
  // static const saveTransportFormField = '$baseURL/services/requirement-values/';
  static const saveVendorFormField = '$baseURL/services/vendor-requirements/';
  static const getVendorFormData = '$baseURL/services/get-requirments-by-vendorId/?vendor_id=';


  //**************** Finance API ***********************
  static const createWallet = '$baseURL/finance/user-wallets/';
  static const topupWallet = '$baseURL/finance/update-wallet/';
  static const getWallet = '$baseURL/finance/get-user-wallet/';
  static const walletTestPayment = '$baseURL/finance/test-paymob-intention/';
  static const walletLivePayment = '$baseURL/finance/paymob-intention/';


}

class BaseUrl {
  // static const baseURL = "https://propertier-p2wwcx3okq-em.a.run.app/";
  static const baseURL = "http://13.201.188.247:8000";
  static const baseWebSocketURL = "ws://propertier-p2wwcx3okq-em.a.run.app/";
}

class Finance {
  static const creatIntention = '${BaseUrl.baseURL}/finance/paymob-intention/';
  static const creatIntentionTest =
      '${BaseUrl.baseURL}/finance/test-paymob-intention/';
  static const paymentStatusSocket =
      '${BaseUrl.baseWebSocketURL}/ws/finance/payment-status/';
}

class CreateFeatureAd {
  static const creatIntention = '${BaseUrl.baseURL}/finance/paymob-intention/';
  static const creatIntentionTest =
      '${BaseUrl.baseURL}/finance/test-paymob-intention/';
  static const paymentStatusSocket =
      '${BaseUrl.baseWebSocketURL}/ws/finance/payment-status/';
  static const createFeaturedProperty = '${BaseUrl.baseURL}/properties/featured-properties/';
  static const createFeaturedProfile = '${BaseUrl.baseURL}/properties/featured-profiles/';
}
