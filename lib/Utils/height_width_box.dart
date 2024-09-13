import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/size_extension.dart';

getHeight(BuildContext context, double height) {
  return SizedBox(
    height: Get.context!.isPhone
        ? Get.context!.height * height
        : context.getSize.height * height,
  );
}

getWidth(BuildContext context, double width) {
  return SizedBox(
    width: context.getSize.width * width,
  );
}

sizeWidth(double widthofPhone, double widthofIpad) {
  return Get.context!.isPhone
      ? Get.context!.width * widthofPhone
      : Get.context!.width * widthofIpad;
}

sizeHeight(double heightOfPhone, double heightOfIpad) {
  return Get.context!.isPhone
      ? Get.context!.height * heightOfPhone
      : Get.context!.height * heightOfIpad;
}
