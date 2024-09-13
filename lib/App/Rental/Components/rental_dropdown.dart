import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../../Utils/app_text.dart';
import '../../../Utils/box_shadow.dart';
import '../../../Utils/textStyle.dart';

Widget rentalDropdown(
    {required BuildContext context,
    String? Function(String?)? validator,
    required String title,
    required List<DropdownMenuItem<String>>? items}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.white,
        boxShadow: [boxShadow()]),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appText(title: title, context: context, colorOpecity: 0.6),
          DropdownButtonFormField(
              style: textStyle(context: context),
              decoration: const InputDecoration(border: InputBorder.none),
              items: items,
              onChanged: (value) {},
              validator: validator),
        ],
      ),
    ),
  );
}
