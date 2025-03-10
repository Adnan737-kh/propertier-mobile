import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/Components/add_property_facilities.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/Components/overlayWidget.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

// ignore: unused_import
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/box_shadow.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../Utils/search_location_bottom_sheet.dart';
import '../../../../Utils/text_botton.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/constant.dart';
import '../../../Rental/Components/rental_cutom_btn.dart';
import '../Components/add_property_info.dart';
import '../Components/addproperties_inspector_report.dart';
import '../Components/addproperties_inspector_uploadshortvideo.dart';
import '../Components/addproperties_inspector_uploadvideo.dart';
import '../Components/addproperty_location.dart';
import '../ViewModel/add_properties_view_model.dart';

// ignore: must_be_immutable
class AddPropertiesView extends GetView<AddPropertiesViewModel> {
  AddPropertiesView({super.key});
  UploadPropertyViewModel cont = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // print('the feature data ${controller.featuresList.value.data?.features[0].name!}');
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
                        Get.back();
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
                        appText(title: "Title", context: context, fontSize: 18),
                      ],
                    ),
                    getHeight(context, 0.008),
                    CustomAddTextField(
                      textEditingController: controller.titleController,
                      border: InputBorder.none,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Title';
                        }
                        return null;
                      },
                    ),
                    getHeight(context, 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        appText(
                            title: "Description",
                            context: context,
                            fontSize: 18),
                      ],
                    ),
                    getHeight(context, 0.008),
                    CustomAddTextField(
                      textEditingController: controller.descriptionController,
                      border: InputBorder.none,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide Description';
                        }
                        return null;
                      },
                    ),
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
                                    ? "Price"
                                    : "Rent",
                                color: Colors.transparent,
                                textEditingController:
                                    controller.priceController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Provide Price';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        const Gap(52),
                        Expanded(
                          child: CustomAddTextField(
                            textInputType: TextInputType.number,
                            labelText: "Size/Area",
                            color: Colors.transparent,
                            textEditingController: controller.unitsController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Provide Size/Area';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    getHeight(context, 0.015),
                    Row(
                      children: [
                        Expanded(
                          child: CustomAddTextField(
                            readOnly: true,
                            onTap: () {
                              searchLocationBottomSheet(
                                  placesList: controller.places,
                                  context: context,
                                  searchController:
                                      controller.searchLocationController,
                                  onChange: (val) {
                                      controller.searchPlaces(val);
                                  },
                                  onSelect: (val) {
                                    controller.locationController.text = val;
                                    controller.searchLocationController.clear();
                                    controller.places.clear();
                                    Get.back();
                                  });
                            },
                            //   onTap: () {
                            //     searchLocationBottomSheet(
                            //       placesList: controller.placesList,
                            //       placesMap: controller.placesMap, // Pass the map of names -> GeoPoints
                            //       context: context,
                            //       searchController: controller.searchLocationController,
                            //       onChange: (val) {
                            //         controller.searchPlaces(val);
                            //       },
                            //       onSelect: (GeoPoint? val) {
                            //         controller.locationController.text = "${val?.latitude},"
                            //             " ${val?.longitude}";
                            //         controller.searchLocationController.clear();
                            //         controller.placesList.clear();
                            //         controller.placesMap.clear();
                            //         // Get.back();
                            //       },
                            //     );
                            //   },
                            labelText: "Location",
                            color: Colors.transparent,
                            textEditingController:
                                controller.locationController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Provide Location';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    getHeight(context, 0.020),
                    addPropertylocations(
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
                                  title: "For Sale",
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
                                  title: "For Rent",
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
                    addPropertyFacilities(controller: controller, context: context),
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
                                      appText(
                                          title: "Pick Gallery Images",
                                          context: context,
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
                          Obx(() => cont.isSuccess.value == false
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.buttonColor,
                                  ),
                                )
                              : Expanded(
                                  child: textButton(
                                    onClick: () {
                                      if (kDebugMode) {
                                        print('selectedFacilities ${ controller.selectedFacilities}');
                                      }

                                      if (controller.formKey.currentState!.validate()) {
                                      controller.uploadProperties(
                                        areaUnit:
                                            controller.selectAreaUnitType.value,
                                        context: context,
                                        agentID:
                                            GetStorage().read('id').toString(),
                                        galleryImages: controller.galleryImage,
                                        title: controller.titleController.text,
                                        price: controller.priceController.text,
                                        floor: controller
                                                    .selectedFloors.value ==
                                                ""
                                            ? '0'
                                            : controller.selectedFloors.value,
                                        features: controller.selectedFacilities,
                                        purpose: controller.selectedPurpose == 0
                                            ? "sale"
                                            : "rent",
                                        areaType: controller.selectedArea.value
                                            .toLowerCase(),
                                        type: controller
                                            .selectedPropertyType.value,
                                        bedroom: controller
                                                    .selectedBedRoom.value !=
                                                ""
                                            ? controller.selectedBedRoom.value
                                            : "0",
                                        bathroom: controller
                                                    .selectedBathroom.value !=
                                                ""
                                            ? controller.selectedBathroom.value
                                            : "0",
                                        city:
                                            controller.locationController.text,
                                        address:
                                            controller.locationController.text,
                                        area: controller.unitsController.text,
                                        image: controller.pickedImage,
                                        shortVideo: controller.videoPath,
                                        video:
                                            controller.urlController.text == " "
                                                ? ''
                                                : controller.urlController.text,
                                        description: controller
                                            .descriptionController.text,
                                        accessToken:
                                            controller.accessToken.toString(),
                                      );
                                      }
                                    },
                                    // onClick: () async {
                                    //   controller.urlController.text =
                                    //       controller.urlController.text == "" ? " " : controller.urlController.text;
                                    //   if (controller.formKey.currentState!.validate()) {
                                    //     if (controller.galleryImage.isNotEmpty) {
                                    //       if (controller.pickedImage == '') {
                                    //         toast(
                                    //             title: "Upload Thumbnail image",
                                    //             context: Get.context!);
                                    //       } else {
                                    //         cont
                                    //             .uploadPropertyData(
                                    //                 areaUnit: controller
                                    //                     .selectAreaUnitType
                                    //                     .value,
                                    //                 context: context,
                                    //                 agentID: GetStorage()
                                    //                     .read('id')
                                    //                     .toString(),
                                    //                 galleryImages:
                                    //                     controller.galleryImage,
                                    //                 title: controller
                                    //                     .titleController.text,
                                    //                 price: controller
                                    //                     .priceController.text,
                                    //                 floor: controller.selectedfloors.value == ""
                                    //                     ? '0'
                                    //                     : controller
                                    //                         .selectedfloors
                                    //                         .value,
                                    //                 features: controller
                                    //                     .selectedFacilities,
                                    //                 purpose: controller.selectedPurpose == 0
                                    //                     ? "sale"
                                    //                     : "rent",
                                    //                 areaType: controller
                                    //                     .selectedArea.value
                                    //                     .toLowerCase(),
                                    //                 type: controller
                                    //                     .selectedpropertyType
                                    //                     .value,
                                    //                 bedroom: controller.selectedbedRoom.value != ""
                                    //                     ? controller
                                    //                         .selectedbedRoom
                                    //                         .value
                                    //                     : "0",
                                    //                 bathroom: controller
                                    //                             .selectedBathroom
                                    //                             .value !=
                                    //                         ""
                                    //                     ? controller
                                    //                         .selectedBathroom
                                    //                         .value
                                    //                     : "0",
                                    //                 city: controller.locationController.text,
                                    //                 address: controller.locationController.text,
                                    //                 area: controller.unitsController.text,
                                    //                 image: controller.pickedImage,
                                    //                 shortVideo: controller.videoPath,
                                    //                 video: controller.urlController.text == " " ? '' : controller.urlController.text,
                                    //                 description:
                                    //                 controller.descriptionController.text,
                                    //           accessToken: controller.accessToken.toString(),
                                    //         )
                                    //             .whenComplete(() {
                                    //           final vm =
                                    //               Get.put(ProfileViewModel());
                                    //           vm.getProfilePageData(
                                    //               context: context,
                                    //               id: GetStorage()
                                    //                   .read('id')
                                    //                   .toString());
                                    //         });
                                    //       }
                                    //     } else if (controller
                                    //         .galleryImage.isEmpty) {
                                    //       toast(
                                    //           title:
                                    //               'Please Pick Minimum One Gallery Images',
                                    //           context: context);
                                    //     } else if (controller
                                    //         .pickedImage.isEmpty) {
                                    //       toast(
                                    //           title:
                                    //               'Please upload inspection Report',
                                    //           context: context);
                                    //     }
                                    //   }
                                    // },
                                    context: context,
                                    title: 'Post',
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
