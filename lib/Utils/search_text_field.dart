import 'package:flutter/material.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/font_size_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class SearchTextField extends StatelessWidget {
  final Widget suFixIcon;
  final double height;
  final double horzontalPadding;
  final String hintText;
  final Function(String)? onChange;

  SearchTextField(
      {super.key,
      this.horzontalPadding = 0.090,
      required this.searchController,
      this.onChange,
      this.hintText = '',
      required this.suFixIcon,
      this.height = 0.04});
  TextEditingController searchController;
  var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.transparent,
        // Color.fromRGBO(19, 26, 34, 0.10),
        width: 5,
      ));
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.getSize.width * horzontalPadding,
      ),
      decoration: BoxDecoration(
          boxShadow: [boxShadow()],
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent),
      height: context.getSize.height * height,
      child: TextFormField(
        onChanged: onChange,
        style: TextStyle(
          fontSize: context.fontSize(10),
          color: AppColor.blackColor,
          fontFamily: 'Rozha One',
        ),
        controller: searchController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: context.fontSize(10),
            color: AppColor.blackColor,
            fontFamily: 'Rozha One',
          ),
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Padding(
            padding: EdgeInsets.all(context.getSize.width * 0.02),
            child: Image.asset(
              Constant.search,
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
