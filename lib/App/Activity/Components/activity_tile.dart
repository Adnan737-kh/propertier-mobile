import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../../constant/colors.dart';
import '../../../../../../Utils/app_text.dart';

Widget activityTile({required String title, Function()? onTap}) {
  var context = Get.context!;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0xFFFEFEFE),
          boxShadow: [
            BoxShadow(
                color: AppColor.blackColor.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(-1, 1),
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                appText(title: title, context: context, colorOpecity: 0.60)
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: AppColor.blackColor.withOpacity(0.6),
            )
          ],
        ),
      ),
    ),
  );
}
