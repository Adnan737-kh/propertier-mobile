import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget talkToSellerTile(BuildContext context,
    {required String price,
    String date = '',
    required VoidCallback talkToSellerCallBack}) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: context.getSize.width * 0.020,
        vertical: context.getSize.width * 0.020),
    decoration: BoxDecoration(
        border: border(color: Colors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(50)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: context.getSize.width * 0.5,
            child: RichText(
                text: TextSpan(
                    text: price,
                    style: textStyle(
                        context: context,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor.withOpacity(0.9)),
                    children: [
                  TextSpan(
                    style: textStyle(
                        context: context,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor.withOpacity(0.7)),
                    text: date,
                  )
                ]))),
        GestureDetector(
          onTap: talkToSellerCallBack,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.buttonColor,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.020,
                vertical: context.getSize.width * 0.020),
            child: CustomText(
                title: context.local.talk_to_seller,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                ),
          ),
        )
      ],
    ),
  );
}
