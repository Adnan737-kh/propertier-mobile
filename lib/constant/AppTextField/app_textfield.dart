import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/extensions/localization_extension.dart';
import '../colors.dart';

Widget customTextField({
  FocusNode? focusNode,
  required String hintText,
  String? label,
  required TextEditingController controller,
  TextInputType textInputType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  Function(String)? onChanged,
  double height = 36,
  double width = double.infinity,
  double fontSize = 14,
  double horizontalPadding = 12,
  double verticalPadding = 8,
  double opacity = 0.10,
  VoidCallback? onTap,
  Widget? prefix,
  Widget? suffix,
  Widget? suffixIcon,
  InputBorder? border,
  String? Function(String?)? validator,
  Function(String)? onFieldSubmitted,
  Color borderColor = AppColor.backgroundColor,
  int maxLines = 1,
  FontWeight fontWeight = FontWeight.w400,
  Color? fillColor,
  bool obSecureText = false,
  bool? isFilled = false,
  bool readOnly = false,
}) {
  var context = Get.context!;
  return Stack(
    children: [
      Container(
        width: width,
        decoration: (isFilled ?? false)
            ? BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                  color: borderColor.withOpacity(opacity),
                ),
              )
            : null, // ← No border at all if not filled
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label != null
                ? CustomText(
                    title: label,
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
              focusNode: focusNode,
              controller: controller,
              validator: validator,
              onFieldSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                prefix: prefix,
                suffix: suffix,
                suffixIcon: suffixIcon,
                fillColor: fillColor,
                filled: isFilled,
                hintText: hintText,
                hintStyle: textStyle(
                    context: context, withOpacity: 0.30, fontSize: 14),
                contentPadding: (isFilled ?? false)
                    ? EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.020,
                        horizontal: 8,
                      )
                    : const EdgeInsets.fromLTRB(0, 0, 0, 0),
                enabledBorder: !(isFilled ?? false)
                    ? const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )
                    : InputBorder.none,
                focusedBorder: !(isFilled ?? false)
                    ? const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      )
                    : InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget customPhoneNumberTextField({
  FocusNode? focusNode,
  required String hintText,
  String? label,
  required TextEditingController controller,
  TextInputType textInputType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  bool obSecureText = false,
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
        label != null
            ? CustomText(
                title: label,
                fontSize: 14,
                color: const Color.fromARGB(196, 141, 142, 143),
                fontWeight: FontWeight.bold)
            : const Gap(0),
        IntlPhoneField(
          // validator: ,

          searchText: context.local.search_country_region,
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
            hintText: context.local.phone_number,
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
