import 'package:flutter/material.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

class YourSelfTextField extends StatelessWidget {
  final TextEditingController controller;
  YourSelfTextField({super.key, required this.controller});
  var border = InputBorder.none;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: AppColor.blackColor.withOpacity(0.75),
        width: 1,
      ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: TextFormField(
              controller: controller,
              maxLines: null,
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
                  hintText: context.local.typeHereByYourSelf,
                  hintStyle: textStyle(
                      context: context,
                      fontSize: 10,
                      color: AppColor.blackColor.withOpacity(0.6),
                      fontWeight: FontWeight.w400)),
            ),
          ),
          const Icon(
            Icons.check,
            color: AppColor.buttonColor,
          )
        ],
      ),
    );
  }
}
