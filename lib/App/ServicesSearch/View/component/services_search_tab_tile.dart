import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget servicesSearchTabsTile(BuildContext context,
    {required String title,
    required VoidCallback onTap,
    Color? selectedColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: context.getSize.width * 0.008),
      padding: EdgeInsets.symmetric(
          horizontal: context.getSize.width * 0.01,
          vertical: context.getSize.height * 0.004),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selectedColor,
      ),
      child: appText(
          title: title,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          colorOpecity: 0.8,
          context: context),
    ),
  );
}
