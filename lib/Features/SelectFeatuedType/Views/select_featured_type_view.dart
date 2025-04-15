import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Profile/View/Components/properties_tile.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/Features/SelectFeatuedType/Controller/select_featued_type_controller.dart';
import 'package:propertier/Model/property.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../App/What are you searching/View/Components/custom_botton_wryf.dart';
import '../../../Utils/app_text.dart';
import '../../../Utils/appbar.dart';
import '../../../Utils/box_shadow.dart';
import '../../../Utils/height_width_box.dart';
import '../../../constant/colors.dart';

class SelectFeaturedTypeView extends GetView<SelectFeatuedTypeController> {
  SelectFeaturedTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.getSize.width * 0.036),
          child: SingleChildScrollView(
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
                                    controller.featuredItemsList[index],
                                    (v) {
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
                      Obx(()=> Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller.featuredItem.value == 'Property' && controller.selectedPropertyID.value.id == null? "Select Property":controller.featuredItem.value == 'Property' && controller.selectedPropertyID.value.id != null? "Selected Property": ""),
                          if(controller.featuredItem.value == 'Property')
                            TextButton(onPressed: (){
                              Get.to(FullScreenProperties());
                            }, child: Text("View All",style: TextStyle(
                              color: AppColor.blueColor
                            ),),)
                        ],
                      )),
                      Obx(() => controller.featuredItem.value == 'Property'
                          ? controller.selectedPropertyID.value.id == null
                          ? propertiesListView(context)
                          : Container(
                        width: context.width,
                        padding:
                        EdgeInsets.all(context.getSize.width * 0.036),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            boxShadow(),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          appText(
                                              title: "Title ",
                                              style: context
                                                  .textTheme.titleSmall,
                                              context: context),
                                          const Gap(3),
                                          appText(
                                              title:
                                              " ${controller.selectedPropertyID.value.title!}",
                                              style: context
                                                  .textTheme.bodySmall,
                                              context: context),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Gap(5),
                                  divider(
                                      context: context, withOpacity: 0.2),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          appText(
                                              title: "Description ",
                                              style: context
                                                  .textTheme.titleSmall,
                                              context: context),
                                          const Gap(3),
                                          appText(
                                              title:
                                              " ${controller.selectedPropertyID.value.description!}",
                                              style: context
                                                  .textTheme.bodySmall,
                                              context: context),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Gap(10),
                            IconButton(
                                onPressed: () {
                                  controller.selectedPropertyID.value =
                                      Property();
                                },
                                icon: const Icon(
                                  color: AppColor.googleColor,
                                  Icons.delete,
                                ))
                          ],
                        ),
                      )
                          : const Gap(0))
                    ],
                  ),
                ),
                // getHeight(context, 0.036),
                Container(
                  padding: EdgeInsets.all(context.getSize.width * 0.036),
                  margin: const EdgeInsets.only(top: 10),
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
                const Gap(10),
                Obx(() => controller.featuredTypeList[2] ==
                        controller.selectedFeaturedType.value
                    ? iDUploadTile(
                        isLoading: false,
                        image: controller.pickedImage,
                        onTap: () {
                          controller.pickImage(true);
                        },
                      )
                    : const Gap(0)),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: customButton(
              title: "Next",
              onTap: () async {
                print(controller.selectedPropertyID.value.id.toString());
                print(controller.pickedImage);
                if (controller.featuredTypeList[2] ==
                    controller.selectedFeaturedType.value) {
                  if (controller.pickedImage != '') {
                    String propertyId = controller.selectedPropertyID.value.id.toString();
                    Get.toNamed(AppRoutes.paymentGatWayView, arguments: {
                      "propertyId": propertyId,
                      "pickedImage": controller.pickedImage,
                      "featuredItem": controller.featuredItem.value
                    });
                  } else {
                    Get.rawSnackbar(message: 'Please Upload Banner');
                  }
                } else if (controller.featuredItemsList[1] ==
                    controller.featuredItem.value) {
                  if (controller.selectedPropertyID.value.id != null) {
                    Get.toNamed(AppRoutes.paymentGatWayView,arguments: {
                      "propertyId": controller.selectedPropertyID.value.id.toString(),
                      "pickedImage": controller.pickedImage,
                      "featuredItem": controller.featuredItem.value
                    });
                  } else {
                    Get.rawSnackbar(message: 'Please Select Property');
                  }
                }
              }),
        ),
      ),
    );
  }

  final viewModel = Get.find<ProfileViewModel>();
  SizedBox propertiesListView(BuildContext context) {
    return SizedBox(
      height: 350,
      width: context.getSize.width,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.profileModel.value.properties != null
            ? viewModel.profileModel.value.properties!.isNotEmpty
                ? viewModel.profileModel.value.properties!.length <= 5
                    ? viewModel.profileModel.value.properties!.length
                    : 10
                : 0
            : 0,
        itemBuilder: (context, index) {
          return propertiesTile(context, viewModel: viewModel,
              onFeaturedClick: () {
            controller.selectedPropertyID.value =
                viewModel.profileModel.value.properties![index];
          },
              isItFromFeatured: true,
              property: viewModel.profileModel.value.properties![index]);
        },
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


class FullScreenProperties extends StatelessWidget {
  const FullScreenProperties({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<ProfileViewModel>();
    final controller = Get.find<SelectFeatuedTypeController>();
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          getHeight(context, 0.046),
          customAppBar(
            context: context,
            title: "Select Property",
            onTap: () {
              Get.back();
            },
          ),
          getHeight(context, 0.036),
          Expanded(child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: viewModel.profileModel.value.properties != null
                ? viewModel.profileModel.value.properties!.isNotEmpty
                ? viewModel.profileModel.value.properties!.length <= 5
                ? viewModel.profileModel.value.properties!.length
                : 10
                : 0
                : 0,
            itemBuilder: (context, index) {
              return propertiesTile(context, viewModel: viewModel,
                  onFeaturedClick: () {
                    controller.selectedPropertyID.value =
                    viewModel.profileModel.value.properties![index];
                    Get.back();
                  },
                  isItFromFeatured: true,
                  property: viewModel.profileModel.value.properties![index]);
            },
          ))
        ],
      )
    );
  }
}

