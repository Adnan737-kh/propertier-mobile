import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../Utils/box_shadow.dart';
import '../colors.dart';

Widget customTextButton(
    {required String title,
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
    IconData? icondata,
    double shadowColorOpacity = 0.25,
    Color shadowColor = Colors.black,
    FontWeight fontWeight = FontWeight.w500}) {
  var context = Get.context!;
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      alignment: Alignment.center,
      height: height == 0 ? context.getSize.height * 0.058 : height,
      width: width == 0 ? context.getSize.width : width,
      decoration: BoxDecoration(
        color: buttonColor,
        boxShadow: [boxShadow()],
        borderRadius: BorderRadius.circular(radius),
        // border: Border.all(color: borderColor),
      ),
      child: Center(
        child: icondata != null
            ? Row(
                // mainAxisSize: MainAxisSize.,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gap(context.getSize.width / 5),
                  Icon(
                    icondata,
                    color: iconColor,
                    size: 20,
                  ),
                  const Gap(5),
                  appText(
                      title: title,
                      fontSize: fontSize,
                      context: context,
                      color: textColor,
                      fontWeight: fontWeight),
                ],
              )
            : appText(
                title: title,
                fontSize: fontSize,
                context: context,
                color: textColor,
                fontWeight: fontWeight),
      ),
    ),
  );
}
