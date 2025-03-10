import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:propertier/App/Profile/Model/profile_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget profileInformationTile(BuildContext context, UserProfile user) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appText(
            colorOpecity: 0.6,
            title: 'Phone Number',
            context: context,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textBox(context, user.phoneNumber!,)
          // textBox(context, user.phoneNumberCountryCode! + user.phoneNumber!,)
        ],
      ),
      getHeight(context, 0.004),
      divider(context: context),
      getHeight(context, 0.004),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appText(
            colorOpecity: 0.6,
            title: 'Email',
            context: context,
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
          appText(
            colorOpecity: 0.6,
            title: 'Address',
            context: context,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textBox(context, user.address.toString() ?? ""),
        ],
      ),
      getHeight(context, 0.004),
      divider(context: context),
      getHeight(context, 0.004),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appText(
            colorOpecity: 0.6,
            title: 'Since',
            context: context,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textBox(
              context,
              user.createdAt != null
                  ? DateFormat.yMMMMd()
                      .format(DateTime.parse(user.createdAt!.toString())) : ""),
        ],
      ),
    ],
  );
}

SizedBox textBox(BuildContext context, String text) {
  return SizedBox(
      width: context.getSize.width * 0.5,
      child: appText(
        textAlign: TextAlign.right,
        colorOpecity: 0.5,
        title: text,
        context: context,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ));
}
