import 'package:flutter/material.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/app_text.dart';
import '../../../../constant/colors.dart';

Widget customContainer(
    {double radius = 10,
    bool isSelect = false,
    required String title,
    Function()? onTap,
    required BuildContext context}) {
  return InkWell(
    borderRadius: BorderRadius.circular(radius),
    onTap: onTap,
    child: Container(
      height: context.getSize.height * 0.040,
      width: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
              color: isSelect
                  ? AppColor.buttonColor
                  : AppColor.darkGreyColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(radius)),
      child: Center(
        child: appText(title: title, fontSize: 12, context: context),
      ),
    ),
  );
}
