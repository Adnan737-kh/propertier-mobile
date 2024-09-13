import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constant/call_launcher.dart';
import '../../../constant/colors.dart';
import '../../Home/Model/properties_tiler_button_model.dart';
import '../../Profile/Model/profile_model.dart';
import '../../Profile/Service/profile_service.dart';

class ServiceProviderProfileViewModel extends GetxController {
  Rx<ProfileModel> ServiceProviderprofileModel = ProfileModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    //  await AuthService().getCurrentUser().then((value) async {
    // } );
    ServiceProviderprofileModel.value =
        await getProfilePageData(context: Get.context!, id: Get.arguments);
    print(ServiceProviderprofileModel.value.userProfile);
    // TODO: implement onInit
    super.onInit();
  }

  final RxBool _isShowMoreComment = false.obs;
  bool get isShowMoreComment => _isShowMoreComment.value;
  showMoreComment(bool value) {
    _isShowMoreComment.value = value;
  }

  RxList<PropertiesTileButtonModel> propertiesTileButtonList =
      <PropertiesTileButtonModel>[
    PropertiesTileButtonModel(
        onTap: (val) {
          if (val != '') {
            launchCallandSMS(type: 'sms', phoneNumber: val!);
          }
        },
        title: "SMS",
        color: AppColor.white,
        icon: null,
        titleColor: AppColor.greenColor,
        borderColor: AppColor.greenColor),
    PropertiesTileButtonModel(
        onTap: (val) async {
          if (val != '') {
            launchCallandSMS(type: 'tel', phoneNumber: val!);
          }
        },
        titleColor: AppColor.white,
        borderColor: AppColor.greenColor,
        title: 'Call',
        color: AppColor.greenColor,
        icon: Ionicons.call),
    PropertiesTileButtonModel(
        onTap: (val) async {
          if (val != '') {
            launchCallandSMS(type: 'tel', phoneNumber: val!);
          }
        },
        titleColor: AppColor.backgroundColor,
        borderColor: AppColor.forgroundColor,
        title: 'Chat',
        color: AppColor.forgroundColor,
        icon: null),
  ].obs;

  Future<ProfileModel> getProfilePageData({
    required BuildContext context,
    required String id,
  }) async {
    isLoading.value = true;

    final result =
        await ProfileService().getProfileDetail(context: context, id: id);
    if (result.userProfile != null) {
      ServiceProviderprofileModel.value = result;
      print(
          "print posts Length ${ServiceProviderprofileModel.value.properties!.length}");
      isLoading.value = false;
    }
    isLoading.value = false;
    return ServiceProviderprofileModel.value;
  }
}
