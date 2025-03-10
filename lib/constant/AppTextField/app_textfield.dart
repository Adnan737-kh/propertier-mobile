import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/textStyle.dart';
// import 'package:propertierapp/extensions/size_extension.dart';

import '../colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../AppColors/colors.dart';

Widget customTextField({
  FocusNode? focusNode,
  required String hintText,
  String? label,
  required TextEditingController controller,
  TextInputType textInputType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  bool obSecureText = false,
  double height = 36,
  Function(String)? onChanged,
  double width = double.infinity,
  double fontSize = 14,
  double horizontalPadding = 12,
  double verticalPadding = 8,
  VoidCallback? onTap,
  Widget? prefix,
  Widget? suffix,
  Widget? suffixIcon,
  InputBorder? border,
  bool readOnly = false,
  String? Function(String?)? validator,
  Color borderColor = AppColor.backgroundColor,
  double opacity = 0.10,
  int maxLines = 1,
  FontWeight fontWeight = FontWeight.w400,
}) {
  var context = Get.context!;
  return Stack(
    children: [
      Container(
        width: width,
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
            label != null
                ? appText(
                    title: label,
                    context: context,
                    fontSize: 14,
                    color: const Color.fromARGB(196, 141, 142, 143),
                    fontWeight: FontWeight.bold)
                : const Gap(0),
            TextFormField(
              onChanged: onChanged,
              onTap: onTap,
              readOnly: readOnly,
              maxLines: maxLines,
              obscureText: obSecureText,
              keyboardType: textInputType,
              textInputAction: textInputAction,
              // style:
              focusNode: focusNode,
              controller: controller,
              validator: validator,

              decoration: InputDecoration(
                prefix: prefix,
                suffix: suffix,
                suffixIcon: suffixIcon,
                // prefixIcon: prefix,
                hintText: hintText,
                hintStyle: textStyle(
                    context: context, withOpacity: 0.30, fontSize: 14),
                contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                border: const UnderlineInputBorder(),

                focusedBorder: const UnderlineInputBorder(),
                enabled: true,
                enabledBorder: const UnderlineInputBorder(),
              ),
            ),
          ],
        ),
      ),

      // suffixIcon!=null?Positioned(child: suffixIcon):const Gap(0)
    ],
  );
}

Widget customPhoneNumberTextField({
  FocusNode? focusNode,
  required String hintText,
  String? labal,
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
  FontWeight fontWeight = FontWeight.w400,
}) {
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
        labal != null
            ? appText(
                title: labal,
                context: context,
                fontSize: 14,
                color: const Color.fromARGB(196, 141, 142, 143),
                fontWeight: FontWeight.bold)
            : const Gap(0),
        IntlPhoneField(
          // validator: ,
          showCursor: true,
          readOnly: false,
          controller: controller,
          focusNode: focusNode,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          disableLengthCheck: true,
          initialValue: '+92',
          showDropdownIcon: false,

          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 15),
            // labelText: 'Phone Number',
            hintText: 'Phone Number',
            hintStyle:
                textStyle(context: context, withOpacity: 0.30, fontSize: 14),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.blackColor,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(),
            enabled: true,
            enabledBorder: const UnderlineInputBorder(),
          ),
          languageCode: "en",

          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (phone) {
            // print(phone.completeNumber);
          },

          onCountryChanged: (country) {},
        )
      ],
    ),
  );
}
