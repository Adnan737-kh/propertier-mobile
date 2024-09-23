import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/font_size_extension.dart';

Text appText({
  required String title,
  double fontSize = 14,
  required BuildContext context,
  TextDecoration textDecoration = TextDecoration.none,
  TextAlign textAlign = TextAlign.center,
  Color color = AppColor.primaryColor,
  TextOverflow? overflow,
  double colorOpecity = 1.0,
  String fontFamily = 'Rubik',
  TextStyle? style,
  FontWeight fontWeight = FontWeight.normal,
  int? maxLines,
}) {
  return Text(
    title,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    style: style ??
        TextStyle(
          decoration: textDecoration,
          fontSize: context.fontSize(fontSize),
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          color: color.withOpacity(colorOpecity),
        ),
  );
}
