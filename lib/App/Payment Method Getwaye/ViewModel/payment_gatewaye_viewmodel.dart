import 'package:get/get.dart';

import '../../../Features/Featured Pakages/Models/featured_pakages/featured_pakages.dart';
import '../Services/services.dart';

class PaymentGatwayeViewModel extends GetxController {
  final _selectedBank = "EasyPaisa".obs;

  get seletedBank => _selectedBank.value;

  void onChangeBank(String val) {
    _selectedBank.value = val;
  }

  var _selectedFeatures = const FeaturedPakages().obs;

  Rx<FeaturedPakages> get selectedFeatures => _selectedFeatures;

  set selectedFeatures(value) {
    _selectedFeatures = value;
  }

  @override
  void onInit() async {
    super.onInit();
  }

  final _selectedDuration = "7".obs;
  get selectedDuration => _selectedDuration.value;
  final _price = "10".obs;
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
}
