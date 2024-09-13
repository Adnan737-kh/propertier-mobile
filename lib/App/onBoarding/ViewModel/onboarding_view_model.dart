import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/App/onBoarding/Model/onboarding_model.dart';
import 'package:propertier/constant/constant.dart';

class OnBoardingViewModel extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  final RxInt _selectedPageIndex = 0.obs;

  int get selectedPageIndex => _selectedPageIndex.value;
  changeSelectedPageIndex(int index) {
    _selectedPageIndex.value = index;
  }

  @override
  void onReady() async {
    final GetStorage storage = GetStorage();
    final storedUser = await storage.read('user');
    if (storedUser != null) {
      // return User.fromJson(storedUser);
    }
    super.onReady();
  }

  RxList<OnBoardingModel> onBoardingList = <OnBoardingModel>[
    OnBoardingModel(
        title: 'Major Innovation in Real Estate  Industry',
        imageUrl: Constant.onboardingImage1),
    OnBoardingModel(
        title: 'Provide Solution for Everyone',
        imageUrl: Constant.onboardingImage2),
    OnBoardingModel(
        title: 'The Hunt for Best Real Estate ends here.',
        imageUrl: Constant.onboardingImage3),
    OnBoardingModel(
        title: 'Major Innovation in Real Estate  Industry.',
        imageUrl: Constant.onboardingImage4)
  ].obs;
}
