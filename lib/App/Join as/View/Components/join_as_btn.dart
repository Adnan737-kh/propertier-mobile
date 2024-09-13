import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
    IconData? icondata,
    FontWeight fontWeight = FontWeight.w500}) {
  var context = Get.context!;
  return SizedBox(
    child: GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        // padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
        height: height,
        // width: double.infinity,
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
              icondata != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        icondata,
                        color: iconColor,
                        size: 28,
                      ),
                    )
                  : const Gap(0),
              Center(
                child: appText(
                    fontFamily: "rozha one",
                    title: title,
                    fontSize: fontSize,
                    context: context,
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
