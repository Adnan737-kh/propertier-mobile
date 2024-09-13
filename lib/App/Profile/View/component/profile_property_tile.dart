import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
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

import '../../../../Model/property.dart';

Widget propertiesTile(BuildContext context, {required Property property}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.buttonColor.withOpacity(0.0)),
    height: context.getSize.height * 0.3,
    width: double.infinity,
    child: Stack(
      fit: StackFit.loose,
      alignment: Alignment.topCenter,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.detailView, arguments: property.id);
          },
          child: Container(
            // alignment: Alignment.center,
            height: context.getSize.height * 0.22,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(
                        Constant.propertyImagesUrl + property.image!),
                    fit: BoxFit.cover)),
            // child: VideoThumbnailTile(videoUrl: videoModel.videoUrl,)
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: context.getSize.width * 0.3),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.010,
                vertical: context.getSize.height * 0.005),
            margin: EdgeInsets.only(
                left: context.getSize.width * 0.020,
                right: context.getSize.width * 0.020),
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
                        title: double.parse(property.price!).formatPrice(),
                        context: context,
                        fontSize: 14,
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
                      size: context.getSize.width * 0.030,
                    ),
                    scrollableText(
                        context: context,
                        textStyle: textStyle(
                            context: context,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor.withOpacity(0.8)),
                        title: property.address!),
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
                    Expanded(
                      child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: border(color: AppColor.greenColor),
                                borderRadius: BorderRadius.circular(42),
                                color: AppColor.white),
                            child: appText(
                                color: AppColor.greenColor,
                                title: 'Chat',
                                context: context,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                    getWidth(context, 0.020),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                // border: Border.all(
                                //   color: AppColor.buttonColor,
                                //   width: 1,
                                // ),
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
                                arguments: property.id);
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
