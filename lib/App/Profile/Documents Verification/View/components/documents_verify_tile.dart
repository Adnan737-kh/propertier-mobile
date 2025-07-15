import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../RoutesAndBindings/app_routes.dart';
import '../../../../../constant/colors.dart';
import '../../../../../Utils/app_text.dart';

Widget documentsVerifyTile({
  required String title,
  required bool isVerify,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isVerify
            ? const CustomText(
                title: '✓ ', fontSize: 60, color: AppColor.buttonColor)
            : const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 80,
              ),
        const Gap(8),
        isVerify
            ? const CustomText(
                title: 'Verified', fontSize: 20, color: AppColor.blackColor)
            : const CustomText(
                title: 'Error', fontSize: 20, color: AppColor.blackColor),
        const Gap(8),
        CustomText(title: title, colorOpecity: 0.60),
        const Gap(8),
        isVerify
            ? const Gap(0)
            : GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.documentsTypesView);
                },
                child: const CustomText(
                    title: "Verify your Text Documents?",
                    color: AppColor.facebookColor,
                    colorOpecity: 0.90),
              )
      ],
    ),
  );
}
