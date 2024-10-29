import 'package:get/get.dart';
import 'package:propertier/App/About/View/about_view.dart';
import 'package:propertier/App/Activity/Searched%20Activity/View/searched_activity_view.dart';
import 'package:propertier/App/Activity/Searched%20Activity/ViewModel/searched_activity_viewmodel.dart';
import 'package:propertier/App/Activity/View/activity_view.dart';
import 'package:propertier/App/Activity/ViewModel/activity_viewmodel.dart';
import 'package:propertier/App/Ads/View/ads_view.dart';
import 'package:propertier/App/Analytics/View/analytics_view.dart';
import 'package:propertier/App/Analytics/ViewModel/analytics_view_model.dart';
import 'package:propertier/App/Auth/AuthView/View/auth_view.dart';
import 'package:propertier/App/Details/View/detail_view.dart';
import 'package:propertier/App/Details/ViewModel/properties_detail_view_model.dart';
import 'package:propertier/App/Files/File%20detail/ViewModel/files_detail_viewmodel.dart';
import 'package:propertier/App/Files/File%20detail/Views/files_detail_view.dart';
import 'package:propertier/App/Files/ViewModel/files_viewmodel.dart';
import 'package:propertier/App/Files/Views/files_view.dart';
import 'package:propertier/App/Language/View/language_view.dart';
import 'package:propertier/App/Language/ViewModel/language_view_model.dart';
import 'package:propertier/App/MarketPlace/View/market_place_view.dart';
import 'package:propertier/App/MarketPlace/ViewModel/market_place_view_model.dart';
import 'package:propertier/App/MarketingTeamEarning/View/marketing_team_earning_view.dart';
import 'package:propertier/App/MarketingTeamEarning/ViewModel/marketing_team_earning_view_model.dart';
import 'package:propertier/App/Monetization/View/monetization_view.dart';
import 'package:propertier/App/Monetization/ViewModel/monetization_view_model.dart';
import 'package:propertier/App/NavBar/ViewModel/navbar_view_model.dart';
import 'package:propertier/App/Offered%20Services/ViewModel/offered_services_viewmodel.dart';
import 'package:propertier/App/Offered%20Services/Views/offered_services_view.dart';
import 'package:propertier/App/PayOut/View/pay_out_view.dart';
import 'package:propertier/App/PayOut/ViewModel/pay_out_view_model.dart';
import 'package:propertier/App/My%20Orders/View/my_orders_view.dart';
import 'package:propertier/App/My%20Orders/ViewModel/my_orders_view_model.dart';
import 'package:propertier/App/Official%20Team/View/officailteam_view.dart';
import 'package:propertier/App/Official%20Team/ViewModel/offiacialteam_view_model.dart';
import 'package:propertier/App/Payment%20Method%20Getwaye/View/payment_gatwaye_view.dart';
import 'package:propertier/App/Payment%20Method%20Getwaye/ViewModel/payment_gatewaye_viewmodel.dart';
import 'package:propertier/App/Payment%20Method/Bank%20Method/ViewModel/bank_payment_method_viewmodel.dart';
import 'package:propertier/App/Payment%20Method/Bank%20Method/Views/bank_payment_method.dart';
import 'package:propertier/App/Payment%20Method/Credit%20card%20method/ViewModel/credit_card_method_viewmodel.dart';
import 'package:propertier/App/Payment%20Method/Credit%20card%20method/Views/credit_card_method_view.dart';
import 'package:propertier/App/Payment%20Method/MarketPlace%20Payment/ViewModel/marketplace_payment_viewmodel.dart';
import 'package:propertier/App/Payment%20Method/MarketPlace%20Payment/Views/marketplace_payment_view.dart';
import 'package:propertier/App/Payment%20Method/ViewModel/select_payment_method.dart';
import 'package:propertier/App/Payment%20Method/Views/payment_done_view.dart';
import 'package:propertier/App/Payment%20Method/Views/select_payment_method_view.dart';
import 'package:propertier/App/Policy/View/policy_view.dart';
import 'package:propertier/App/Policy/ViewModel/policy_viewmodel.dart';
import 'package:propertier/App/Post%20Add/Add%20Material/ViewModel/add_material_viewmodel.dart';
import 'package:propertier/App/Post%20Add/Add%20Material/Views/add_material.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/Views/add_properties_view.dart';
import 'package:propertier/App/Post%20Add/View/post_add.dart';
import 'package:propertier/App/Privacy/View/privacy_view.dart';
import 'package:propertier/App/Privacy/ViewModel/privacy_viewmodel.dart';
import 'package:propertier/App/Profile/Documents%20Verification/View/documents_types_view.dart';
import 'package:propertier/App/Profile/Documents%20Verification/View/documents_upload_view.dart';
import 'package:propertier/App/Profile/Documents%20Verification/View/documents_verification_view.dart';
import 'package:propertier/App/Profile/Documents%20Verification/ViewModel/documents_card_verification_view_model.dart';
import 'package:propertier/App/Profile/ID%20card%20Verification/View/id_upload_view.dart';
import 'package:propertier/App/Profile/ID%20card%20Verification/View/id_verification_view.dart';
import 'package:propertier/App/Profile/ID%20card%20Verification/ViewModel/id_card_verification_view_model.dart';
import 'package:propertier/App/Profile/Incorporation%20Verification/View/incorporation_upload_view.dart';
import 'package:propertier/App/Profile/Incorporation%20Verification/View/incorporation_verification_view.dart';
import 'package:propertier/App/Profile/Incorporation%20Verification/ViewModel/incorporation_card_verification_view_model.dart';
import 'package:propertier/App/Profile/Profile%20Property%20listing/View/profile_property_listing_view.dart';
import 'package:propertier/App/Profile/Profile%20Property%20listing/ViewModel/profile_property_listing_view_model.dart';
import 'package:propertier/App/Profile/View/AccountStatus/View/account_status_view.dart';
import 'package:propertier/App/Profile/View/AccountStatus/ViewModel/account_status_view_model.dart';
import 'package:propertier/App/Auth/Forgotpassword/ViewModel/forget_password_view_model.dart';
import 'package:propertier/App/Auth/Login/View/login_view.dart';
import 'package:propertier/App/Auth/Login/ViewModel/login_view_model.dart';
import 'package:propertier/App/Auth/New%20Password/View/new_password_view.dart';
import 'package:propertier/App/Auth/New%20Password/ViewModel/new_password_view_model.dart';
import 'package:propertier/App/Auth/Sign%20Up/View/signup_view.dart';
import 'package:propertier/App/Auth/Sign%20Up/ViewModel/signup_view_model.dart';
import 'package:propertier/App/Home/View/home_view.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/App/Join%20as/View/join_as_view.dart';
import 'package:propertier/App/Otp/OtpVerify/View/otp_verify_view.dart';
import 'package:propertier/App/Otp/OtpVerify/ViewModel/otp_verify_view_model.dart';
import 'package:propertier/App/Otp/VerifySignIn/View/verify_signin_view.dart';
import 'package:propertier/App/Otp/VerifySignIn/ViewModel/verify_sigin_view_model.dart';
import 'package:propertier/App/Profile/View/Add%20Award/View/add_award_view.dart';
import 'package:propertier/App/Profile/View/Add%20Award/ViewModel/add_award_viewmolel.dart';
import 'package:propertier/App/Profile/View/Earnings/View/earnings_view.dart';
import 'package:propertier/App/Profile/View/Earnings/ViewModel/earnings_view_model.dart';
import 'package:propertier/App/Profile/View/Edit%20Profile/View/edit_profile_view.dart';
import 'package:propertier/App/Profile/View/Edit%20Profile/ViewModel/edit_profile_view_model.dart';
import 'package:propertier/App/Profile/View/Verification/View/verification_view.dart';
import 'package:propertier/App/Profile/View/component/short_profile_video.dart';
import 'package:propertier/App/Profile/View/profile_view.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/App/Profile/ViewModel/short_video_profile_viewmodel.dart';
import 'package:propertier/App/SearchEngine/View/search_engine_view.dart';
import 'package:propertier/App/SearchEngine/ViewModel/searh_engine_view_model.dart';
import 'package:propertier/App/Service%20Provider%20Profile/View/service_provider_profile_view.dart';

