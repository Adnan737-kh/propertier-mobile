import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/app_text.dart';
import '../../../../Utils/textStyle.dart';
import '../../../../constant/colors.dart';

Widget addPropertyDropdown<T>(
    {required BuildContext context,
    bool? enable,
    String? Function(String?)? validator,
    Function(String?)? onChange,
    required String title,
    required List<DropdownMenuItem<String>>? items}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: AppColor.white,
      // boxShadow: [boxShadow()]
    ),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Gap(5),
              appText(title: title, context: context, colorOpecity: 0.6),
            ],
          ),
          DropdownButtonFormField(
              menuMaxHeight: context.getSize.height * 0.4,
              style: textStyle(context: context, fontSize: 12),
              decoration: InputDecoration(
                  enabled: enable ?? true, border: InputBorder.none),
              items: items,
              onChanged: enable != false ? onChange : null,
              validator: enable != null ? null : validator),
        ],
      ),
    ),
  );
}
