import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/box_shadow.dart';

import '../../../../constant/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color borderColor;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final double fontSize;
  final double radius;
  final double height;
  final double width;
  final IconData? icondata;
  final double shadowColorOpacity;
  final Color shadowColor;
  final FontWeight fontWeight;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.borderColor = Colors.transparent,
    this.buttonColor = AppColor.buttonColor,
    this.textColor = Colors.black,
    this.iconColor = Colors.white,
    this.fontSize = 14,
    this.radius = 10,
    this.height = 48,
    this.width = double.infinity,
    this.icondata,
    this.shadowColorOpacity = 0.25,
    this.shadowColor = Colors.black,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [boxShadow()],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icondata != null
                  ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  icondata,
                  color: iconColor,
                  size: 20,
                ),
              )
                  : const Gap(0),
              Center(
                child: CustomText(
                  title: title,
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
