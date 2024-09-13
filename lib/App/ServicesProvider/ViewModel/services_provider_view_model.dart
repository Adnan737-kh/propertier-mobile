import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Otp/OtpVerify/Model/social_media_button_model.dart';
import 'package:propertier/constant/constant.dart';

class ServicesProviderViewModel extends GetxController {
  final RxBool _isExpanded = false.obs;
  bool get isExpanded => _isExpanded.value;
  isExpand(bool value) {
    _isExpanded.value = value;
  }

  TextEditingController searchController = TextEditingController();
  RxList<SocialMediaButtonModel> socialMediaButtonsList =
      <SocialMediaButtonModel>[
    SocialMediaButtonModel(icon: Constant.facebook, onTap: () {}),
    SocialMediaButtonModel(icon: Constant.twitter, onTap: () {}),
    SocialMediaButtonModel(icon: Constant.instagram, onTap: () {}),
    SocialMediaButtonModel(icon: Constant.youtube, onTap: () {}),
  ].obs;
}
