import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget aboutTile(BuildContext context, String about) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        title: context.local.about,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      getHeight(context, 0.005),
      Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 10,
          right: 39,
        ),
        width: context.getSize.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            // boxShadow(),
          ],
        ),
        child: CustomText(
            fontSize: 12,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w400,
            title: about,
            color: AppColor.textColorGrey),
      ),
    ],
  );
}
