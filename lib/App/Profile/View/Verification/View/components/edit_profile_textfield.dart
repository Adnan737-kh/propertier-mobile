// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
                  ? appText(
                      title: label!,
                      context: context,
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
                  //     customButton: Icon(
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

Widget customPhoneNumberTextField(
    {FocusNode? focusNode,
    required String hintText,
    void Function()? isEditablefun,
    String? label,
    required TextEditingController controller,
    TextInputType textInputType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    bool obsecureText = false,
    double height = 36,
    double fontSize = 14,
    double horizontalPadding = 12,
    double verticalPadding = 8,
    VoidCallback? onTap,
    Widget? prefix,
    Widget? suffix,
    bool readOnly = false,
    String? Function(String?)? validator,
    Color borderColor = AppColor.backgroundColor,
    double opacity = 0.10,
    int maxLines = 1,
    String initialCOde = "+92",
    Function(Country)? onChangeCountry,
    String? initialCountryCode,
    FontWeight fontWeight = FontWeight.w400,
    Function(PhoneNumber)? onChanged,
    bool isEditable = false}) {
  var context = Get.context!;
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
                ? appText(
                    title: label,
                    context: context,
                    fontSize: 16,
                    color: const Color(0xFF6D6E6F),
                    fontWeight: FontWeight.bold)
                : const Gap(0),
            Row(
              children: [
                GestureDetector(
                    onTap: isEditablefun,
                    child: Icon(
                      Icons.edit,
                      size: context.getSize.width * 0.050,
                    )),
                Gap(context.getSize.width * 0.01),

                // DropdownButtonHideUnderline(
                //   child: DropdownButton2(
                //     customButton: Icon(
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
                //         borderRadius: BorderRadius.circular(4),
                //         // color: Colors.redAccent,
                //       ),
                //       offset: const Offset(0, 8),
                //     ),
                //     menuItemStyleData: MenuItemStyleData(
                //       customHeights: [
                //         ...List<double>.filled(MenuItems.firstItems.length, 48),
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
        IntlPhoneField(
          initialValue: initialCOde,
          // disableLengthCheck: true,
          enabled: isEditable,
          autofocus: true,
          controller: controller,
          focusNode: focusNode,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(top: context.getSize.height * 0.019),
            // labelText: 'Phone Number',
            hintText: 'Phone Number',

            border: const UnderlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          languageCode: "en",
          onChanged: (phone) {
            print(phone.countryCode);
          },
          onCountryChanged: onChangeCountry,
        )
      ],
    ),
  );
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
