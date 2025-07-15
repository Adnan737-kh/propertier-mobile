import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../../constant/constant.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/divider.dart';
import '../../../../Utils/height_width_box.dart';

Widget recommendedMethod(
    {required BuildContext context, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Row(
          children: [
            CustomText(
                title: context.local.recommended_method,
                colorOpecity: 0.7,
                fontWeight: FontWeight.bold)
          ],
        ),
        getHeight(context, 0.009),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  Constant.creditDebitIcon,
                  width: 13,
                  height: 10.17,
                ),
                const Gap(8),
                CustomText(
                    title: context.local.credit_debit_card,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)
              ],
            ),
            Row(
              children: [
                Image.asset(
                  Constant.masterCardIcon,
                  width: 13,
                  height: 10.17,
                ),
                const Gap(8),
                Image.asset(
                  Constant.visaCardIcon,
                  width: 13,
                  height: 10.17,
                ),
                const Gap(8),
                Image.asset(
                  Constant.unioCardIcon,
                  width: 13,
                  height: 10.17,
                ),
                const Gap(8),
              ],
            ),
          ],
        ),
        getHeight(context, 0.009),
        divider(context: context)
      ],
    ),
  );
}
