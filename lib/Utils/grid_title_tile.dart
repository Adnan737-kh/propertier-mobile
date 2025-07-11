import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

Widget gridTitleTile(
  BuildContext context, {
  required String title,
  double fontSize = 18,
  required VoidCallback callBack,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
          title: title,
          fontSize: fontSize,
          fontWeight: FontWeight.w500),
      GestureDetector(
          onTap: callBack,
          child: CustomText(
              title: context.local.view_more,
              fontSize: 12,
              color: AppColor.greenColor,
              fontWeight: FontWeight.w500))
    ],
  );
}
