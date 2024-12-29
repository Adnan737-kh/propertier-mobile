import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Auth/Service/auth_service.dart';
import 'package:propertier/App/Auth/Service/google_sigin_services.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../constant/constant.dart';
import '../Components/drawer_tile.dart';
// import '../../Utils/logo_tile.dart';

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
                  Constant.drawerlogo,
                  height: context.getSize.height * 0.043,
                )),
            const Gap(24),
            appText(
                title: "Dashboard",
                context: context,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            const Gap(15),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.accountStatusView),
              context: context,
              title: "Account Status",
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.editProfileView),
              context: context,
              title: "Edit Profile",
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.CustomerWallet),
              context: context,
              title: "Wallet",
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.verificationView),
              context: context,
              title: "Verification",
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.requestDemandView),
              context: context,
              title: "Request Properties",
            ),
            divider(context: context),

            // drawerTile(
            //   onTap: () => Get.toNamed(AppRoutes.earningsView),
            //   context: context,
            //   title: "Earnings",
            // ),
            // divider(context: context),
            // drawerTile(
            //   onTap: () => Get.toNamed(AppRoutes.analyticsView),
            //   context: context,
            //   title: "Analytics",
            // ),
            // divider(context: context),
            // drawerTile(
            //   context: context,
            //   title: "Inventory",
            // ),
            // divider(context: context),
            // drawerTile(
            //   context: context,
            //   title: "Sales",
            // ),
            // divider(context: context),
            // drawerTile(
            //   onTap: () => Get.toNamed(AppRoutes.adsView),
            //   context: context,
            //   title: "Ads",
            // ),
            // divider(context: context),
            // drawerTile(
            //   onTap: () => Get.toNamed(AppRoutes.myOrderView),
            //   context: context,
            //   title: "My Orders",
            // ),
            // divider(context: context),
            // drawerTile(
            //   context: context,
            //   title: "Pending Orders",
            // ),
            // divider(context: context),
            // drawerTile(
            //   onTap: () => Get.toNamed(AppRoutes.oficialTeamView),
            //   context: context,
            //   title: "Official team",
            // ),
            // divider(context: context),
            // drawerTile(
            //   context: context,
            //   title: "Marketing Team",
            // ),
            // divider(context: context),

            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.settingsView),
              context: context,
              title: "Settings",
            ),
            divider(context: context),

            // drawerTile(
            //   onTap: () => Get.toNamed(AppRoutes.reviewView),
            //   context: context,
            //   title: "Reviews",
            // ),
            // divider(context: context),

            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.privacyView),
              context: context,
              title: "Privacy",
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.policyView),
              context: context,
              title: "Policy",
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.supportView),
              context: context,
              title: "Support",
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.languageView),
              context: context,
              title: "Language",
            ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.aboutView),
              context: context,
              title: "About",
            ),
            // divider(context: context),
            // drawerTile(
            //   onTap: () => Get.toNamed(AppRoutes.offeredServices),
            //   context: context,
            //   title: "Offerd Services",
            // ),
            divider(context: context),
            drawerTile(
              onTap: () => Get.toNamed(AppRoutes.activityView),
              context: context,
              title: "Activity",
            ),

            // divider(context: context),
            // drawerTile(
            //   context: context,
            //   title: "Post Listings",
            // ),
            // divider(context: context),
            // drawerTile(
            //   context: context,
            //   title: "All Listings",
            // ),
            // divider(context: context),
            // drawerTile(
            //   context: context,
            //   title: "Ai Video Editing",
            // ),
            // divider(context: context),
            // drawerTile(
            //   context: context,
            //   title: "Ai Image Editing",
            // ),
            // divider(context: context),
            // drawerTile(
            //   context: context,
            //   title: "Report",
            // ),
            // divider(context: context),
            // drawerTile(
            //   onTap: () => Get.toNamed(AppRoutes.payoutView),
            //   context: context,
            //   title: "Pay out",
            // ),

            InkWell(
              onTap: () {
                AuthService().logout();
                GoogleSiginServices().logout();
                Get.offAllNamed(AppRoutes.loginView);
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
                    appText(
                        title: "Sign Out",
                        context: context,
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
