import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/extensions/size_extension.dart';

typedef OnClick = Function();
acceptRejectButton(
    {required BuildContext context,
    required Color textColor,
    double radius = 10,
    required String title,
    double textFontSize = 20,
    FontWeight textFontWeight = FontWeight.w500,
    Color shadowColor = Colors.black,
    required Color color,
    required OnClick onClick,
    double shadowColorOpacity = 0.25}) {
  return GestureDetector(
    onTap: onClick,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: context.getSize.width * 0.040,
          vertical: context.getSize.height * 0.005),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: CustomText(
          title: title,
          color: textColor,
          fontSize: textFontSize,
          fontWeight: textFontWeight),
    ),
  );
}
