import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget infoTile(BuildContext context,
    {required String title,
    required String subtitle,
    double titleWidth = 0.3,
    double subtitleWidth = 0.40,
    double titleFontSize = 14,
    double subtitleFontSize = 12,
    bool isShowIcon = false,
    Color titleColor = AppColor.blackColor,
    Color subtitleColor = AppColor.blackColor,
    double titleOpacity = 0.7,
    double subtitleOpacity = 0.8,
    FontWeight subtitleFontWeight = FontWeight.w400,
    FontWeight titleFontWeight = FontWeight.bold,
    String? icon}) {
  return Row(
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: context.getSize.width * titleWidth,
        child: appText(
            textAlign: TextAlign.start,
            title: "$title: ",
            context: context,
            color: titleColor,
            fontSize: titleFontSize,
            colorOpecity: titleOpacity,
            fontWeight: titleFontWeight),
      ),
      isShowIcon == false
          ? const SizedBox.shrink()
          : Image.asset(icon!, width: context.getSize.width * 0.040),
      isShowIcon == false ? const SizedBox.shrink() : getWidth(context, 0.011),
      scrollableText(
        width: subtitleWidth,
        title: subtitle,
        context: context,
        textStyle: textStyle(
          color: subtitleColor.withOpacity(subtitleOpacity),
          context: context,
          fontSize: subtitleFontSize,
          fontWeight: subtitleFontWeight,
        ),
      ),
    ],
  );
}
