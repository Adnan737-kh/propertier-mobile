import 'package:flutter/material.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';

Widget insideAppBarTile(BuildContext context,
    {required String title}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      scrollableText(
          context: context,
          textStyle: textStyle(
              context: context,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.blackColor.withOpacity(0.6)),
          title: title),
      GestureDetector(
        onTap: () {},
        child: Image.asset(
          Constant.acFilter,
          height: 22,
        ),
      )
    ],
  );
}
