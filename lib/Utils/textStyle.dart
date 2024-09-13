import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/font_size_extension.dart';

textStyle(
    {required BuildContext context,
    String fontFamily = 'Rubik',
    TextOverflow? overflow,
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 16.0,
    double withOpacity = 1.0,
    Color color = AppColor.primaryColor}) {
  return TextStyle(
      fontFamily: fontFamily,
      fontSize: context.fontSize(fontSize),
      fontWeight: fontWeight,
      overflow: overflow,
      color: color.withOpacity(withOpacity));
}
