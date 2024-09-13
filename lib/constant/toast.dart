import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';

toast({
  required String title,
  required BuildContext context,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: appText(title: title, context: context, color: AppColor.white)));
}
