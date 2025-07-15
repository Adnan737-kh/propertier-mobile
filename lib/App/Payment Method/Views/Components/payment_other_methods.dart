import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../../constant/constant.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/divider.dart';
import '../../../../Utils/height_width_box.dart';

Widget otherPaymentMethod(
    {required BuildContext context, void Function()? onTap}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            CustomText(
                title: context.local.other_saved_payment_method,
                colorOpecity: 0.7,
                fontWeight: FontWeight.bold)
          ],
        ),
      ),
      getHeight(context, 0.009),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                Constant.easyPisaIcon,
                width: 10,
                height: 13.17,
              ),
              const Gap(8),
              const CustomText(
                  title: "031******123",
                  fontSize: 12,
                  fontWeight: FontWeight.normal)
            ],
          ),
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: const ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(width: 1, color: Color(0xB2131A22)),
                  ),
                ),
              ),
              const Gap(8),
            ],
          ),
        ],
      ),
      getHeight(context, 0.009),
      divider(context: context)
    ],
  );
}
