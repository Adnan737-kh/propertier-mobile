import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:info_popup/info_popup.dart';

import '../../../../constant/colors.dart';
import '../../../../Utils/app_text.dart';

Widget serviceTile({
  required String content,
  required String title,
  required String assetImageString,
  required BuildContext context,
}) {
  return Container(
    width: 139,
    height: 144,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: AppColor.blackColor.withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 0)
        ]),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InfoPopupWidget(
                contentTitle: content,
                child: const Icon(
                  Icons.info_outline_rounded,
                  // color: Colors.pink,
                ),
              ),
              const Gap(10)
            ],
          ),
          Image.asset(
            assetImageString,
            width: 74,
            height: 63,
          ),
          const Gap(15),
          CustomText(
              title: title,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              colorOpecity: 0.6)
        ],
      ),
    ),
  );
}
