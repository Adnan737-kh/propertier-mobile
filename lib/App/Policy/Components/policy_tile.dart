import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../Utils/app_text.dart';

Widget policyTile({
  required String title,
  required String subTitle,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Gap(15),
      title != ""
          ? appText(
              title: title,
              context: context,
              fontSize: 14,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600,
              colorOpecity: 01)
          : const Gap(0),
      const Gap(8),
      appText(
          title: subTitle,
          context: context,
          fontSize: 14,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w400,
          colorOpecity: 0.4),
    ],
  );
}
