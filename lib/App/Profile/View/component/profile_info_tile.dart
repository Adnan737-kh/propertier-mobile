import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:propertier/App/Profile/Model/profile_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget profileInformationTile(BuildContext context, UserProfile user) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            colorOpecity: 0.6,
            title: context.local.phone_number,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textBox(
            context,
            user.phoneNumber!,
          )
          // textBox(context, user.phoneNumberCountryCode! + user.phoneNumber!,)
        ],
      ),
      getHeight(context, 0.004),
      divider(context: context),
      getHeight(context, 0.004),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            colorOpecity: 0.6,
            title: context.local.email,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textBox(context, user.email != null ? user.email.toString() : "")
        ],
      ),
      getHeight(context, 0.004),
      divider(context: context),
      getHeight(context, 0.004),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            colorOpecity: 0.6,
            title: context.local.address,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textBox(context, user.address.toString()),
        ],
      ),
      getHeight(context, 0.004),
      divider(context: context),
      getHeight(context, 0.004),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            colorOpecity: 0.6,
            title: context.local.since,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textBox(
              context,
              user.createdAt != null
                  ? DateFormat.yMMMMd()
                      .format(DateTime.parse(user.createdAt!.toString()))
                  : ""),
        ],
      ),
    ],
  );
}

SizedBox textBox(BuildContext context, String text) {
  return SizedBox(
      width: context.getSize.width * 0.5,
      child: CustomText(
        textAlign: TextAlign.right,
        colorOpecity: 0.5,
        title: text,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ));
}
