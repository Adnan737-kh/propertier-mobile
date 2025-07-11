import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

customAppBar(
    {double fontSize = 16,
    double iconSize = 0.016,
    FontWeight fontWeight = FontWeight.bold,
    String title = '',
    required BuildContext context,
    required VoidCallback onTap}) {
  return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SvgPicture.asset(
          Constant.backArrow,
          width: context.getSize.height * iconSize,
          height: context.getSize.height * iconSize,
        ),
      ),
    ),
    SizedBox(
      width: context.getSize.width * 0.010,
    ),
    CustomText(
      title: title,
      fontWeight: fontWeight,
      color: AppColor.textColor,
      fontSize: 14,
    ),
  ]);
}
