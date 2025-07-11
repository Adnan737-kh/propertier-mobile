import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/Components/add_property_facilities.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/Components/overlayWidget.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/app_text.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/box_shadow.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../Utils/text_botton.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/constant.dart';
import '../../../../constant/custom_dailog.dart';
import '../../../Profile/Model/profile_model.dart';
import '../../../Profile/ViewModel/profile_view_model.dart';
import '../../../Rental/Components/rental_cutom_btn.dart';
import '../Components/add_property_info.dart';
import '../Components/addproperties_inspector_report.dart';
import '../Components/addproperties_inspector_uploadshortvideo.dart';
import '../Components/addproperties_inspector_uploadvideo.dart';
import '../Components/addproperty_location.dart';
import '../ViewModel/add_properties_view_model.dart';

class AddPropertiesView extends GetView<AddPropertiesViewModel> {
  AddPropertiesView({super.key});
  final UploadPropertyViewModel cont = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getHeight(context, 0.050),
                    customAppBar(
                      context: context,
                      onTap: () {
                        CustomAlertDialog.show(
                          context: context,
                          title: context.local.are_you_sure,
                          message: context.local.do_you_want_to_go_back,
                          confirmText: context.local.back,
                          cancelText:context.local.cancel,
                          onConfirm: () {
                            Get.back();
                          },
                          onCancel: () {},
                        );
                      },
                    ),
                    getHeight(context, 0.045),
                    Image.asset(
                      Constant.onboardingIcon,
                      height: context.getSize.height * 0.03,
                    ),
                    getHeight(context, 0.045),
                    rentalCustomButton(
                        title: context.local.properties,
                        buttonColor: AppColor.greenColor,
                        onTap: () {}),
                    getHeight(context, 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(title: context.local.title, fontSize: 18),
                      ],
                    ),
                    getHeight(context, 0.008),
                    CustomAddTextField(
                      textEditingController: controller.titleController,
                      border: InputBorder.none,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.local.please_enter_title;
                        }
                        return null;
                      },
                    ),
                    getHeight(context, 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                            title: context.local.description, fontSize: 18),
                      ],
                    ),

                    const SizedBox(height: 20),
                    getHeight(context, 0.008),
                    CustomAddTextField(
                      textEditingController: controller.descriptionController,
                      border: InputBorder.none,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.local.please_enter_description;
                        }
                        return null;
                      },
                    ),
                    getHeight(context, 0.025),

                    Obx(() => GestureDetector(
                          onTap: () => controller.showCountryPickerFn(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 18.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.selectedCountry.value?.name ??
                                      context.local.select_country,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        controller.selectedCountry.value == null
                                            ? Colors.grey
                                            : Colors.black,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        )),
                    getHeight(context, 0.015),
                    customTextField(
                        isFilled: true,
                        hintText: context.local.please_enter_city,
                        controller: controller.cityController),

                    getHeight(context, 0.025),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(context.local.select_currency,
                          style: const TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(height: 6),
                    Obx(() => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.selectedCurrency.value,
                              isExpanded: true,
                              items: controller.currencyList
                                  .map((currency) => DropdownMenuItem(
                                        value: currency,
                                        child: Text(currency),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.setCurrency(value);
                                }
                              },
                            ),
                          ),
                        )),
                    getHeight(context, 0.015),
                    Row(
                      children: [
                        Obx(() => Expanded(
                              child: CustomAddTextField(
                                formatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                textInputType: TextInputType.number,
                                labelText: controller.selectedPurpose != 1
                                    ? context.local.price
                                    : context.local.rent,
                                color: Colors.transparent,
                                textEditingController:
                                    controller.priceController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.local.please_enter_price;
                                  }
                                  return null;
                                },
                              ),
                            )),
                        const Gap(52),
                        Expanded(
                          child: CustomAddTextField(
                            textInputType: TextInputType.number,
                            labelText: context.local.size_area,
                            color: Colors.transparent,
                            textEditingController: controller.unitsController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.local.please_enter_size_area;
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    // getHeight(context, 0.015),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomAddTextField(
                    //         readOnly: true,
                    //         onTap: () {
                    //           searchLocationBottomSheet(
                    //               placesList: controller.places,
                    //               context: context,
                    //               searchController:
                    //                   controller.searchLocationController,
                    //               onChange: (val) {
                    //                   controller.searchPlaces(val);
                    //               },
                    //               onSelect: (val) {
                    //                 controller.locationController.text = val;
                    //                 controller.searchLocationController.clear();
                    //                 controller.places.clear();
                    //                 Get.back();
                    //               });
                    //         },
                    //           onTap: () {
                    //             searchLocationBottomSheet(
                    //               placesList: controller.placesList,
                    //               placesMap: controller.placesMap, // Pass the map of names -> GeoPoints
                    //               context: context,
                    //               searchController: controller.searchLocationController,
                    //               onChange: (val) {
                    //                 controller.searchPlaces(val);
                    //               },
                    //               onSelect: (GeoPoint? val) {
                    //                 controller.locationController.text = "${val?.latitude},"
                    //                     " ${val?.longitude}";
                    //                 controller.searchLocationController.clear();
                    //                 controller.placesList.clear();
                    //                 controller.placesMap.clear();
                    //                 // Get.back();
                    //               },
                    //             );
                    //           },
                    //         labelText: "Location",
                    //         color: Colors.transparent,
                    //         textEditingController:
                    //             controller.locationController,
                    //         validator: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return 'Provide Location';
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    getHeight(context, 0.020),
                    addPropertyLocations(
                        controller: controller, context: context),
                    getHeight(context, 0.017),
                    SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => textButton(
                                  buttonColor: controller.selectedPurpose == 0
                                      ? AppColor.buttonColor
                                      : AppColor.white,
                                  title: context.local.for_sale,
                                  onClick: () {
                                    controller.changeSelectedPurpose(0);
                                  },
                                  height: 24,
                                  context: context,
                                  textFontSize: 12,
                                  shadowColorOpacity: 0),
                            ),
                          ),
                          // getWidth(context, 0.010),
                          const Gap(10),
                          Expanded(
                            child: Obx(
                              () => textButton(
                                  title: context.local.for_rent,
                                  onClick: () {
                                    controller.changeSelectedPurpose(1);
                                  },
                                  height: 24,
                                  buttonColor: controller.selectedPurpose == 1
                                      ? AppColor.buttonColor
                                      : AppColor.white,
                                  context: context,
                                  textFontSize: 12,
                                  shadowColorOpacity: 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    getHeight(context, 0.017),
                    addPropertyInfo(controller: controller, context: context),
                    getHeight(context, 0.015),
                    addPropertyFacilities(
                        controller: controller, context: context),
                    getHeight(context, 0.015),
                    AddPropertyInspectReportView(),
                    getHeight(context, 0.016),
                    Obx(
                      () => controller.galleryImage.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                controller.multiImagePick();
                              },
                              child: Container(
                                height: context.getSize.height * 0.2,
                                width: context.width * 0.8,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.black.withOpacity(0.4),
                                        size: 38,
                                      ),
                                      CustomText(
                                          title:
                                              context.local.pick_gallery_images,
                                          fontSize: 16,
                                          colorOpecity: 0.4,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: List.generate(
                                controller.galleryImage.length,
                                (index) => Container(
                                  height: context.getSize.height * 0.1,
                                  width: context.getSize.width * 0.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(controller.galleryImage[index]),
                                        ),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.3),
                                          BlendMode.colorBurn,
                                        ),
                                      )),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.removeImage(index);
                                    },
                                    child: const Icon(
                                      Icons.close_outlined,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    getHeight(context, 0.016),
                    const AddPropertyUploadVideoView(),
                    getHeight(context, 0.016),
                    const AddPropertyUploadShortVideoView(),
                    getHeight(context, 0.016),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => controller.isSuccess.value == false
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.buttonColor,
                                  ),
                                )
                              : Expanded(
                                  child: textButton(
                                    onClick: () {
                                      final viewModel =
                                          Get.put(ProfileViewModel());
                                      Rx<ProfileModel> profileModel =
                                          ProfileModel().obs;

                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        // Custom validation checks
                                        if (controller
                                            .titleController.text.isEmpty) {
                                          Get.snackbar(context.local.error,
                                              context.local.title_is_required);
                                          return;
                                        }

                                        if (controller.descriptionController
                                            .text.isEmpty) {
                                          Get.snackbar(
                                            context.local.error,
                                            context
                                                .local.description_is_required,
                                          );
                                          return;
                                        }

                                        if (controller
                                            .cityController.text.isEmpty) {
                                          Get.snackbar(
                                            context.local.error,
                                            context.local.city_is_required,
                                          );
                                          return;
                                        }

                                        if (controller
                                            .priceController.text.isEmpty) {
                                          Get.snackbar(
                                            context.local.error,
                                            context.local.price_is_required,
                                          );
                                          return;
                                        }

                                        if (controller
                                            .unitsController.text.isEmpty) {
                                          Get.snackbar(
                                              context.local.error,
                                              context
                                                  .local.size_area_is_required);
                                          return;
                                        }

                                        if (controller.thumbnailImage.isEmpty) {
                                          Get.snackbar(
                                              context.local.error,
                                              context.local
                                                  .please_upload_a_thumbnail_image);
                                          return;
                                        }

                                        if (controller.isProfileCompleted ==
                                            false) {
                                          controller
                                              .uploadProperties(
                                            areaUnit: controller
                                                .selectAreaUnitType.value,
                                            context: context,
                                            agentID: GetStorage()
                                                .read('id')
                                                .toString(),
                                            galleryImages:
                                                controller.galleryImage,
                                            title:
                                                controller.titleController.text,
                                            price:
                                                controller.priceController.text,
                                            floor: controller
                                                        .selectedFloors.value ==
                                                    ""
                                                ? '0'
                                                : controller
                                                    .selectedFloors.value,
                                            features:
                                                controller.selectedFacilities,
                                            purpose:
                                                controller.selectedPurpose == 0
                                                    ? "sale"
                                                    : "rent",
                                            areaType: controller
                                                .selectedArea.value
                                                .toLowerCase(),
                                            type: controller
                                                .selectedPropertyType.value,
                                            bedroom: controller.selectedBedRoom
                                                        .value !=
                                                    ""
                                                ? controller
                                                    .selectedBedRoom.value
                                                : "0",
                                            bathroom: controller
                                                        .selectedBathroom
                                                        .value !=
                                                    ""
                                                ? controller
                                                    .selectedBathroom.value
                                                : "0",
                                            country: controller.selectedCountry
                                                .toString(),
                                            city:
                                                controller.cityController.text,
                                            address: controller
                                                .locationController.text,
                                            area:
                                                controller.unitsController.text,
                                            image: controller.thumbnailImage,
                                            shortVideo: controller.videoPath,
                                            video: controller.urlController.text
                                                    .trim()
                                                    .isEmpty
                                                ? ''
                                                : controller.urlController.text,
                                            description: controller
                                                .descriptionController.text,
                                            accessToken: controller.accessToken
                                                .toString(),
                                          )
                                              .then((success) {
                                            if (success) {
                                              controller.uploadCompleted.value =
                                                  true;
                                            }
                                          });
                                        } else {
                                          viewModel.showProfileCompletionDialog(
                                              context, profileModel.value);
                                        }
                                      }
                                    },
                                    context: context,
                                    title: context.local.post,
                                  ),
                                )),
                        ],
                      ),
                    ),
                    getHeight(context, 0.016),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => cont.isOverlayVisible.value == true
              ? Positioned(top: 40, child: OverlayWidget())
              : const SizedBox.shrink())
        ],
      ),
    );
  }
}

class CustomAddTextField extends StatelessWidget {
  const CustomAddTextField({
    super.key,
    this.labelText,
    required this.textEditingController,
    this.height = 0.1,
    this.validator,
    this.border,
    this.color,
    this.isShadowless,
    this.suffixIcon,
    this.readOnly = false,
    this.onChanged,
    this.formatter,
    this.onTap,
    this.textInputType = TextInputType.text,
  });
  final TextInputType textInputType;
  final bool readOnly;
  final String? labelText;
  final TextEditingController textEditingController;
  final double? height;
  final String? Function(String?)? validator;
  final InputBorder? border;
  final Color? color;
  final bool? isShadowless;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? formatter;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: height != null
          ? context.getSize.height * height!
          : context.getSize.height * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color ?? AppColor.white,
          boxShadow: isShadowless == null ? [] : [boxShadow()]),
      child: TextFormField(
          inputFormatters: formatter,
          style: textStyle(
            context: context,
          ),
          onChanged: onChanged,
          maxLength: null,
          maxLines: null,
          keyboardType: textInputType,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              border: border,
              labelText: labelText,
              labelStyle: textStyle(context: context, withOpacity: 0.6)),
          controller: textEditingController,
          validator: validator),
    );
  }
}
