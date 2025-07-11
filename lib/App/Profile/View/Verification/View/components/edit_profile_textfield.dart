// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
// import 'package:intl_phone_field2/phone_number.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../../../constant/colors.dart';
import '../../../../../../Utils/app_text.dart';
// import 'package:propertierapp/extensions/size_extension.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../AppColors/colors.dart';

// ignore: must_be_immutable
class EditProfileTextField extends StatelessWidget {
  EditProfileTextField(
      {super.key,
      this.focusNode,
      required this.hintText,
      this.label,
      required this.controller,
      this.onTap,
      this.prefix,
      this.suffix,
      this.isEditable,
      this.readOnly = false,
      this.validator,
      this.textInputType,
      this.onChangeCountry,
      this.isEditableFunction});
  final void Function()? isEditableFunction;
  final FocusNode? focusNode;
  final String hintText;
  final Function(Country)? onChangeCountry;
  final String? label;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextInputAction textInputAction = TextInputAction.next;
  final bool obsecureText = false;
  final double height = 36;
  final double fontSize = 14;
  final double horizontalPadding = 12;
  final double verticalPadding = 8;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;

  bool readOnly;
  final String? Function(String?)? validator;
  final Color borderColor = AppColor.backgroundColor;
  final double opacity = 0.10;
  final int maxLines = 1;
  bool? isEditable = false;

  final FontWeight fontWeight = FontWeight.w400;

  @override
  Widget build(BuildContext context) {
    // var context = Get.context!;?
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(
            color: borderColor.withOpacity(opacity),
            // width: 1,
          )),
      // height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label != null
                  ? CustomText(
                      title: label!,
                      fontSize: 16,
                      color: const Color(0xFF6D6E6F),
                      fontWeight: FontWeight.bold)
                  : const Gap(0),
              Row(
                children: [
                  GestureDetector(
                      onTap: isEditableFunction,
                      child: Icon(
                        Icons.edit,
                        size: context.getSize.width * 0.050,
                      )),
                  Gap(context.getSize.width * 0.01),

                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton2(
                  //     CustomButton: Icon(
                  //       Icons.more_horiz,
                  //       size: context.getSize.width * 0.050,
                  //       // color: Colors.red,
                  //     ),
                  //     items: [
                  //       ...MenuItems.firstItems.map(
                  //         (item) => DropdownMenuItem<MenuItem>(
                  //           value: item,
                  //           child: MenuItems.buildItem(item),
                  //         ),
                  //       ),
                  //       const DropdownMenuItem<Divider>(
                  //           enabled: false, child: Divider()),
                  //       ...MenuItems.secondItems.map(
                  //         (item) => DropdownMenuItem<MenuItem>(
                  //           value: item,
                  //           child: MenuItems.buildItem(item),
                  //         ),
                  //       ),
                  //     ],
                  //     onChanged: (value) {
                  //       MenuItems.onChanged(context, value! as MenuItem);
                  //     },
                  //     dropdownStyleData: DropdownStyleData(
                  //       width: 100,
                  //       padding: const EdgeInsets.symmetric(vertical: 6),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(5),
                  //         // color: Colors.redAccent,
                  //       ),
                  //       offset: const Offset(0, 8),
                  //     ),
                  //     menuItemStyleData: MenuItemStyleData(
                  //       customHeights: [
                  //         ...List<double>.filled(
                  //             MenuItems.firstItems.length, 48),
                  //         8,
                  //         ...List<double>.filled(
                  //             MenuItems.secondItems.length, 48),
                  //       ],
                  //       padding: const EdgeInsets.only(left: 16, right: 16),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
          TextFormField(
            autofocus: true,
            onTap: onTap,
            readOnly: readOnly,
            enabled: isEditable,
            maxLines: maxLines,
            obscureText: obsecureText,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            focusNode: focusNode,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              prefix: prefix,
              suffix: suffix,
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF929395)),
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(),
              enabled: true,
              enabledBorder: const UnderlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }
}


class CustomPhoneNumberTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final String hintText;
  final VoidCallback? isEditField;
  final String? label;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obSecureText;
  final double height;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Color borderColor;
  final double opacity;
  final int maxLines;
  final String initialCode;
  final Function(Country)? onChangeCountry;
  final String? initialCountryCode;
  final FontWeight fontWeight;
  final Function(PhoneNumber)? onChanged;
  final bool isEditable;
  final bool isShowEditIcon;
  final void Function(String)? onFieldSubmitted;

  const CustomPhoneNumberTextField({
    super.key,
    this.focusNode,
    required this.hintText,
    this.isEditField,
    this.label,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obSecureText = false,
    this.height = 36,
    this.fontSize = 14,
    this.horizontalPadding = 12,
    this.verticalPadding = 8,
    this.onTap,
    this.prefix,
    this.suffix,
    this.readOnly = false,
    this.validator,
    this.borderColor = AppColor.backgroundColor,
    this.opacity = 0.10,
    this.maxLines = 1,
    this.initialCode = "+92",
    this.onChangeCountry,
    this.initialCountryCode,
    this.fontWeight = FontWeight.w400,
    this.onChanged,
    this.isEditable = false,
    this.isShowEditIcon = true,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(
          color: borderColor.withOpacity(opacity),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: label!,
                  fontSize: 16,
                  color: const Color(0xFF6D6E6F),
                  fontWeight: FontWeight.bold,
                ),
                if (isShowEditIcon)
                  Row(
                    children: [
                      GestureDetector(
                        onTap: isEditField,
                        child: Icon(
                          Icons.edit,
                          size: context.getSize.width * 0.050,
                        ),
                      ),
                      Gap(context.getSize.width * 0.01),
                    ],
                  ),
              ],
            ),
          IntlPhoneField(
            onSubmitted: onFieldSubmitted,
            initialValue: initialCode,
            searchText: 'Search Country/Region',
            autofocus: true,
            controller: controller,
            focusNode: focusNode,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.only(top: context.getSize.height * 0.019),
              hintText: hintText,
              border: const UnderlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            languageCode: "en",
            onChanged: onChanged,
            onCountryChanged: onChangeCountry,
          ),
        ],
      ),
    );
  }
}


class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [settings];
  static const List<MenuItem> secondItems = [logout];

  static const settings = MenuItem(text: 'Only me', icon: Icons.settings);
  static const logout = MenuItem(text: 'Public  ', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        // Icon(item.icon, color: Colors.white, size: 22),
        // const SizedBox(
        //   width: 10,
        // ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      // case MenuItems.home:
      //   //Do something
      //   break;
      case MenuItems.settings:
        //Do something
        break;
      // case MenuItems.share:
      //   //Do something
      //   break;
      case MenuItems.logout:
        //Do something
        break;
    }
  }
}
