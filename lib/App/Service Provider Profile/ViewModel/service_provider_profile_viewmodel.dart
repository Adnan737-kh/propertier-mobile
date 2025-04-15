import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constant/call_launcher.dart';
import '../../../constant/colors.dart';
import '../../../repository/profile_repo/profile_view/profile_view_repo.dart';
import '../../Home/Model/properties_tiler_button_model.dart';
import '../../Profile/Model/profile_model.dart';

class ServiceProviderProfileViewModel extends GetxController {
  Rx<ProfileModel> serviceProviderProfileModel = ProfileModel().obs;
  var isLoading = false.obs;
  final RxBool _isShowMoreComment = false.obs;
  bool get isShowMoreComment => _isShowMoreComment.value;
  final ProfileViewRepository _repository = ProfileViewRepository();

  @override
  void onInit() async {
    // Retrieve agent ID from arguments
    final String? agentIdFromArguments = Get.arguments;
    debugPrint("Received Agent ID from arguments: $agentIdFromArguments");

    // First, try fetching using userProfile!.id if available
    String? fetchId =
        serviceProviderProfileModel.value.userProfile?.id?.toString();

    // If userProfile ID is not available, use agent ID from arguments
    fetchId ??= agentIdFromArguments;

    if (fetchId != null) {
      if (kDebugMode) {
        print("fetch id $fetchId");
      }
      serviceProviderProfileModel.value = await getProfilePageData(
        context: Get.context!,
        agentID: agentIdFromArguments!,
      );
    }

    if (kDebugMode) {
      print('Service Profile ${serviceProviderProfileModel.value.userProfile}');
    }
    super.onInit();
  }

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
    required String agentID,
  }) async {
    isLoading.value = true;

    final result = await _repository.viewServicesProfileDetails(agentID);
    // ProfileService().getProfileDetail(context: context, agentID: agentID);
    if (result.userProfile != null) {
      serviceProviderProfileModel.value = result;
      isLoading.value = false;
    }
    isLoading.value = false;
    return serviceProviderProfileModel.value;
  }
}
