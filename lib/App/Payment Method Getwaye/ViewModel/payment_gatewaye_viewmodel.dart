import 'package:get/get.dart';

import '../../../Features/Featured Pakages/Models/featured_pakages/featured_pakages.dart';
// import '../Services/services.dart';

class PaymentGatwayeViewModel extends GetxController {

  final _selectedBank = "EasyPaisa".obs;

  final data = Get.arguments;
  late String propertyId;
  late final String? image;
  late String featuredItem;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    propertyId = data['propertyId'];
    image = data['pickedImage'];
    featuredItem = data['featuredItem'];
  }


  RxBool isLoading = false.obs;
  get seletedBank => _selectedBank.value;

  void onChangeBank(String val) {
    _selectedBank.value = val;
  }

  var _selectedFeatures = const FeaturedPakages().obs;

  Rx<FeaturedPakages> get selectedFeatures => _selectedFeatures;

  set selectedFeatures(value) {
    _selectedFeatures = value;
  }

  final _selectedDuration = "7".obs;
  get selectedDuration => _selectedDuration.value;
  final _price = "1".obs;
  get price => _price.value;

  void onChangeSelectedDuration(String val, String rp) {
    _selectedDuration.value = val;
    _price.value = rp;
  }

  final _isPropertyVerification = false.obs;
  get propertyVerification => _isPropertyVerification.value;

  void onChangePropertyVerification(bool val) {
    _isPropertyVerification.value = val;
  }

  final _isTenXMoreBuyers = false.obs;
  get tenXMoreBuyers => _isTenXMoreBuyers.value;

  void onChangeTenXMoreBuyers(bool val) {
    _isTenXMoreBuyers.value = val;
  }

  final _isAdOnTopPostion = false.obs;
  get adOnTopPostion => _isAdOnTopPostion.value;

  void onChangeAdOnTopPostion(bool val) {
    _isAdOnTopPostion.value = val;
  }

  final _isFeatureAdTag = false.obs;
  get featureAdTag => _isFeatureAdTag.value;

  void onChangeFeatureAdTag(bool val) {
    _isFeatureAdTag.value = val;
  }



  Future buyAdPackage()async{

  }



  void onSubmit() {
    //  if (controller.price != '') {
    //                       final price =
    //                           (int.parse(controller.price) * 100).toString();
    //                       PaymobPakistan.instance
    //                           .initialize(
    //                         apiKey: _apiKey,
    //                         integrationID: 135513,
    //                         iFrameID: 52288,
    //                         jazzcashIntegrationId: 135516,
    //                         easypaisaIntegrationID: 135519,
    //                       )
    //                           .then((value) async {
    //                         PaymentInitializationResult response =
    //                             await PaymobPakistan.instance.initializePayment(
    //                           currency: "PKR",
    //                           amountInCents: price,
    //                         );
    //                         String authToken = response.authToken;
    //                         int orderID = response.orderID;
    //                         if (controller.seletedBank == "EasyPaisa") {
    //                           PaymobPakistan.instance.makePayment(
    //                             context,
    //                             currency: "PKR",
    //                             amountInCents: price,
    //                             paymentType: PaymentType.easypaisa,
    //                             authToken: authToken,
    //                             orderID: orderID,
    //                           );
    //                         }
    //                         if (controller.seletedBank == "JazzCash") {
    //                           PaymobPakistan.instance.makePayment(
    //                             context,
    //                             currency: "PKR",
    //                             amountInCents: price,
    //                             paymentType: PaymentType.jazzcash,
    //                             authToken: authToken,
    //                             orderID: orderID,
    //                           );
    //                         }
    //                         if (controller.seletedBank == "Bank") {
    //                           PaymobPakistan.instance.makePayment(
    //                             context,
    //                             currency: "PKR",
    //                             amountInCents: price,
    //                             paymentType: PaymentType.card,
    //                             authToken: authToken,
    //                             orderID: orderID,
    //                           );
    //                         }
    //                       });
    //                     }
  }
}
