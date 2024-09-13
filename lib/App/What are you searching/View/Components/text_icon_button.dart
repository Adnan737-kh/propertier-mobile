import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../constant/colors.dart';

Widget textIconButton(
    {required String title,
    required Function onTap,
    Color borderColor = Colors.transparent,
    Color buttonColor = AppColor.secondaryColor,
    Color textColor = AppColor.blackColor,
    Color iconColor = AppColor.blackColor,
    double fontSize = 14,
    double radius = 10,
    double height = 58,
    double width = double.infinity,
    IconData? icondata,
    double shadowColorOpacity = 0.25,
    Color shadowColor = Colors.black,
    FontWeight fontWeight = FontWeight.w400}) {
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
        color: AppColor.white,
        border:
            Border.all(width: 0.5, color: AppColor.blackColor.withOpacity(0.4)),

        borderRadius: BorderRadius.circular(radius),
        // border: Border.all(color: borderColor),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(5),
            Center(
              child: appText(
                  title: title,
                  fontSize: fontSize,
                  context: context,
                  color: textColor,
                  fontWeight: FontWeight.normal),
            ),
            const Gap(5),
            icondata != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      icondata,
                      color: iconColor,
                      size: 15,
                    ),
                  )
                : const Gap(0),
          ],
        ),
      ),
    ),
  );
}
