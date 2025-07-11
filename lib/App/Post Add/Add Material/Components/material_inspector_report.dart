import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/Utils/divider.dart';

import '../../../../constant/colors.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/height_width_box.dart';

class MaterialInspectReportView extends StatefulWidget {
  const MaterialInspectReportView({super.key});

  @override
  State<MaterialInspectReportView> createState() =>
      _MaterialInspectReportViewState();
}

class _MaterialInspectReportViewState extends State<MaterialInspectReportView> {
  // final iDCardVM = Get.find<IDVerficationViewModel>();
  File? _pickedFrontImage;

  Future<void> pickImage(bool front) async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (imageFile != null) {
      if (front) {
        setState(() {
          _pickedFrontImage = File(imageFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: "Inspection Report",
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            getHeight(context, 0.015),
            iDUploadTile(
              isLoading: false,
              image: _pickedFrontImage,
              onTap: () {
                setState(() {
                  _pickedFrontImage = null;
                });
                pickImage(true);
              },
            ),
            getHeight(context, 0.015),
            CustomText(
              title: "Near By Ware House ",
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            getHeight(context, 0.015),
            getHeight(context, 0.016),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    title: "Talk ID",
                    fontSize: 14,
                    color: const Color(0xFF6D6E6F),
                    fontWeight: FontWeight.bold),
                CustomText(
                    title: "73648A467383",
                    fontSize: 14,
                    color: const Color(0xFF6D6E6F),
                    fontWeight: FontWeight.bold),
              ],
            ),
            getHeight(context, 0.012),
            divider(context: context),
          ],
        ),
      ),
    );
  }
}

Widget iDUploadTile({required bool isLoading, File? image, Function()? onTap}) {
  var context = Get.context!;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 170,
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
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 38,
                  ),
                  CustomText(
                      title: "Upload PDf File / Images",
                      fontSize: 16,
                      color: AppColor.white,
                      fontWeight: FontWeight.bold),
                ],
              ),
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
