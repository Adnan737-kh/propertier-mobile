import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../../constant/constant.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/divider.dart';
import '../../../../Utils/height_width_box.dart';

Widget paymentMethod({required BuildContext context, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Row(
          children: [
            CustomText(
                title: context.local.payment_Method,
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
                  Constant.bankAlfalahIcon,
                  width: 10,
                  height: 13.17,
                ),
                const Gap(8),
                const CustomText(
                    title: "Bank alflah",
                    fontSize: 12,
                    fontWeight: FontWeight.normal)
              ],
            ),
            const Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                ),
                Gap(8),
              ],
            ),
          ],
        ),
        getHeight(context, 0.009),
        divider(context: context),
        getHeight(context, 0.009),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  Constant.bitCoinIcon,
                  width: 10,
                  height: 13.17,
                ),
                const Gap(8),
                const CustomText(
                    title: "BitCoin",
                    fontSize: 12,
                    fontWeight: FontWeight.normal)
              ],
            ),
            const Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                ),
                Gap(8),
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
