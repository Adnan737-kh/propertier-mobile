import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/font_size_extension.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class LanguageSearchTextField extends StatelessWidget {
  final Widget suFixIcon;
  final double height;
  final Function(String) voidCallBack;
  const LanguageSearchTextField(
      {super.key,
      required this.voidCallBack,
      required this.searchController,
      required this.suFixIcon,
      this.height = 0.1});
  final TextEditingController searchController;
  final border = InputBorder.none;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: AppColor.blackColor,
        width: 1,
      ))),
      child: TextFormField(
        style: TextStyle(
          fontSize: context.fontSize(10),
          color: AppColor.blackColor,
          fontFamily: 'Rozha One',
        ),
        controller: searchController,
        onChanged: (val) {
          voidCallBack(val);
        },
        decoration: InputDecoration(
          hintText: context.local.search_language,
          hintStyle: TextStyle(
            fontSize: context.fontSize(14),
            color: AppColor.blackColor.withOpacity(0.2),
            fontFamily: 'Rozha One',
          ),
          contentPadding: EdgeInsets.all(context.getSize.width * 0.04),
          prefixIcon: Padding(
            padding: EdgeInsets.all(context.getSize.width * 0.04),
            child: Image.asset(
              Constant.search,
              width: 13,
              height: 12,
            ),
          ),
          suffixIcon: Padding(
              padding: EdgeInsets.all(context.getSize.width * 0.02),
              child: suFixIcon),
          border: border,
          enabledBorder: border,
          errorBorder: border,
          focusedBorder: border,
          fillColor: AppColor.white,
          filled: true,
        ),
      ),
    );
  }
}
