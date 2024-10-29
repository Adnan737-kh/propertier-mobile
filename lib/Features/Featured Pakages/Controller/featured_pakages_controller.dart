import 'package:get/get.dart';
import 'package:propertier/Features/Featured%20Pakages/Service/service.dart';

import '../Models/featured_pakages/featured_pakages.dart';

class FeaturedPakagesController extends GetxController {
  var _isLoading = false.obs;

  RxBool get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
  }

  var _featuredPakages = <FeaturedPakages>[].obs;

  RxList<FeaturedPakages> get featuredPakages => _featuredPakages;

  set featuredPakages(value) {
    _featuredPakages = value;
  }

  var _selectFeatuedPakage = const FeaturedPakages().obs;

  Rx<FeaturedPakages> get selectedFeaturedPakages => _selectFeatuedPakage;

  set selectedFeaturedPakages(value) {
    _selectFeatuedPakage = value;
  }

  @override
  void onInit() async {
    isLoading(true);
    var sfeaturedPakages = await FeaturedPakageService().getFeatures();
    for (var pakage in sfeaturedPakages) {
      _featuredPakages.add(pakage);
    }
    print(_featuredPakages.length);
    isLoading(false);
    super.onInit();
  }
}
