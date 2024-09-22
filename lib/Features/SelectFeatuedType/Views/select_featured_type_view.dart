import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Features/SelectFeatuedType/Controller/select_featued_type_controller.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../App/What are you searching/View/Components/custom_botton_wryf.dart';
import '../../../Utils/app_text.dart';
import '../../../Utils/appbar.dart';
import '../../../Utils/box_shadow.dart';
import '../../../Utils/height_width_box.dart';
import '../../../constant/colors.dart';

class SelectFeaturedTypeView extends GetView<SelectFeatuedTypeController> {
  const SelectFeaturedTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.getSize.width * 0.036),
          child: Column(
            children: [
              getHeight(context, 0.036),
              customAppBar(
                context: context,
                title: "",
                onTap: () {
                  Get.back();
                },
              ),
              getHeight(context, 0.036),
              Container(
                padding: EdgeInsets.all(context.getSize.width * 0.036),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    boxShadow(),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        appText(
                            title: "Select What to make ads",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            context: context),
                      ],
                    ),
                    getHeight(context, 0.01),
                    Obx(
                      () => Column(
                        children: List.generate(
                          controller.featuredItemsList.length,
                          (index) => radioOfFeaturebtns(
                              context,
                              controller.featuredItemsList[index],
                              controller.featuredItem.value ==
                                  controller.featuredItemsList[index], (v) {
                            if (controller.featuredItemsList[index] ==
                                'Profile') {
                              controller.selectedFeaturedType(
                                  controller.featuredTypeList[2]);
                              Get.rawSnackbar(
                                  message:
                                      'Profile can be ad featured only with banner');
                            }
                            controller.featuredItem(
                                controller.featuredItemsList[index]);
                          }),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              // getHeight(context, 0.036),
              Container(
                padding: EdgeInsets.all(context.getSize.width * 0.036),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    boxShadow(),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        appText(
                            title: "Select Ad Type",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            context: context),
                      ],
                    ),
                    getHeight(context, 0.01),
                    Obx(
                      () => Column(
                        children: List.generate(
                          controller.featuredTypeList.length,
                          (index) => radioOfFeaturebtns(
                              context,
                              controller.featuredTypeList[index],
                              controller.selectedFeaturedType.value ==
                                  controller.featuredTypeList[index], (v) {
                            if (controller.featuredItem.value != 'Profile') {
                              controller.selectedFeaturedType(
                                  controller.featuredTypeList[index]);
                            } else {
                              Get.rawSnackbar(
                                  message:
                                      'Profile can be ad featured only with banner');
                            }
                          }),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Obx(() => controller.featuredTypeList[2] ==
                      controller.selectedFeaturedType.value
                  ? iDUploadTile(
                      isLoading: false,
                      image: controller.pickedImage,
                      onTap: () {
                        controller.pickImage(true);
                      },
                    )
                  : const Gap(0))
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: customButton(
              title: "Next",
              onTap: () async {
                if (controller.featuredTypeList[2] ==
                    controller.selectedFeaturedType.value) {
                  if (controller.pickedImage != '') {
                    Get.toNamed(AppRoutes.paymentGatwayeView);
                  } else {
                    Get.rawSnackbar(message: 'Please Upload Banner');
                  }
                } else {
                  Get.toNamed(AppRoutes.paymentGatwayeView);
                }
              }),
        ),
      ),
    );
  }

  Row radioOfFeaturebtns(BuildContext context, String title, bool isSelect,
      void Function(bool?)? onChanged) {
    return Row(
      children: [
        Checkbox(
          shape: const CircleBorder(),
          activeColor: AppColor.facebookColor,
          value: isSelect,
          onChanged: onChanged,
        ),
        const Gap(4),
        appText(title: title, context: context, colorOpecity: 0.6),
      ],
    );
  }
}

Widget iDUploadTile({
  required bool isLoading,
  required String image,
  Function()? onTap,
}) {
  var context = Get.context!;
  final controller = Get.find<SelectFeatuedTypeController>();
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 170,
      width: context.width * 0.8,
      decoration: BoxDecoration(
          border: controller.pickedImage != ""
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
                  appText(
                      title: "Upload Banner Image",
                      context: context,
                      fontSize: 16,
                      colorOpecity: 0.4,
                      color: controller.pickedImage != ""
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
