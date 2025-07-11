import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/font_size_extension.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final TextDecoration textDecoration;
  final TextAlign textAlign;
  final Color color;
  final TextOverflow? overflow;
  final double colorOpecity;
  final String fontFamily;
  final TextStyle? style;
  final FontWeight fontWeight;
  final int? maxLines;

  const CustomText({
    super.key,
    required this.title,
    this.fontSize = 14,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.center,
    this.color = AppColor.primaryColor,
    this.overflow,
    this.colorOpecity = 1.0,
    this.fontFamily = 'Rubik',
    this.style,
    this.fontWeight = FontWeight.normal,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
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
}
