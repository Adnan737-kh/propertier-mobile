import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../constant/constant.dart';
import '../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../../NavBar/ViewModel/navbar_view_model.dart';
import '../Components/drawer_tile.dart';

Widget customDrawer({required BuildContext context}) {
  return Container(
    color: AppColor.primaryColor,
    width: context.getSize.width * 0.8,
    height: context.getSize.height,
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.getSize.width * 0.060,
          vertical: context.getSize.height * 0.060),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  Constant.drawerLogo,
                  height: context.getSize.height * 0.043,
                )),
            const Gap(24),
            CustomText(
                title: context.local.dashboard,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            const Gap(15),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.accountStatusView),
              context: context,
              title: context.local.account_status,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.editProfileView),
              context: context,
              title: context.local.edit_profile,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.changePasswordView),
              context: context,
              title:context.local.change_password,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.customerWallet),
              context: context,
              title: context.local.wallet,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.verificationView),
              context: context,
              title: context.local.verification,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.requestDemandView),
              context: context,
              title: context.local.request_properties,
            ),
            divider(context: context),


            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.settingsView),
              context: context,
              title: context.local.settings,
            ),
            divider(context: context),

            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.privacyView),
              context: context,
              title: context.local.privacy,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.policyView),
              context: context,
              title:context.local.policy,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.supportView),
              context: context,
              title: context.local.support,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.languageView),
              context: context,
              title: context.local.language,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.aboutView),
              context: context,
              title:context.local.about,
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.activityView),
              context: context,
              title: context.local.activity,
            ),


            InkWell(
              onTap: () async {
                final up = UserPreference();
                final success = await up.logOut();
                if (success) {
                  Get.offAllNamed(AppRoutes.navBarView);
                  Get.find<NavBarViewModel>().changeSelectedTab(4);
                } else {
                  // Show error or toast if needed
                  if (kDebugMode) {
                    print("⚠️ Failed to clear preferences");
                  }
                }
              },
              child: Container(
                width: context.width,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColor.backgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: AppColor.buttonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.logout,
                        color: AppColor.backgroundColor,
                      ),
                    ),
                    CustomText(
                        title:context.local.sign_out ,
                        fontWeight: FontWeight.bold)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
