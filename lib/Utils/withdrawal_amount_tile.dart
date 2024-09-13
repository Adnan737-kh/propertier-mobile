import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget withdrawalTile(BuildContext context,
    {required String bankName,
    required String date,
    required String ammount,
    required String bankIcon}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: EdgeInsets.symmetric(
        horizontal: context.getSize.width * 0.020,
        vertical: context.getSize.height * 0.008),
    decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        border: border(),
        boxShadow: [boxShadow()]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              bankIcon,
              height: context.getSize.height * 0.05,
              width: context.getSize.height * 0.05,
            ),
            getWidth(context, 0.012),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText(
                    title: bankName,
                    context: context,
                    colorOpecity: 0.6,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                appText(
                    title: date,
                    context: context,
                    colorOpecity: 0.7,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ],
            )
          ],
        ),
        appText(
            title: ammount,
            context: context,
            colorOpecity: 0.6,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ],
    ),
  );
}
