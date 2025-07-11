import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../constant/colors.dart';
import '../../../Utils/app_text.dart';

Widget rentalCustomButton(
    {required String title,
    required Function onTap,
    Color borderColor = Colors.transparent,
    Color buttonColor = AppColor.secondaryColor,
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
    double fontSize = 20,
    double radius = 10,
    double height = 0,
    double width = 0,
    IconData? iconData,
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
          boxShadow: [
            BoxShadow(
                color: AppColor.blackColor.withOpacity(0.25),
                blurRadius: 4,
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: borderColor,
            width: 1,
          )),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconData != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      iconData,
                      color: iconColor,
                      size: 28,
                    ),
                  )
                : const Gap(0),
            Center(
              child: CustomText(
                  fontFamily: "rozha one",
                  title: title,
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}
