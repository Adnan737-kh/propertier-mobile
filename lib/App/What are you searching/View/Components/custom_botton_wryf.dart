import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/box_shadow.dart';

import '../../../../constant/colors.dart';

Widget customButton(
    {required String title,
    required Function onTap,
    Color borderColor = Colors.transparent,
    Color buttonColor = AppColor.buttonColor,
    Color textColor = Colors.black,
    Color iconColor = Colors.white,
    double fontSize = 14,
    double radius = 10,
    double height = 48,
    double width = double.infinity,
    IconData? icondata,
    double shadowColorOpacity = 0.25,
    Color shadowColor = Colors.black,
    FontWeight fontWeight = FontWeight.w600}) {
  var context = Get.context!;
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [boxShadow()]),
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
              child: appText(
                  title: title,
                  fontSize: fontSize,
                  context: context,
                  color: textColor,
                  fontWeight: fontWeight),
            ),
          ],
        ),
      ),
    ),
  );
}
