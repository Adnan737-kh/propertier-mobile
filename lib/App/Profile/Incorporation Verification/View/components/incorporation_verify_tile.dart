import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../RoutesAndBindings/app_routes.dart';
import '../../../../../constant/colors.dart';
import '../../../../../Utils/app_text.dart';

Widget incorporationVerifyTile({
  required String title,
  required bool isVerify,
}) {
  var context = Get.context!;
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isVerify
            ? appText(
                title: '✓ ',
                context: context,
                fontSize: 60,
                color: AppColor.buttonColor)
            : const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 80,
              ),
        const Gap(8),
        isVerify
            ? appText(
                title: 'Verified',
                context: context,
                fontSize: 20,
                color: AppColor.blackColor)
            : appText(
                title: 'Error',
                context: context,
                fontSize: 20,
                color: AppColor.blackColor),
        const Gap(8),
        appText(title: title, context: context, colorOpecity: 0.60),
        const Gap(8),
        isVerify
            ? const Gap(0)
            : GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.incorporationUploadView);
                },
                child: appText(
                    title: "Verify your Incorporation?",
                    color: AppColor.facebookColor,
                    context: context,
                    colorOpecity: 0.90),
              )
      ],
    ),
  );
}
