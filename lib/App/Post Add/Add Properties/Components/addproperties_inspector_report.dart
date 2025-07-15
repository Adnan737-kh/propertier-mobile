import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../../Utils/app_text.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../constant/colors.dart';

class AddPropertyInspectReportView extends StatelessWidget {
  AddPropertyInspectReportView({super.key});

  final controller = Get.put(AddPropertiesViewModel());

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
              title: context.local.thumbnail,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            getHeight(context, 0.015),
            Obx(
              () => Stack(
                children: [
                  iDUploadTile(
                    isLoading: false,
                    image: controller.thumbnailImage,
                    onTap: () {
                      controller.pickImage(true);
                    },
                  ),
                  controller.thumbnailImage != ""
                      ? Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              controller.setPickedImage("");
                            },
                            child: Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: AppColor.darkBack)),
                                child: const Icon(Icons.clear)),
                          ))
                      : const SizedBox()
                ],
              ),
            ),
            getHeight(context, 0.015),
          ],
        ),
      ),
    );
  }
}

Widget iDUploadTile({
  required bool isLoading,
  required String image,
  Function()? onTap,
}) {
  var context = Get.context!;
  final controller = Get.find<AddPropertiesViewModel>();
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 170,
      width: context.width * 0.8,
      decoration: BoxDecoration(
          border: controller.thumbnailImage != ""
              ? null
              : Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(.2)),
      child: image == ''
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black.withOpacity(0.4),
                    size: 38,
                  ),
                  CustomText(
                      title: context.local.upload_thumbnail_image,
                      fontSize: 16,
                      colorOpecity: 0.4,
                      color: controller.thumbnailImage != ""
                          ? Colors.black
                          : Colors.red,
                      fontWeight: FontWeight.bold),
                ],
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(image),
                fit: BoxFit.fill,
              )),
    ),
  );
}
