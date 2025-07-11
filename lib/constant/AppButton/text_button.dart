import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../Utils/box_shadow.dart';
import '../colors.dart';

Widget customTextButton({
  required String title,
  required Function onTap,
  Color borderColor = Colors.transparent,
  Color buttonColor = AppColor.secondaryColor,
  Color textColor = Colors.white,
  Color iconColor = Colors.white,
  double fontSize = 20,
  double radius = 10,
  double iconPadding = 10,
  double height = 58,
  double width = double.infinity,
  IconData? iconData,
  double shadowColorOpacity = 0.25,
  Color shadowColor = Colors.black,
  FontWeight fontWeight = FontWeight.w500,
  final ShapeDecoration? decoration,
  final EdgeInsetsGeometry? padding,
}) {
  var context = Get.context!;
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      alignment: Alignment.center,
      height: height == 0 ? context.getSize.height * 0.058 : height,
      width: width == 0 ? context.getSize.width : width,
      padding: padding,
      decoration: decoration ??
          BoxDecoration(
            color: buttonColor,
            boxShadow: [boxShadow()],
            borderRadius: BorderRadius.circular(radius),
            // border: Border.all(color: borderColor),
          ),
      child: Center(
        child: iconData != null
            ? Row(
                // mainAxisSize: MainAxisSize.,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gap(context.getSize.width / 5),
                  Icon(
                    iconData,
                    color: iconColor,
                    size: 20,
                  ),
                  const Gap(5),
                  CustomText(
                      title: title,
                      fontSize: fontSize,
                      color: textColor,
                      fontWeight: fontWeight),])
            : CustomText(
                title: title,
                fontSize: fontSize,
                color: textColor,
                fontWeight: fontWeight),
      ),
    ),
  );
}
