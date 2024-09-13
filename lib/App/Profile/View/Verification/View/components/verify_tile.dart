import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../../constant/colors.dart';
import '../../../../../../Utils/app_text.dart';

Widget VerifyTile(
    {required bool verify, required String title, Function()? onTap}) {
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
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                !verify
                    ? Image.asset(
                        "assets/icons/AlertIcon.png",
                        width: 27,
                      )
                    : appText(
                        title: '✓ ',
                        context: context,
                        fontSize: 32,
                        color: AppColor.buttonColor),
                const Gap(8),
                appText(title: title, context: context, colorOpecity: 0.60)
              ],
            ),
            const Icon(Icons.keyboard_arrow_right_rounded)
          ],
        ),
      ),
    ),
  );
}
