import 'package:get/get.dart';
import 'package:propertier/App/Settings/Model/settings_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../Account Delete/View/account_deleting_view.dart';

class SettingsViewModel extends GetxController {


  RxList<SettingsModel> settingsList = <SettingsModel>[
    SettingsModel(
        onTap: () {
          Get.toNamed(AppRoutes.editProfileView);
        },
        title: Get.context!.local.edit_profile),
    SettingsModel(
        onTap: () {
          Get.toNamed(AppRoutes.verificationView);
        },
        title: Get.context!.local.verification),
    SettingsModel(
        onTap: () {
          Get.toNamed(AppRoutes.earningsView);
        },
        title: Get.context!.local.earnings),
    SettingsModel(onTap: () {}, title: Get.context!.local.my_orders),
    SettingsModel(onTap: () {}, title: Get.context!.local.official_team),
    SettingsModel(onTap: () {}, title: Get.context!.local.marketing_team),
    SettingsModel(
        onTap: () {
          Get.toNamed(AppRoutes.languageView);
        },
        title: Get.context!.local.language),
    SettingsModel(
        onTap: () {
          Get.toNamed(AppRoutes.payoutView);
        },
        title: Get.context!.local.payout),
    SettingsModel(
        onTap: () {
          Get.to(() =>  AccountDeletionScreen());
        },
        title: Get.context!.local.deleteAccount),
  ].obs;
}
