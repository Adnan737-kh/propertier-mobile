import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';

toast({
  required String title,
  required BuildContext context,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          CustomText(title: title, color: AppColor.white)));
}

class CustomToast {
  static void show({
    required String title,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          title: title,
          color: AppColor.white,
        ),
      ),
    );
  }
}
