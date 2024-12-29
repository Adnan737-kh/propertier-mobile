import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Services/Model/ServiceDashboardModel.dart';
import 'package:propertier/App/What%20are%20you%20searching/View/Components/custom_botton_wryf.dart';
import 'package:propertier/Customer/screens/ServiceDetail/ServiceDetailController.dart';
import 'package:propertier/Utils/app_text.dart';
import '../../../RoutesAndBindings/app_routes.dart';
import '../../../extensions/navigate_to_dailpad.dart';
import 'components/component.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../ServiceDetail/components/DetailTile.dart';

// ignore: must_be_immutable
class ServiceDetail extends GetView<ServiceDetailController> {
  ServiceDetail({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.backgroundColor),
    );
    return Scaffold(
      body: CustomScrollView(
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: Platform.isAndroid
                ? context.getSize.height * (0.36 - 0.030)
                : context.getSize.height * (0.31 - 0.030),
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.only(
                  top: context.getSize.height * 0.03,
                  left: context.getSize.width * 0.090,
                  right: context.getSize.width * 0.090),
              centerTitle: true,
              title: AnimatedOpacity(
                opacity: controller.isCollapsed ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.white,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          size: context.isPhone ? 30 : 40,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.share,
                            size: context.isPhone ? 30 : 40,
                            color: AppColor.blackColor,
                          ),
                        ),
                        getWidth(context, 0.020),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            Constant.heartunFill,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              background: detailsAppBar(
                context,
                favoriteCallBack: () {},
                controller: controller,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                // Build the list of items
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getSize.width * 0.010),
                  child: detailTile(context,
                      controller: controller
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      // controller.service.vendor == null ?
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: 8, horizontal: context.getSize.width * 0.070),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.blackColor.withOpacity(0.3),
            ),
            color: AppColor.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: appText(
                    title: controller.service.visitingCharges !=
                        null
                        ? "${controller.service.visitingCharges} PKR"
                        : "",
                    context: context,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
              Expanded(
                flex: 1,
                child: customButton(
                    fontSize: 14,
                    radius: 50,
                    fontWeight: FontWeight.w500,
                    buttonColor: AppColor.buttonColor,
                    textColor: AppColor.blackColor,
                    height: 39,
                    title: "Get Service",
                    onTap: () {
                      Get.toNamed(AppRoutes.nearesServiceDetail,
                          arguments: controller.service);
                      // Get.bottomSheet(
                      //   Container(
                      //     padding: const EdgeInsets.all(8),
                      //     decoration: const BoxDecoration(
                      //         color: AppColor.white,
                      //         borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(10),
                      //           topRight: Radius.circular(10),
                      //         )),
                      //     child: Column(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         customButton(
                      //           title: "Call",
                      //           onTap: () {
                      //             openDialer("+92${controller.service.vendor?.phoneNumber??""}");
                      //           },
                      //         ),
                      //         const Gap(10),
                      //         customButton(
                      //           title: "SMS",
                      //           onTap: () {
                      //             textMe("+92${controller.service.vendor?.phoneNumber??""}");
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    }),
              )
            ],
          ),
        ),
      )
          // : null,
    );
  }
}
