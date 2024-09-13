import 'package:flutter/material.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

recommandedTile({
  required BuildContext context,
  required String imageUrl,
  required String title,
  required String subtitle,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: context.getSize.height * 0.012),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 60,
              margin: const EdgeInsets.only(bottom: 13),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)),
            ),
            getWidth(context, 0.015),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                scrollableText(
                    textAlign: TextAlign.start,
                    width: 0.55,
                    context: context,
                    textStyle: textStyle(
                        context: context,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blueColor),
                    title: title),
                getHeight(context, 0.009),
                scrollableText(
                    textAlign: TextAlign.start,
                    width: 0.55,
                    context: context,
                    textStyle: textStyle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffFFC437)),
                    title: subtitle),
              ],
            ),
          ],
        ),
        divider(context: context, color: const Color(0xffCFCFCF)),
      ],
    ),
  );
}
