import 'package:flutter/material.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class ServicesReviewTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  const ServicesReviewTextField(
      {super.key, required this.textEditingController});
  final border = InputBorder.none;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.getSize.width * 0.020,
          vertical: context.getSize.height * 0.01),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [boxShadow()]),
      child: TextFormField(
        style: textStyle(
            context: context,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xffB8B8B8)),
        maxLines: 6,
        controller: textEditingController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            disabledBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
            hintText: context.local.lorem_ipsum,
            hintStyle: textStyle(
                context: context,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: const Color(0xffB8B8B8))),
      ),
    );
  }
}
