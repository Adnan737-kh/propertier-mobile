import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget incomExpenseTile(BuildContext context,
    {bool isIncome = true, required String ammount}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      height: context.getSize.height * 0.12,
      width: context.getSize.width * 0.43,
      decoration: BoxDecoration(
          color: isIncome == true
              ? const Color(0xff2A2626).withOpacity(0.7)
              : AppColor.lightBlueColor.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Positioned(
              top: -12,
              left: -12,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.white, width: 2)),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  isIncome == true ? Constant.down : Constant.up,
                  width: 12,
                  height: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        title: isIncome == true
                            ? context.local.income
                            : context.local.expense,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColor.white.withOpacity(0.7)),
                    CustomText(
                        title: ammount,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white.withOpacity(1))
                  ],
                )
              ],
            ),
          ),
          Positioned(
              right: context.getSize.width * -0.05,
              bottom: context.getSize.height * -0.01,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                height: context.getSize.height * 0.09,
                width: context.getSize.width * 0.180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isIncome == true
                      ? const Color(0xff8B8787)
                      : const Color(0xff79CDFF),
                ),
                child: Icon(
                  isIncome == true ? Icons.arrow_downward : Icons.arrow_upward,
                  size: context.getSize.width * 0.084,
                  color: AppColor.white.withOpacity(0.7),
                ),
              ))
        ],
      ),
    ),
  );
}
