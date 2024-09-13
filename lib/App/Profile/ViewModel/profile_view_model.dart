import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Analytics/Model/chart_data_model.dart';
import 'package:propertier/App/Home/Model/comment_button_model.dart';
import 'package:propertier/App/Profile/Model/profile_model.dart';

import '../../../constant/call_launcher.dart';
import '../../../constant/colors.dart';
import '../../Home/Model/properties_tiler_button_model.dart';

import '../Service/profile_service.dart';

class ProfileViewModel extends GetxController {
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    profileModel.value = await getProfilePageData(
        context: Get.context!, id: GetStorage().read("id").toString());

    super.onInit();
  }

  final List<SalesData> spline1ThisWeek = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 90),
    SalesData('Apr', 32),
    SalesData('May', 50),
    SalesData('Jun', 90),
    SalesData('Jul', 200),
    SalesData('Aug', 40),
    SalesData('Sep', 150),
    SalesData('Oct', 100),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
  final List<SalesData> splin2ThisWeek = [
    SalesData('Jan', 50),
    SalesData('Feb', 18),
    SalesData('Mar', 30),
    SalesData('Apr', 52),
    SalesData('May', 60),
    SalesData('Jun', 100),
    SalesData('Jul', 200),
    SalesData('Aug', 250),
    SalesData('Sep', 150),
    SalesData('Oct', 10),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
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

  RxList<CommentButtonModel> commentButtonsList = <CommentButtonModel>[
    CommentButtonModel(icon: Ionicons.chatbubble_outline, title: '1'),
    CommentButtonModel(icon: Ionicons.return_up_back_outline, title: '4'),
    CommentButtonModel(icon: Ionicons.heart_outline, title: '2'),
    CommentButtonModel(icon: Ionicons.stats_chart_outline, title: '4'),
    CommentButtonModel(icon: Ionicons.share_social_outline, title: '')
  ].obs;

  Future<ProfileModel> getProfilePageData({
    required BuildContext context,
    required String id,
  }) async {
    isLoading.value = true;

    final result =
        await ProfileService().getProfileDetail(context: context, id: id);
    if (result.userProfile != null) {
      profileModel.value = result;
      // print("print posts Length ${profileModel.value.data!.properties.length}");
      isLoading.value = false;
    }
    isLoading.value = false;
    return profileModel.value;
  }

  // ProfileModel profileModel = ProfileModel();
}
