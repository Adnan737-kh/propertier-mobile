import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

class AddPostTextField extends StatelessWidget {
  const AddPostTextField(
      {super.key,
      required this.textEditingController,
      this.paddingHorizontal = 0.020,
      this.isBorder = false,
      this.height = 0.081,
      this.labelText = '',
      this.isExpanded = true,
      this.bgColor = AppColor.white,
      required this.validatorCallback});
  final Function(String) validatorCallback;
  final TextEditingController textEditingController;
  final double paddingHorizontal;
  final double height;
  final Color bgColor;
  final bool isBorder;
  final bool isExpanded;
  final String labelText;
  // final AddMaterialViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getSize.height * height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: context.getSize.width * paddingHorizontal),
      child: TextFormField(
          expands: isExpanded,
          maxLength: null,
          maxLines: null,
          decoration: InputDecoration(
              border: isBorder == true ? null : InputBorder.none,
              labelText: isBorder == true ? labelText : null),
          controller: textEditingController,
          validator: (val) {
            validatorCallback(val!);
            return null;
          }),
    );
  }
}