import 'package:propertier/App/Services/View/services_view.dart';
import 'package:propertier/App/Services/ViewModel/services_view_model.dart';
import 'package:propertier/App/Rental/View/rental_view.dart';
import 'package:propertier/App/Rental/ViewModel/rental_viewmodel.dart';
import 'package:propertier/App/Review/View/review_view.dart';
import 'package:propertier/App/Review/ViewModel/review_viewmodel.dart';
import 'package:propertier/App/Sale%20detail%20Page/ViewModel/sale_detail_viewmodel.dart';
import 'package:propertier/App/Sale%20detail%20Page/Views/sale_detail_view.dart';
import 'package:propertier/App/ServicesCompleted/View/services_completed_view.dart';
import 'package:propertier/App/ServicesMap/View/services_map_view.dart';
import 'package:propertier/App/ServicesMap/ViewModel/services_map_view_model.dart';
import 'package:propertier/App/ServicesProvider/View/services_provider_view.dart';
import 'package:propertier/App/ServicesProvider/ViewModel/services_provider_view_model.dart';
import 'package:propertier/App/ServicesReview/View/services_review_view.dart';
import 'package:propertier/App/ServicesReview/ViewModel/services_review_view_model.dart';
import 'package:propertier/App/ServicesSearch/View/services_search_2_view.dart';
import 'package:propertier/App/ServicesSearch/View/services_search_view.dart';
import 'package:propertier/App/ServicesSearch/ViewModel/services_search_view_model.dart';
import 'package:propertier/App/Settings/View/settings_view.dart';
import 'package:propertier/App/Settings/ViewModel/settings_view_model.dart';
import 'package:propertier/App/ShortVideo/View/short_video_view.dart';
import 'package:propertier/App/ShortVideo/ViewModel/short_video_view_model.dart';
import 'package:propertier/App/Support/Views/support_view.dart';
import 'package:propertier/App/TeamEarning/View/team_earning_view.dart';
import 'package:propertier/App/TeamEarning/ViewModel/team_earning_view_model.dart';
import 'package:propertier/App/What%20are%20you%20searching/Map/View/map_wrysf.dart';
import 'package:propertier/App/What%20are%20you%20searching/ViewModel/what_are_viewmodel.dart';
import 'package:propertier/App/onBoarding/View/onboarding_view.dart';
import 'package:propertier/App/onBoarding/ViewModel/onboarding_view_model.dart';
import 'package:propertier/App/NavBar/View/nav_bar_view.dart';

