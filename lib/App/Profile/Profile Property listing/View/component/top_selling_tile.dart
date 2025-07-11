import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:propertier/App/PropertiesAndShortVideo/Model/prorperties_tile_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../Model/prorperties_tile_model.dart';

Widget topSellingListTile(BuildContext context,
    {required ArchitectureModel architecture}) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: context.getSize.width * 0.010,
        vertical: context.getSize.height * 0.005),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.white,
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.2),
        boxShadow: [boxShadow()]),
    child: Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.030,
                vertical: context.getSize.height * 0.005),
            height: context.getSize.height * 0.2,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                    image: NetworkImage(Constant.dummyImage),
                    fit: BoxFit.cover)),
            child: SvgPicture.asset(architecture.isFavorite == true
                ? Constant.heartFill
                : Constant.heartUnFill)),
        getHeight(context, 0.010),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            scrollableText(
                context: context,
                textStyle: textStyle(
                    context: context,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackColor),
                title: architecture.title),
            CustomText(
                title: architecture.time,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                colorOpecity: 0.8)
          ],
        ),
        getHeight(context, 0.005),
        divider(context: context, color: AppColor.blackColor.withOpacity(0.3)),
        getHeight(context, 0.006),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: context.getSize.width * 0.3,
              child: CustomText(
                  textAlign: TextAlign.start,
                  title: context.local.basic_price,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            scrollableText(
              width: 0.44,
              title: architecture.price,
              context: context,
              textStyle: textStyle(
                color: AppColor.blackColor.withOpacity(0.8),
                context: context,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        getHeight(context, 0.006),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: context.getSize.width * 0.3,
              child: CustomText(
                  textAlign: TextAlign.start,
                  title: "${context.local.location}: ",
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            scrollableText(
              width: 0.44,
              title: architecture.location,
              context: context,
              textStyle: textStyle(
                color: AppColor.blackColor.withOpacity(0.8),
                context: context,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        getHeight(context, 0.006),
        architecture.area != ''
            ? Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.getSize.width * 0.3,
                    child: CustomText(
                        textAlign: TextAlign.start,
                        title: "${context.local.area}: ",
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  Image.asset(Constant.marla,
                      width: context.getSize.width * 0.030),
                  getWidth(context, 0.010),
                  scrollableText(
                    width: 0.40,
                    title: architecture.price,
                    context: context,
                    textStyle: textStyle(
                      color: AppColor.blackColor.withOpacity(0.8),
                      context: context,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        getHeight(context, 0.007),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42),
                        color: AppColor.buttonColor),
                    child: CustomText(
                        color: AppColor.white,
                        title: context.local.talk,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            getWidth(context, 0.020),
            Expanded(
              child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.buttonColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(42),
                        color: AppColor.buttonColor.withOpacity(0.2)),
                    child: CustomText(
                        color: AppColor.buttonColor,
                        title: context.local.detail,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )),
            )
          ],
        )
      ],
    ),
  );
}
