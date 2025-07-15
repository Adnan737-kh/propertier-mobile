import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../../../RoutesAndBindings/app_routes.dart';
import '../../../../../constant/colors.dart';
import '../../../../../Utils/app_text.dart';

Widget emailVerifyTile({
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
            ? const CustomText(
                title: '✓ ', fontSize: 60, color: AppColor.buttonColor)
            : const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 80,
              ),
        const Gap(8),
        isVerify
            ? CustomText(
                title: context.local.verified,
                fontSize: 20,
                color: AppColor.blackColor)
            : CustomText(
                title: context.local.error,
                fontSize: 20,
                color: AppColor.blackColor),
        const Gap(8),
        CustomText(title: title, colorOpecity: 0.60),
        const Gap(8),
        !isVerify
            ? GestureDetector(
                onTap: () {
                  Get.offNamed(AppRoutes.emailEnterView);
                },
                child: CustomText(
                    title: context.local.verify_your_number,
                    color: AppColor.facebookColor,
                    colorOpecity: 0.90),
              )
            : const Gap(0)
      ],
    ),
  );
}
