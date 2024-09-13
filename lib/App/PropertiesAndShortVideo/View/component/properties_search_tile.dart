import 'package:flutter/material.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

propertiesSearchTile(
    {required TextEditingController controller,
    required BuildContext context,
    required VoidCallback filterCallBack}) {
  const border = InputBorder.none;

  return Row(
    children: [
      Expanded(
        child: Container(
          height: context.getSize.height * 0.06,
          // padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: AppColor.blackColor.withOpacity(0.05), width: 0.4)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getWidth(context, 0.010),
              Image.asset(
                Constant.search,
                height: sizeHeight(0.025, 0.02),
                width: sizeWidth(0.050, 0.040),
              ),
              Expanded(
                child: TextFormField(
                  style: textStyle(
                      context: context,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor),
                  decoration: InputDecoration(
                    hintStyle: textStyle(
                        context: context,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor.withOpacity(0.3)),
                    hintText: context.local.searchHere,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    fillColor: AppColor.white,
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      getWidth(context, 0.010),
      GestureDetector(
        onTap: filterCallBack,
        child: Image.asset(
          Constant.filter,
          height: sizeHeight(0.1, 0.05),
          width: sizeWidth(0.10, 0.050),
        ),
      )
    ],
  );
}
