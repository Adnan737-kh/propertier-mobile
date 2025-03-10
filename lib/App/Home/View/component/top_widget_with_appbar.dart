import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/Utils/animated_toggle.dart';
import 'package:propertier/App/Home/View/component/carousel_slider_widget.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/App Ad Mob/app_banner_ads.dart';
import '../../../NavBar/ViewModel/navbar_view_model.dart';

PreferredSize homeAppBar(
    {required BuildContext context, required HomeViewModel viewModel}) {
  return PreferredSize(
    preferredSize: Size(
        context.getSize.width,
        Platform.isAndroid
            ? context.getSize.height * (0.45 - 0.030)
            : context.getSize.height * (0.45 - 0.030)),
    child: Container(
      padding: EdgeInsets.only(
        left: context.getSize.width * 0.030,
        right: context.getSize.width * 0.030,
        bottom: context.getSize.height * 0.007,
      ),
      decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(-1, 1),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Column(
        children: [
          getHeight(context, 0.06),
          //!Profile and Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.find<NavBarViewModel>().changeSelectedTab(2);
                    },
                    child: CircleAvatar(
                        radius: context.isPhone ? 20 : 40,
                        backgroundImage: NetworkImage(viewModel.profileImage ??
                            "https://images.unsplash.com/photo-1511367461989-f85a21fda167"
                                "?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: appText(
                      title: viewModel.userName ?? "",
                      context: context,
                      fontSize: 14,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              //*Logo
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      viewModel.isHomeDataAvailable.value = false;
                      viewModel.homeModel.value =
                          await viewModel.getHomePageData(context: context);
                      viewModel.isHomeDataAvailable.value = true;
                    },
                    child: Image.asset(
                      Constant.onboardingIcon,
                      height: context.getSize.height * 0.03,
                    ),
                  ),
                ],
              ),
              //*Rent and buy button
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AnimatedToggle(
                      values: const ['Buy', 'Rent'],
                      onToggleCallback: (val) {
                        viewModel
                            .changeSale(val, context)
                            .whenComplete(() async {
                          // viewModel.isHomeDataAvailable.value = false;
                          viewModel.homeModel.value =
                              await viewModel.getHomePageData(context: context);
                          // viewModel.isHomeDataAvailable.value = true;
                        });
                      }),
                  const Gap(30),
                  Row(
                    children: [
                      const Icon(Ionicons.cart_outline),
                      getWidth(context, 0.020),
                      const Icon(Icons.favorite_border_outlined)
                    ],
                  ),
                ],
              )
            ],
          ),
          getHeight(context, 0.01),
          CarouselSliderWidget(),
          SizedBox(
            height: 50,
              width: Get.width,
              child: const AppBannerAd()),
          getHeight(context, 0.010),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(viewModel.tabList.length, (index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.viewMore(false);
                        if (index == 2) {
                          Get.toNamed(AppRoutes.servicesView);
                        }
                        if (index == 4) {
                          Get.toNamed(AppRoutes.marketPlaceView);
                        }
                        viewModel.changeTabIndex(index);
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: viewModel.selectedTabIndex == index
                                  ? const Border(
                                      bottom: BorderSide(
                                      color: AppColor.buttonColor,
                                      width: 1,
                                    ))
                                  : null),
                          child: Obx(
                            () => appText(
                                title: viewModel.tabList[index],
                                context: context,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: viewModel.selectedTabIndex == index
                                    ? AppColor.buttonColor
                                    : AppColor.primaryColor),
                          ),
                        ),
                      ),
                    ),
                    index == viewModel.tabList.length - 1
                        ? const SizedBox.shrink()
                        : Container(
                            height: context.getSize.height * 0.03,
                            width: 1,
                            color: AppColor.primaryColor,
                          )
                  ],
                );
              }),
            ),
          )
        ],
      ),
    ),
  );
}
