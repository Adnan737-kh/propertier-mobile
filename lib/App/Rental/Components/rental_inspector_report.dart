import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/App/Home/View/component/grid_tile.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../constant/colors.dart';
import '../../../Utils/height_width_box.dart';

class InspectReportView extends StatefulWidget {
  const InspectReportView({super.key});

  @override
  State<InspectReportView> createState() => _InspectReportViewState();
}

class _InspectReportViewState extends State<InspectReportView> {
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
      } else {
        setState(() {});
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
              title: context.local.inspection_report,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            getHeight(context, 0.015),
            iDUploadTile(
              isLoading: false,
              image: _pickedFrontImage,
              onTap: () {
                setState(() {});
                pickImage(true);
              },
            ),
            getHeight(context, 0.015),
            CustomText(
              title: context.local.near_by_propertire_office,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            getHeight(context, 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                    title: context.local.address,
                    fontSize: 14,
                    color: const Color(0xFF6D6E6F),
                    fontWeight: FontWeight.bold),
              ],
            ),
            getHeight(context, 0.015),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                    title: "Lorem ipsum dolor sit amet",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    colorOpecity: 0.7),
              ],
            ),
            getHeight(context, 0.012),
            divider(context: context),
            getHeight(context, 0.016),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    title: "Talk ID",
                    fontSize: 14,
                    color: Color(0xFF6D6E6F),
                    fontWeight: FontWeight.bold),
                CustomText(
                    title: "73648A467383",
                    fontSize: 14,
                    color: Color(0xFF6D6E6F),
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
                      title: context.local.upload_pdf_file_or_images,
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
