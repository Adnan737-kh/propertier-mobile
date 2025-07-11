import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

typedef OnClick = Function();
Widget textButton(
    {required BuildContext context,
    double height = 0,
    double width = 0,
    double radius = 10,
    required String title,
    double textFontSize = 14,
    Color? textColor,
    FontWeight textFontWeight = FontWeight.w500,
    Color shadowColor = Colors.black,
    Color buttonColor = AppColor.buttonColor,
    Color borderColor = Colors.transparent,
    required OnClick onClick,
    double shadowColorOpacity = 0.25}) {
  return GestureDetector(
    onTap: onClick,
    child: Container(
      alignment: Alignment.center,
      height: height == 0
          ? context.getSize.height * 0.058
          : context.getSize.height * height,
      width: width == 0 ? context.getSize.width : context.getSize.width * width,
      decoration: BoxDecoration(
          border: border(color: borderColor),
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
                color: shadowColor.withOpacity(shadowColorOpacity),
                offset: const Offset(-4, 4),
                blurRadius: 4,
                spreadRadius: 0)
          ]),
      child: CustomText(
          title: title,
          color: textColor ?? AppColor.blackColor,
          fontSize: textFontSize,
          fontWeight: textFontWeight),
    ),
  );
}
