class API {
  static const mainUrl = "https://api.thepropertier.com";
  // static const baseURL = "https://propertier-p2wwcx3okq-em.a.run.app/";
  static const baseURL = "https://propertier-cloud-run-882044310734.asia-south2.run.app"; //localhost
  // static const baseWebSocketURL = "ws://propertier-p2wwcx3okq-em.a.run.app/";
  static const baseWebSocketURL = "ws://propertier-cloud-run-882044310734.asia-south2.run.app/";

  static const secondaryUrl = "api/mob/v1";

  static const userInfoUrl = "$mainUrl/accounts/user-info";
  static const registerUrl = "$mainUrl/accounts/customers";
  static const uploadPropertyUrl = '$mainUrl/$secondaryUrl/Properties';
  static const uploadPropertyFeaturesUrl = '$mainUrl/$secondaryUrl/add-features/';
  static const loginUrl = "$mainUrl/login";

  static const homeDataUrl = '$mainUrl/$secondaryUrl/homepage/';
  static const propertyDetailUrl = '$mainUrl/$secondaryUrl/getpropertiesdetail/';
  static const customerRequestUrl = '$mainUrl/$secondaryUrl/CustomerRequests/';
  static const allPropertiesUrl = '$mainUrl/api/properties/';
  // static const allPropertiesUrl = '$baseURL/$secondaryUrl/FilteredProperties';
  static const profileDetailUrl = '$mainUrl/$secondaryUrl/user-profiles/3/';
  static const getFeaturesPackagesUrl = '$baseURL/properties/feature-packages/';
  static const accountDeleteUrl = '$mainUrl/accounts/delete-user-profile/';
  static const likePropertyUrl = '$mainUrl/$secondaryUrl/LikeOrUnlike/';
  static const isLikedPropertyUrl = '$mainUrl/$secondaryUrl/isLiked/';
  static const updateProfileUrl =
      '$mainUrl/$secondaryUrl/update-customer-info/';
  static const requestPropertiesUrl = '$mainUrl/$secondaryUrl/nearby-requests/';
  static const allVideosUrl = '$mainUrl/get-complete-videos-screen-data';
  static const uploadAwardUrl = '$mainUrl/upload-award';
  static const addAwardUrl = '$mainUrl/$secondaryUrl/award/';
  static const unlikePropertyUrl = '$mainUrl/unlike-property';

  static const demandRequestUrl = '$mainUrl/demand-properties';
  static const featuresUrl = '$mainUrl/$secondaryUrl/get-all-amenities/';
  static const forgetPasswordUrl = '$mainUrl/forget-password';

  //------------------------------------------------------vendor-----------------------------------------------------------------------------//
  static const venRegisterUrl = '$mainUrl/api/vendors';
  static const fetchProfile = '$mainUrl/api/vendors';
  static const updateUserProfile = '$mainUrl/api/vendors';
  static const deleteVendorProfile = '$mainUrl/api/vendors';
  static const updateCoverPicture = '$mainUrl/api/vendors';
  static const addAwards = '$mainUrl/services/vendor-awards/';
  static const getAwards = '$mainUrl/services/awards-for-vendor';
  static const getServices = '$mainUrl/services/services-for-vendor';
  static const getFeaturedServices = '$mainUrl/services/vendor-featured-services';
  static const deleteServices = '$mainUrl/services/vendor-services';
  static const deleteFeaturedService= '$mainUrl/services/featured-services';
  static const deleteAward = '$mainUrl/services/vendor-awards';
  static const uploadCnicImages = '$mainUrl/api/vendors';
  static const fetchEarningData = '$mainUrl/services/vendor';
  static const postWithoutFeaturePackage = '$mainUrl/services/vendor-services/';
  static const postWithFeaturePackage = '$mainUrl/services/featured-services/';
  static const submitFeaturePackage = '$mainUrl/services/feature-packages/';
  static const fetchVendorFeedbacks = '$mainUrl/services/vendor-feedbacks';
  static const uploadDocuments = '$mainUrl/api/vendors'; //cnic and other-documents
  static const inCoProDocuments = '$mainUrl/api/vendors'; //Incorporation and Proprietor Documents

  // *************  Services *****************
  static const serviceMobileDashboard = '$mainUrl/api/services-dashboard/';
  static const socketSubService = '$mainUrl/services/service';
  static const fixedServices = '$mainUrl/services/fixed-services/';
  static const fetchParentServices = '$mainUrl/api/services/';
  static const createBidByCustomer = '$mainUrl/services/bids/';
  static const listenBidByVendor = '${baseWebSocketURL}ws/bid-responses/';
  static const listenOrderByCustomer = '${baseWebSocketURL}ws/bids/filtered-bids/';
  static const offerByVendor = '$mainUrl/services/bid-responses/';
  static const getVendorVehicles = '$mainUrl/services/transportcars/vendor/';
  static const addVehicles = '$mainUrl/services/transportcars/';
  static const createOrder = '$mainUrl/services/orders/';
  static const trackVendorLocation = '$mainUrl/services/track-vendor-location/';
  static const updateVendorLocation = '$mainUrl/services/update-vendor-location/';
  static const vendorOrder = '$mainUrl/services/vendor-orders/';
  static const customerOrder = '$mainUrl/services/customer-orders/';
  static const getSubService = '$mainUrl/services/sub-services/';
  static const servicesWithPagination = '$mainUrl/services/vendor-services-with-pagination/';
  static const getServiceForm = '$mainUrl/api/get-requirments-by-serviceid/';
  static const getTransport = '$mainUrl/services/get-all-VehicleType/';
  // static const saveTransportFormField = '$baseURL/services/requirement-values/';
  static const saveVendorFormField = '$mainUrl/api/vendor-requirements/';
  static const getVendorFormData = '$mainUrl/services/get-requirments-by-vendorId/?vendor_id=';


  //**************** Finance API ***********************
  static const createWallet = '$baseURL/finance/user-wallets/';
  static const topUpWallet = '$baseURL/finance/update-wallet/';
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
  static const createIntention = '${BaseUrl.baseURL}/finance/paymob-intention/';
  static const createIntentionTest =
      '${BaseUrl.baseURL}/finance/test-paymob-intention/';
  static const paymentStatusSocket =
      '${BaseUrl.baseWebSocketURL}/ws/finance/payment-status/';
}

class CreateFeatureAd {
  static const createIntention = '${BaseUrl.baseURL}/finance/paymob-intention/';
  static const createIntentionTest =
      '${BaseUrl.baseURL}/finance/test-paymob-intention/';
  static const paymentStatusSocket =
      '${BaseUrl.baseWebSocketURL}/ws/finance/payment-status/';
  static const createFeaturedProperty = '${BaseUrl.baseURL}/properties/featured-properties/';
  static const createFeaturedProfile = '${BaseUrl.baseURL}/properties/featured-profiles/';
}
