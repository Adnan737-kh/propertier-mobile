import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/colors.dart';

Widget documentsUploadTile(
    {required bool isLoading, File? image, Function()? onTap}) {
  var context = Get.context!;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: context.width * 0.7,
      width: context.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.darkGreyColor.withOpacity(.25),
              blurRadius: 4,
              offset: const Offset(-1, 1),
            )
          ],
          color: AppColor.darkGreyColor.withOpacity(.3)),
      child: image == null
          ? const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 38,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                image,
                fit: BoxFit.fill,
              )),
    ),
  );
}
