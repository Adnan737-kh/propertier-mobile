import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Model/all_properties_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/area_convert_extension.dart';
import 'package:propertier/extensions/dimension_extension.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/price_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:propertier/extensions/tags_remove_extension.dart';

import '../../../../extensions/ago_time_converter.dart';
import '../../../../extensions/navigate_to_dailpad.dart';
import '../../../What are you searching/View/Components/custom_botton_wryf.dart';

Widget propertiesTile(
  BuildContext context, {
  required Property property,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 05),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.buttonColor.withOpacity(0.0)),
    height: sizeHeight(0.33, 0.3),
    width: double.infinity,
    child: Stack(
      fit: StackFit.loose,
      alignment: Alignment.topCenter,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.detailView,
                arguments: {"id": property.id, "user": "null"});
          },
          child: Container(
            height: sizeHeight(0.22, 0.18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image:
                        NetworkImage(property.imageUrl ?? Constant.dummayImage),
                    fit: BoxFit.cover)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: sizeWidth(0.35, 0.2)),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.015,
                vertical: context.getSize.height * 0.010),
            margin: EdgeInsets.only(
              left: sizeWidth(0.020, 0.010),
              right: sizeWidth(0.020, 0.010),
            ),
            // height: context.getSize.height * 0.195,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [boxShadow()]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    scrollableText(
                        context: context,
                        textStyle: textStyle(
                            context: context,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.blackColor),
                        title: property.title!.parseHtmlString()),
                    appText(
                        title: property.price!.isNum
                            ? double.parse(property.price!).formatPrice()
                            : property.price!,
                        context: context,
                        fontSize: 12,
                        color: AppColor.greenColor,
                        fontWeight: FontWeight.w700,
                        colorOpecity: 0.8)
                  ],
                ),
                getHeight(context, 0.006),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Ionicons.location,
                      color: AppColor.buttonColor,
                      size: sizeWidth(0.030, 0.020),
                    ),
                    scrollableText(
                        context: context,
                        textStyle: textStyle(
                            context: context,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor.withOpacity(0.8)),
                        title: property.address!),
                    const Spacer(),
                    appText(
                        title: property.areaType?.toUpperCase() ?? "",
                        context: context,
                        fontSize: 12,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500,
                        colorOpecity: 0.8)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    appText(
                        title: getTimeAgo(property.createdAt!),
                        context: context,
                        colorOpecity: 0.7,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                getHeight(context, 0.004),
                divider(context: context),
                getHeight(context, 0.0072),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: context.getSize.width * 0.3,
                      child: appText(
                          textAlign: TextAlign.start,
                          title: "${context.local.area}: ",
                          context: context,
                          fontSize: 12,
                          colorOpecity: 0.8,
                          fontWeight: FontWeight.bold),
                    ),
                    Image.asset(Constant.marla,
                        width: context.getSize.width * 0.040),
                    getWidth(context, 0.010),
                    scrollableText(
                      width: 0.40,
                      title:
                          '${double.parse(property.area.toString()).convertArea(areaType: property.areaUnit ?? '')} ${property.areaUnit ?? ''}',
                      context: context,
                      textStyle: textStyle(
                        // color: AppColor.blackColor.withOpacity(0.8),
                        withOpacity: 0.7,
                        context: context,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                getHeight(context, 0.0072),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: context.getSize.width * 0.3,
                      child: appText(
                          textAlign: TextAlign.start,
                          title: "${context.local.dimension}: ",
                          context: context,
                          fontSize: 12,
                          colorOpecity: 0.8,
                          fontWeight: FontWeight.bold),
                    ),
                    Image.asset(Constant.marla,
                        width: context.getSize.width * 0.030),
                    getWidth(context, 0.010),
                    scrollableText(
                      width: 0.40,
                      title: double.parse(property.area.toString())
                          .squareOrRectangleDimensions(),
                      context: context,
                      textStyle: textStyle(
                        // color: AppColor.blackColor.withOpacity(0.5),
                        withOpacity: 0.7,
                        context: context,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                getHeight(context, 0.01),
                Row(
                  children: [
                    getWidth(context, 0.020),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    )),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    customButton(
                                      title: "Call",
                                      onTap: () {
                                        openDialer(property.agent!
                                                .phoneNumberCountryCode! +
                                            property.agent!.phoneNumber!);
                                      },
                                    ),
                                    const Gap(10),
                                    customButton(
                                      title: "SMS",
                                      onTap: () {
                                        textMe(property.agent!
                                                .phoneNumberCountryCode! +
                                            property.agent!.phoneNumber!);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(42),
                                color: AppColor.greenColor),
                            child: appText(
                                color: AppColor.white,
                                title: 'Buy',
                                context: context,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                    getWidth(context, 0.020),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.detailView,
                                arguments: {"id": property.id, "user": "null"});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.buttonColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(42),
                                color: AppColor.buttonColor),
                            child: appText(
                                color: AppColor.blackColor,
                                title: 'Detail',
                                context: context,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
