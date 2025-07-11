import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../constant/colors.dart';
import '../../../../Utils/app_text.dart';

Widget customJoinAsButton(
    {required String title,
    required Function onTap,
    Color borderColor = Colors.transparent,
    Color buttonColor = AppColor.secondaryColor,
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
    double fontSize = 20,
    double radius = 10,
    double height = 58,
    IconData? iconData,
    FontWeight fontWeight = FontWeight.w500}) {
  return SizedBox(
    child: GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height,
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
    ),
  );
}
