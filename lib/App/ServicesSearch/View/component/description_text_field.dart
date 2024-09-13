import 'package:flutter/material.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

class DescriptionTextField extends StatelessWidget {
  final TextEditingController descriptionController;
  DescriptionTextField({super.key, required this.descriptionController});
  var border = InputBorder.none;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 8,
      controller: descriptionController,
      style: textStyle(
          context: context,
          fontSize: 10,
          color: AppColor.blackColor.withOpacity(0.6),
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          focusedErrorBorder: border,
          errorBorder: border,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          hintText: context.local.completeDescriptionABoutYourWork,
          hintStyle: textStyle(
              context: context,
              fontSize: 10,
              color: AppColor.blackColor.withOpacity(0.6),
              fontWeight: FontWeight.w400)),
    );
  }
}