import 'package:propertier/App/Player/View/player_view.dart';
import 'package:propertier/Features/SelectFeatuedType/Controller/select_featued_type_controller.dart';
import 'package:propertier/Features/SelectFeatuedType/Views/select_featured_type_view.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Vendor/screens/Auth/Sign%20Up/ViewModel/signup_view_model.dart';

import '../App/Auth/Create User/Views/collect_info.dart';
import '../App/Auth/Forgotpassword/View/forget_password_view.dart';
import '../App/Profile/Email Verification/View/email_confrim_view.dart';
import '../App/Profile/Email Verification/View/email_otp_verify_view.dart';
import '../App/Profile/Email Verification/View/email_verification_view.dart';
import '../App/Profile/Email Verification/ViewModel/email_otp_confirm.dart';
import '../App/Profile/Email Verification/ViewModel/email_verification_view_model.dart';
import '../App/Profile/Number Verification/View/number_confrim_view.dart';
import '../App/Profile/Number Verification/View/number_otp_verify_view.dart';
import '../App/Profile/Number Verification/View/number_verification_view.dart';
import '../App/Profile/Number Verification/ViewModel/number_otp_confirm_ViewModel.dart';
import '../App/Profile/Number Verification/ViewModel/number_verification_view_model.dart';
import '../App/Profile/View/(Properties)Request and Demonds/View/request_demand_view.dart';
import '../App/Profile/View/(Properties)Request and Demonds/ViewModel/request_demand_viewmodel.dart';
import '../App/Profile/View/Verification/ViewModel/verification_view_model.dart';
import '../App/PropertiesAndShortVideo/View/properties_and_Video_view.dart';
import '../App/PropertiesAndShortVideo/ViewModel/properties_and_Video_view_model.dart';
import '../App/Service Provider Profile/ViewModel/service_provider_profile_viewmodel.dart';
import '../App/What are you searching/View/what_are_you_search_view.dart';
import '../Vendor/screens/Auth/Sign Up/View/signup_view.dart';
import '../Vendor/screens/dashboard/dashboard.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: AppRoutes.onBoardingView,
        transition: Transition.rightToLeftWithFade,
        page: () => const OnBoardingView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => OnBoardingViewModel());
        })),
    GetPage(
        name: AppRoutes.verifySigninView,
        transition: Transition.rightToLeftWithFade,
        page: () => const VerifySigninView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => VeifySigninViewModel());
        })),
    GetPage(
        name: AppRoutes.otpVerifyView,
        transition: Transition.rightToLeftWithFade,
        page: () => const OTPVerifyView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => OTPVerifyViewModel());
        })),
    GetPage(
        name: AppRoutes.servicesProviderView,
        transition: Transition.rightToLeftWithFade,
        page: () => const ServicesProviderView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ServicesProviderViewModel());
        })),
    GetPage(
        name: AppRoutes.navBarView,
        transition: Transition.rightToLeftWithFade,
        page: () => NavBarView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HomeViewModel());
          Get.lazyPut(() => UploadPropertyViewModel());
          Get.lazyPut(() => ServicesProviderViewModel());
        })),
    GetPage(
        name: AppRoutes.homeView,
        transition: Transition.rightToLeftWithFade,
        page: () => HomeView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HomeViewModel());
          Get.lazyPut(() => UploadPropertyViewModel());
        })),
    GetPage(
        name: AppRoutes.loginView,
        transition: Transition.rightToLeftWithFade,
        page: () => LoginView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginViewModel());
        })),
    GetPage(
        name: AppRoutes.signUpView,
        transition: Transition.rightToLeftWithFade,
        page: () => SignUpView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SignUpViewModel());
        })),
    GetPage(
        name: AppRoutes.forgotPasswordView,
        transition: Transition.rightToLeftWithFade,
        page: () => ForgotPasswordView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ForgotPasswordViewModel());
        })),
    GetPage(
        name: AppRoutes.newPasswordView,
        transition: Transition.rightToLeftWithFade,
        page: () => NewPasswordView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => NewPasswordViewModel());
        })),
    GetPage(
        name: AppRoutes.joinAsView,
        transition: Transition.rightToLeftWithFade,
        page: () => const JoinView(),
        binding: BindingsBuilder(() {
          // Get.lazyPut(() => ());
        })),
    GetPage(
        name: AppRoutes.editProfileView,
        transition: Transition.rightToLeftWithFade,
        page: () => EditProfileView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EditProfileViewModel());
        })),
    GetPage(
        name: AppRoutes.verificationView,
        transition: Transition.rightToLeftWithFade,
        page: () => VerificationView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => VerficationViewModel());
        })),
    GetPage(
        name: AppRoutes.accountStatusView,
        transition: Transition.rightToLeftWithFade,
        page: () => AccountStatusView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AccountStatusViewModel());
        })),
    GetPage(
        name: AppRoutes.earningsView,
        transition: Transition.rightToLeftWithFade,
        page: () => EarningsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EarningsViewModel());
        })),
    GetPage(
        name: AppRoutes.monetizationView,
        transition: Transition.rightToLeftWithFade,
        page: () => MonetizationView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MonetizationViewModel());
        })),
    GetPage(
        name: AppRoutes.teamEarningView,
        transition: Transition.rightToLeftWithFade,
        page: () => const TeamEarningView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => TeamEarningViewModel());
        })),
    GetPage(
        name: AppRoutes.marketingTeamEarningView,
        transition: Transition.rightToLeftWithFade,
        page: () => const MarketingTeamEarningView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MarketingTeamEarningViewModel());
        })),
    GetPage(
        name: AppRoutes.analyticsView,
        transition: Transition.rightToLeftWithFade,
        page: () => AnalyticsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AnalyticsViewModel());
        })),
    GetPage(
        name: AppRoutes.aboutView,
        transition: Transition.rightToLeftWithFade,
        page: () => const AboutView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AnalyticsViewModel());
        })),
    GetPage(
        name: AppRoutes.adsView,
        transition: Transition.rightToLeftWithFade,
        page: () => const AdsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AnalyticsViewModel());
        })),
    GetPage(
        name: AppRoutes.languageView,
        transition: Transition.rightToLeftWithFade,
        page: () => LanguageView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LanguageViewModel());
        })),
    GetPage(
        name: AppRoutes.payoutView,
        transition: Transition.rightToLeftWithFade,
        page: () => PayOutView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => PayOutViewModel());
        })),
    GetPage(
        name: AppRoutes.settingsView,
        transition: Transition.rightToLeftWithFade,
        page: () => SettingsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SettingsViewModel());
        })),
    GetPage(
        name: AppRoutes.marketPlaceView,
        transition: Transition.rightToLeftWithFade,
        page: () => MarketPlaceView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MarketPlaceViewModel());
        })),
    GetPage(
        name: AppRoutes.servicesView,
        transition: Transition.rightToLeftWithFade,
        page: () => ServciesView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ServicesViewModel());
        })),
    GetPage(
        name: AppRoutes.propertiesAndVideoView,
        transition: Transition.rightToLeftWithFade,
        page: () => PropertiesAndVideoView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => UploadPropertyViewModel());
          Get.lazyPut(() => PropertiesAndVideoViewModel());
          Get.lazyPut(() => HomeViewModel());
        })),
    GetPage(
        name: AppRoutes.emailverificationView,
        transition: Transition.rightToLeftWithFade,
        page: () => EmailVerificationView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EmailVerficationViewModel());
        })),
    GetPage(
        name: AppRoutes.emailOTPView,
        transition: Transition.rightToLeftWithFade,
        page: () => EmailOTPVerifyView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EmailOTPViewModel());
        })),
    GetPage(
        name: AppRoutes.emailEnterView,
        transition: Transition.rightToLeftWithFade,
        page: () => EmailConfirmView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ());
        })),
    GetPage(
        name: AppRoutes.numberVerificationView,
        transition: Transition.rightToLeftWithFade,
        page: () => NumberVerificationView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => NumberVerficationViewModel());
        })),
    GetPage(
        name: AppRoutes.numberOTPView,
        transition: Transition.rightToLeftWithFade,
        page: () => NumberOTPVerifyView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => NumberOTPViewModel());
        })),
    GetPage(
        name: AppRoutes.numberEnterView,
        transition: Transition.rightToLeftWithFade,
        page: () => NumberConfirmView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ());
        })),
    GetPage(
        name: AppRoutes.idVerificationView,
        transition: Transition.rightToLeftWithFade,
        page: () => IDVerificationView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => IDVerficationViewModel());
        })),
    GetPage(
        name: AppRoutes.idUploadView,
        transition: Transition.rightToLeftWithFade,
        page: () => const IDUploadView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ());
        })),
    GetPage(
        name: AppRoutes.incorporationVerificationView,
        transition: Transition.rightToLeftWithFade,
        page: () => IncorporationVerificationView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => IncorporationViewModel());
        })),
    GetPage(
        name: AppRoutes.incorporationUploadView,
        transition: Transition.rightToLeftWithFade,
        page: () => const IncorporationUploadView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ());
        })),
    GetPage(
        name: AppRoutes.documentsVerificationView,
        transition: Transition.rightToLeftWithFade,
        page: () => DocumentsVerificationView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => DocumentsVerficationViewModel());
        })),
    GetPage(
        name: AppRoutes.documentsUploadView,
        transition: Transition.rightToLeftWithFade,
        page: () => const DocumentsUploadView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ());
        })),
    GetPage(
        name: AppRoutes.documentsTypesView,
        transition: Transition.rightToLeftWithFade,
        page: () => DocumentsTypesView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ());
        })),
    GetPage(
        name: AppRoutes.myOrderView,
        transition: Transition.rightToLeftWithFade,
        page: () => MyOrdersView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MyOrderViewModel());
        })),
    GetPage(
        name: AppRoutes.reviewView,
        transition: Transition.rightToLeftWithFade,
        page: () => ReviewView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ReviewViewModel());
        })),
    GetPage(
        name: AppRoutes.policyView,
        transition: Transition.rightToLeftWithFade,
        page: () => PolicyView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => PolicyViewModel());
        })),
    GetPage(
        name: AppRoutes.oficialTeamView,
        transition: Transition.rightToLeftWithFade,
        page: () => OfficialTeamView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => OfficialTeamViewModel());
        })),
    GetPage(
        name: AppRoutes.rentalView,
        transition: Transition.rightToLeftWithFade,
        page: () => const RentalView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RentalViewModel());
        })),
    GetPage(
        name: AppRoutes.postAddView,
        transition: Transition.rightToLeftWithFade,
        page: () => PostAddView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RentalViewModel());
        })),
    GetPage(
        name: AppRoutes.addMaterialView,
        transition: Transition.rightToLeftWithFade,
        page: () => const AddMaterialView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AddMaterialViewModel());
        })),
    GetPage(
        name: AppRoutes.saleDetailView,
        transition: Transition.rightToLeftWithFade,
        page: () => const SaleDetailView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => UploadPropertyViewModel());
          Get.lazyPut(() => SaleDetailViewModel());
        })),
    GetPage(
        name: AppRoutes.selectPaymentMethodView,
        transition: Transition.rightToLeftWithFade,
        page: () => const SelectPaymentMethodView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SelectPaymentMethodViewModel());
        })),
    GetPage(
        name: AppRoutes.creditCardPaymentView,
        transition: Transition.rightToLeftWithFade,
        page: () => const CreditPaymentMethodView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CreditCardMethodViewModel());
        })),
    GetPage(
        name: AppRoutes.bankMethodView,
        transition: Transition.rightToLeftWithFade,
        page: () => const BankPaymentMethodView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => BankPaymentMethodViewModel());
        })),
    GetPage(
        name: AppRoutes.paymentDoneView,
        transition: Transition.rightToLeftWithFade,
        page: () => const PaymentDoneView(),
        binding: BindingsBuilder(() {
          // Get.lazyPut(() => ());
        })),
    GetPage(
        name: AppRoutes.filesView,
        transition: Transition.rightToLeftWithFade,
        page: () => const FilesView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => FilesViewModel());
        })),
    GetPage(
        name: AppRoutes.filesDetailView,
        transition: Transition.rightToLeftWithFade,
        page: () => const FilesDetailView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => FilesDetailViewModel());
        })),
    GetPage(
        name: AppRoutes.shortVideoView,
        transition: Transition.rightToLeftWithFade,
        page: () => const ShortVideoView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ShortVideoViewModel());
          Get.lazyPut(() => HomeViewModel());
        })),
    GetPage(
        name: AppRoutes.playerView,
        transition: Transition.rightToLeftWithFade,
        page: () => PLayerView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ShortVideoViewModel());
        })),
    GetPage(
        name: AppRoutes.detailView,
        transition: Transition.rightToLeftWithFade,
        page: () => DetailsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => DetailsViewModel());
        })),
    GetPage(
        name: AppRoutes.servicesSearchView,
        transition: Transition.rightToLeftWithFade,
        page: () => ServicesSearchView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ServicesSearhViewModel());
        })),
    GetPage(
        name: AppRoutes.servicesSearch2View,
        transition: Transition.rightToLeftWithFade,
        page: () => ServicesSearch2View(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ServicesSearhViewModel());
        })),
    GetPage(
        name: AppRoutes.servicesMapView,
        transition: Transition.rightToLeftWithFade,
        page: () => ServicesMapView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ServicesMapViewModel());
        })),
    GetPage(
        name: AppRoutes.supportView,
        transition: Transition.rightToLeftWithFade,
        page: () => const SupportView(),
        binding: BindingsBuilder(() {
          // Get.lazyPut(() => ());
        })),
    GetPage(
        name: AppRoutes.addPropertiesView,
        transition: Transition.rightToLeftWithFade,
        page: () => AddPropertiesView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AddPropertiesViewModel());
        })),
    GetPage(
        name: AppRoutes.marketPlacePaymentView,
        transition: Transition.rightToLeftWithFade,
        page: () => const MarketPlacePaymentView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => MarketPlacePaymentViewModel());
        })),
    GetPage(
        name: AppRoutes.offeredServices,
        transition: Transition.rightToLeftWithFade,
        page: () => const OfferedServiceView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => OfferedServicesViewModel());
        })),
    GetPage(
        name: AppRoutes.servicesCompleteView,
        transition: Transition.rightToLeftWithFade,
        page: () => ServicesCompletedView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => OfferedServicesViewModel());
        })),
    GetPage(
        name: AppRoutes.servicesReviewView,
        transition: Transition.rightToLeftWithFade,
        page: () => const ServicesReviewView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ServicesReviewViewModel());
        })),
    GetPage(
        name: AppRoutes.profileView,
        transition: Transition.rightToLeftWithFade,
        page: () => ProfileStatusView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => NavBarViewModel(), fenix: true);
          Get.lazyPut(() => ProfileViewModel());
          Get.lazyPut(() => UploadPropertyViewModel());
        })),
    GetPage(
        name: AppRoutes.activityView,
        transition: Transition.rightToLeftWithFade,
        page: () => const ActivityView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ActivityViewModel());
        })),
    GetPage(
        name: AppRoutes.searchedActivityView,
        transition: Transition.rightToLeftWithFade,
        page: () => const SearchedActivityView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SearchedActivityViewModel());
        })),
    GetPage(
        name: AppRoutes.privacyView,
        transition: Transition.rightToLeftWithFade,
        page: () => const PrivacyView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => PrivacyViewModel());
        })),
    GetPage(
        name: AppRoutes.searchEngineView,
        transition: Transition.rightToLeftWithFade,
        page: () => SearchEngineView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SearchEngineViewModel());
        })),
    GetPage(
        name: AppRoutes.whatAreYouSearchingView,
        transition: Transition.rightToLeftWithFade,
        page: () => const WhatAreYouSearchView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => WhatAreYouSearchViewModel());
        })),
    GetPage(
        name: AppRoutes.whatAreYouMapView,
        transition: Transition.rightToLeftWithFade,
        page: () => const MapViewWRYSF(),
        binding: BindingsBuilder(() {
          // Get.lazyPut(() => WhatAreYouSearchViewModel());
        })),
    GetPage(
        name: AppRoutes.shortVideoProfileView,
        transition: Transition.rightToLeftWithFade,
        page: () => ShortVideoProfileView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ShortVideoProfileViewModel());
        })),
    GetPage(
        name: AppRoutes.authView,
        transition: Transition.rightToLeftWithFade,
        page: () => const AuthView(),
        binding: BindingsBuilder(() {
          // Get.lazyPut(() => ShortVideoProfileViewModel());
        })),
    GetPage(
        name: AppRoutes.addAward,
        transition: Transition.rightToLeftWithFade,
        page: () => const AddAwardView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AddAwardViewModel());
        })),
    GetPage(
        name: AppRoutes.requestDemandView,
        transition: Transition.rightToLeftWithFade,
        page: () => const RequestDemandView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RequestDemandViewModel());
        })),
    GetPage(
        name: AppRoutes.profilePropertyListingView,
        transition: Transition.rightToLeftWithFade,
        page: () => ProfilePropertyListingView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProfilePropertyListingViewModel());
        })),
    GetPage(
        name: AppRoutes.paymentGatwayeView,
        transition: Transition.rightToLeftWithFade,
        page: () => const PaymentGatwayeView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => PaymentGatwayeViewModel());
        })),
    GetPage(
        name: AppRoutes.serviceProviderProfile,
        transition: Transition.rightToLeftWithFade,
        page: () => const ServiceProviderProfile(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ServiceProviderProfileViewModel());
        })),
    GetPage(
        name: AppRoutes.collectInfoProfile,
        transition: Transition.rightToLeftWithFade,
        page: () => CollectInfo(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SignUpViewModel());
        })),
    GetPage(
        name: AppRoutes.selectFeaturedtype,
        transition: Transition.rightToLeftWithFade,
        page: () => SelectFeaturedTypeView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SelectFeatuedTypeController());
        })),
    // GetPage(
    //     name: AppRoutes.selectFeaturedtype,
    //     transition: Transition.rightToLeftWithFade,
    //     page: () => SelectFeaturedTypeView(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut(() => SelectFeatuedTypeController());
    //     })),
    //!!--------------------------Vender-----------------------------!!//
    GetPage(
        name: AppRoutes.vendordashborad,
        transition: Transition.rightToLeftWithFade,
        page: () => const Dashboard(),
        binding: BindingsBuilder(() {
          // Get.lazyPut(() => Dashboard());
        })),
    GetPage(
        name: AppRoutes.signupvendor,
        transition: Transition.rightToLeftWithFade,
        page: () => SignUpViewVendor(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SignUpViewModelVendor());
        })),
    //!!-------------------------------------------------------!!//
  ];
}
