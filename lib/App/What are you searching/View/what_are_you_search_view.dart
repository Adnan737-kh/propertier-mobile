import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/loading_view.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/list_of_types.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../Utils/animated_toggle.dart';
import '../../../Utils/appbar.dart';
import '../../../Utils/height_width_box.dart';
import '../ViewModel/what_are_viewmodel.dart';
import 'Components/custom_botton_wryf.dart';
import 'Components/custom_container.dart';
import 'Components/text_icon_button.dart';

class WhatAreYouSearchView extends GetView<WhatAreYouSearchViewModel> {
  const WhatAreYouSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.030),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeight(context, 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customAppBar(
                    context: context,
                    onTap: () {
                      Get.back();
                    },
                    // title: context.local.whatAreYouSearchingFor,
                  ),
                  AnimatedToggle(
                      values: const ['Buy', 'Rent'],
                      onToggleCallback: (val) {
                        controller.setSelectPurpose(val);
                      }),
                ],
              ),
              getHeight(context, 0.045),
              getHeight(
                context,
                0.015,
              ),
              Row(
                children: [
                  // Expanded(
                  //     child: textIconButton(
                  //         height: 30,
                  //         fontSize: 12,
                  //         title: "Filter",
                  //         onTap: () {},
                  //         icondata: Icons.tune)),
                  // const Gap(5),
                  // Expanded(
                  //     child: textIconButton(
                  //         height: 30,
                  //         fontSize: 12,
                  //         title: "Location",
                  //         onTap: () {

                  //         },
                  //         icondata: Icons.arrow_drop_down_rounded)),
                  const Gap(5),
                  Expanded(
                      child: textIconButton(
                          height: 30,
                          fontSize: 12,
                          title: context.local.price_range,
                          onTap: () {
                            selectPriceRange(
                                context: context, viewModel: controller);
                          },
                          iconData: Icons.arrow_drop_down_rounded))
                ],
              ),
              getHeight(context, 0.010),
              Obx(() => locationTile(
                    context: context,
                    tile: controller.selectedPlace.isNotEmpty
                        ? "${context.local.select} ${controller.selectedPlace}"
                        : context.local.please_select_location,
                    onTap: () {
                      Get.to(() => SelectLocation(viewModel: controller));
                    },
                  )),
              getHeight(context, 0.015),
              Obx(() => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        ListOfTypes().types.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              controller
                                  .setSelectType(ListOfTypes().types[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: context.getSize.width * 0.020),
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.getSize.width * 0.020,
                                  vertical: context.getSize.height * 0.010),
                              decoration: BoxDecoration(
                                  color: ListOfTypes().types[index] ==
                                          controller.selectType
                                      ? AppColor.buttonColor
                                      : AppColor.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: AppColor.blackColor.withOpacity(0.1),
                                    width: 0.4,
                                  )),
                              child: Row(
                                children: [
                                  CustomText(
                                      title: ListOfTypes().types[index],
                                      fontSize: 12,
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.normal)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )),
              getHeight(context, 0.015),
              divider(context: context, withOpacity: 0.2),
              getHeight(context, 0.015),
              sizeWRYSF(context, controller),
              getHeight(context, 0.015),
              const DescriptionWRYSF(),
              getHeight(context, 0.015),
              divider(context: context, withOpacity: 0.2),
              getHeight(context, 0.015),
              additionalDetailsWRYSF(context),
              getHeight(context, 0.015),
              bottomButtons(context),
              getHeight(context, 0.005),
            ],
          ),
        ),
      )),
    );
  }

  // Future<dynamic> setLocationWRYSF(
  //     {required BuildContext context,
  //     }) {
  //   return Get.generalDialog(
  //     pageBuilder: (context, animation, secondaryAnimation) {
  //       return Scaffold(
  //         body: SafeArea(
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(
  //                 horizontal: context.getSize.width * 0.060),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   getHeight(context, 0.04),
  //                   customAppBar(
  //                     context: context,
  //                     onTap: () {
  //                       Get.back();
  //                     },
  //                     title: "Set Location",
  //                   ),
  //                   getHeight(context, 0.04),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       SizedBox(
  //                         height: 40,
  //                         width: context.width * 0.688,
  //                         child: TextFormField(
  //                           controller: viewModel.searchAddressTextController..text=viewModel.currentAddress,
  //                           style: textStyle(context: context, fontSize: 12),
  //                           textAlignVertical: TextAlignVertical.bottom,
  //                           decoration: InputDecoration(
  //                             contentPadding: EdgeInsets.only(
  //                     top: context.getSize.height*0.13,
  //                     left: context.getSize.width * 0),
  //                             suffixIcon: const Icon(
  //                               Icons.search,
  //                               size: 20,
  //                             ),
  //                             hintText: "Search here...",
  //                             border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(30),
  //                                 borderSide: BorderSide.none),
  //                             fillColor:
  //                                 AppColor.darkGreyColor.withOpacity(0.2),
  //                             filled: true,
  //                           ),
  //                         ),
  //                       ),
  //                       // const Gap(5),
  //                       InkWell(
  //                         onTap: () {
  //                           Get.toNamed(AppRoutes.whatAreYouMapView);
  //                         },
  //                         child: Container(
  //                           height: 32,
  //                           decoration: BoxDecoration(
  //                               // color: AppColor.darkGreyColor.withOpacity(0.2),
  //                               border: Border.all(
  //                                   width: 0.5,
  //                                   color: AppColor.darkGreyColor
  //                                       .withOpacity(0.3)),
  //                               borderRadius: BorderRadius.circular(30)),
  //                           child: Padding(
  //                             padding:
  //                                 const EdgeInsets.symmetric(horizontal: 12.0),
  //                             child: Row(
  //                               children: [
  //                                 Image.asset(height: 20, Constant.mape),
  //                                 const Gap(3),
  //                                 appText(
  //                                     title: "Map",
  //                                     fontSize: 12,
  //                                     context: context),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                   getHeight(context, 0.04),
  //                   appText(
  //                       title: "Locations:", fontSize: 16, context: context),
  //                   getHeight(context, 0.020),
  //                   loctionTile(context: context, tile: "Islammabad"),
  //                   loctionTile(context: context, tile: "Lohore"),
  //                   loctionTile(context: context, tile: "Peshawar"),
  //                   loctionTile(context: context, tile: "Rawat"),
  //                   getHeight(context, 0.205),
  //                   Container(
  //                     padding: const EdgeInsets.all(8),
  //                     decoration: BoxDecoration(
  //                         border: Border.all(
  //                             color: AppColor.darkGreyColor.withOpacity(0.2)),
  //                         borderRadius: BorderRadius.circular(30)),
  //                     child: Row(
  //                       children: [
  //                         Expanded(
  //                           child: CustomButton(
  //                               buttonColor: AppColor.buttonColor,
  //                               textColor: AppColor.blackColor,
  //                               height: 30,
  //                               radius: 15,
  //                               title: "Confirm",
  //                               onTap: () {}),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  InkWell locationTile(
      {required BuildContext context,
      required String tile,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          getHeight(context, 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: context.width * 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                              title: tile,
                              // color: "Please Select Location" ==
                              //         tile
                              //     ? Colors.red
                              //     : AppColor.darkBack,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.normal,
                              colorOpecity: 0.7,
                              ),
                        )
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: "Please Select Location" == tile
                            ? Colors.red
                            : AppColor.greenColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.done,
                      size: 12,
                      color: AppColor.white,
                    ))
              ],
            ),
          ),
          getHeight(context, 0.01),
          divider(context: context, withOpacity: 0.2)
        ],
      ),
    );
  }

  Future<dynamic> selectPriceRange(
      {required BuildContext context,
      required WhatAreYouSearchViewModel viewModel}) {
    return Get.bottomSheet(
      backgroundColor: Colors.transparent,
      Obx(() => Material(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.030),
              child: Column(
                children: [
                  getHeight(context, 0.015),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            title: context.local.price_range,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        Image.asset(height: 24, Constant.down)
                      ],
                    ),
                  ),
                  getHeight(context, 0.01),
                  divider(context: context, withOpacity: 0.2),
                  getHeight(context, 0.015),
                  Row(
                    children: [
                      textIconButton(
                          width: 60,
                          height: 30,
                          fontSize: 12,
                          title: context.local.pkr,
                          onTap: () {},
                          iconData: Icons.arrow_drop_down_rounded),
                    ],
                  ),
                  SfRangeSlider(
                    min: 0.0,
                    max: 10000000.0,
                    values: viewModel.priceValue.value,
                    interval: 5000000,
                    stepSize: 1,
                    // showTicks: true,
                    // showLabels: true,
                    activeColor: AppColor.buttonColor,
                    enableTooltip: true,
                    minorTicksPerInterval: 1,
                    onChanged: (SfRangeValues values) {
                      controller.priceValue.value = values;
                      controller.minPriceC.text = values.start.toString();
                      controller.maxPriceC.text = values.end.toString();
                    },
                  ),
                  getHeight(context, 0.015),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.minPriceC,
                          keyboardType: TextInputType.number,
                          onChanged: (v){
                            controller.priceValue.value = SfRangeValues(double.parse(v), controller.priceValue.value.end);
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,  // White background
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,   // Same grey color when unfocused
                                width: 1.0,           // 1 width border
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,   // Same grey color when focused
                                width: 1.0,           // 1 width border
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,   // Grey color
                                width: 1.0,           // 1 width border
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: controller.maxPriceC,
                          keyboardType: TextInputType.number,
                          onChanged: (v){
                            controller.priceValue.value = SfRangeValues(controller.priceValue.value.start, double.parse(v));
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,  // White background
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,   // Same grey color when unfocused
                                width: 0.5           // 1 width border
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,   // Same grey color when focused
                                width: 1.0,           // 1 width border
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,   // Grey color
                                width: 0.5,           // 1 width border
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     textIconButton(
                  //       width: 150,
                  //       height: 60,
                  //
                  //       fontSize: 12,
                  //       title:
                  //           // "Min ${viewModel.priceValue.value.start.toString().substring(0, viewModel.priceValue.value.start.toString().indexOf("."))}K",
                  //       "Min ${viewModel.priceValue.value.start.round()}",
                  //       onTap: () {},
                  //     ),
                  //     textIconButton(
                  //       width: 150,
                  //       fontSize: 12,
                  //       height: 60,
                  //       title:
                  //           // "Max ${viewModel.priceValue.value.end.toString().substring(0, viewModel.priceValue.value.end.toString().indexOf("."))}K",
                  //       "Max ${viewModel.priceValue.value.end.round()}",
                  //       onTap: () {},
                  //     ),
                  //   ],
                  // ),
                  getHeight(context, 0.015),
                  CustomButton(
                      height: 38,
                      fontSize: 14,
                      buttonColor: AppColor.buttonColor,
                      textColor: AppColor.blackColor,
                      title: context.local.apply,
                      onTap: () {
                        Get.back();
                      })
                ],
              ),
            ),
          )),
    );
  }

  Container bottomButtons(BuildContext context ) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.darkGreyColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(30)),
        child: Obx(
          () => controller.isLoading.value
              ? const LoadingView()
              : Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          height: 30,
                          fontSize: 14,
                          buttonColor: Colors.transparent,
                          textColor: AppColor.greenColor,
                          borderColor: AppColor.greenColor,
                          radius: 15,
                          title: context.local.clear_all,
                          onTap: () {
                            // Get.offAndToNamed(AppRoutes.whatAreYouSearchingView);
                          }),
                    ),
                    const Gap(10),
                    Expanded(
                      child: CustomButton(
                          fontSize: 14,
                          buttonColor: AppColor.buttonColor,
                          textColor: AppColor.blackColor,
                          height: 30,
                          radius: 15,
                          title: context.local.submit,
                          onTap: () {
                            controller.postCustomerRequest();
                          }),
                    ),
                  ],
                ),
        ));
  }

  Container additionalDetailsWRYSF(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: context.width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.darkGreyColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                    text: context.local.additional_details,
                    style: textStyle(
                        context: context,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: " [optional]",
                          style: textStyle(
                              context: context, fontSize: 12, withOpacity: 0.4))
                    ]),
              ),
            ],
          ),
          getHeight(context, 0.010),
          textFieldWRYSF(
              context: context,
              hint: context.local.name,
              controller: controller.nameController),
          getHeight(context, 0.010),
          textFieldWRYSF(
              context: context,
              hint: context.local.phone_number,
              controller: controller.phoneNumberController),
          getHeight(context, 0.010),
          textFieldWRYSF(
              context: context,
              hint: context.local.email,
              controller: controller.emailController),
          getHeight(context, 0.010),
          // textFieldWRYSF(context: context, hint: "Comment:", expend: true),
        ],
      ),
    );
  }

  Column textFieldWRYSF(
      {required BuildContext context,
      required String hint,
      bool? expend,
      TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            title: hint,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            colorOpecity: 0.7),
        getHeight(context, 0.004),
        SizedBox(
          height: expend != null ? context.height * 0.158 : null,
          child: TextFormField(
            maxLines: expend != null ? null : 1,
            expands: expend ?? false,
            readOnly: true,
            style: textStyle(
              context: context,
              fontSize: 12,
            ),
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: AppColor.darkGreyColor.withOpacity(0.1)),
          ),
        )
      ],
    );
  }

  Container sizeWRYSF(BuildContext context, WhatAreYouSearchViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: context.width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.darkGreyColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(5)),
      child: Obx(() => Column(
            children: [
              Row(
                children: [
                  CustomText(
                      title: context.local.size,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)
                ],
              ),
              const Gap(10),
              Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  runSpacing: 15,
                  children: List.generate(
                    vm.sizeType.length,
                    (index) {
                      return customContainer(
                        radius: 02,
                        context: context,
                        title: vm.sizeType[index],
                        isSelect: vm.selectSize == vm.sizeType[index],
                        onTap: () {
                          vm.setSelectSize(vm.sizeType[index]);
                        },
                      );
                    },
                  ).toList()),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: context.local.enter_custom_size,
                    content: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          customTextField(
                              hintText: "",
                              controller: controller.customAreaSizeController),
                          const Gap(15),
                          CustomButton(
                              title: context.local.add,
                              onTap: () {
                                vm.sizeType
                                    .add(vm.customAreaSizeController.text);
                                vm.setSelectSize(
                                    vm.customAreaSizeController.text);
                                Get.back();
                              })
                        ],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: CustomText(
                      title: context.local.add_custom,
                      color: AppColor.facebookColor,
                      ),
                ),
              ),
            ],
          )),
    );
  }
}

class DescriptionWRYSF extends StatelessWidget {
  const DescriptionWRYSF({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WhatAreYouSearchViewModel());

    return Container(
      padding: const EdgeInsets.all(5),
      width: context.width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.darkGreyColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                  title: context.local.description,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)
            ],
          ),
          const Gap(3),
          divider(context: context, withOpacity: 0.2),
          const Gap(10),
          SizedBox(
            height: context.getSize.height * 0.158,
            child: TextField(
              style: textStyle(context: context, fontSize: 12),
              expands: true,
              maxLines: null,
              controller: controller.descriptionController,
              decoration: InputDecoration(
                  hintStyle: textStyle(
                      fontSize: 12, context: context, withOpacity: 0.4),
                  hintText: context.local.detail_here,
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}

class SelectLocation extends StatelessWidget {
  const SelectLocation({super.key, required this.viewModel});
  final WhatAreYouSearchViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeight(context, 0.04),
                customAppBar(
                  context: context,
                  onTap: () {
                    Get.back();
                  },
                  title: context.local.set_location,
                ),
                getHeight(context, 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 54,
                      width: context.width * 0.688,
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: viewModel.searchAddressTextController,
                        style: textStyle(context: context, fontSize: 12),
                        decoration: InputDecoration(
                          suffixIcon:
                              viewModel.searchAddressTextController.text == ""
                                  ? const Icon(
                                      Icons.search,
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        viewModel.searchAddressTextController
                                            .text = "";
                                      },
                                      child: const Icon(
                                        Icons.close,
                                      ),
                                    ),
                          hintText: context.local.search_here,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                          fillColor: AppColor.darkGreyColor.withOpacity(0.2),
                          filled: true,
                        ),
                        onChanged: (value) {
                          viewModel.searchPlaces(value);
                        },
                      ),
                    ),
                    // const Gap(5),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.whatAreYouMapView);
                      },
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                            // color: AppColor.darkGreyColor.withOpacity(0.2),
                            border: Border.all(
                                width: 0.5,
                                color: AppColor.darkGreyColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              Image.asset(height: 20, Constant.mape),
                              const Gap(3),
                              CustomText(
                                  title: context.local.map, fontSize: 12, ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                getHeight(context, 0.04),
                CustomText(
                    title: context.local.current_locations,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                     ),
                getHeight(context, 0.01),
                Obx(() => InkWell(
                      onTap: () {
                        viewModel.setSelectedPlace(viewModel.currentAddress);
                      },
                      child: CustomText(
                          title: viewModel.currentAddress,
                          textAlign: TextAlign.start,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          ),
                    )),
                getHeight(context, 0.020),
                CustomText(
                    title: context.local.selected,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    ),
                viewModel.selectedPlace.isNotEmpty
                    ? Obx(() => locationTile(
                          context: context,
                          tile: viewModel.selectedPlace,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(focusNode);
                          },
                        ))
                    : const SizedBox(),
                getHeight(context, 0.020),
                CustomText(
                    title: context.local.locations,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    ),
                getHeight(context, 0.020),
                DestinationSection(),
                getHeight(context, 0.020),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.darkGreyColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            buttonColor: AppColor.buttonColor,
                            textColor: AppColor.blackColor,
                            height: 40,
                            radius: 20,
                            title: context.local.confirm,
                            onTap: () {
                              Get.back();
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell locationTile(
      {required BuildContext context,
      required String tile,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          getHeight(context, 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: context.width * 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                              title: tile,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.normal,
                              colorOpecity: 0.7,
                              ),
                        )
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: AppColor.greenColor, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.done,
                      size: 12,
                      color: AppColor.white,
                    ))
              ],
            ),
          ),
          getHeight(context, 0.01),
          divider(context: context, withOpacity: 0.2)
        ],
      ),
    );
  }
}

class DestinationSection extends StatelessWidget {
  DestinationSection({
    super.key,
  });
  // final vm = Get.put(MapController());
  final controller = Get.put(WhatAreYouSearchViewModel());

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Places Length ${controller.places.length}");
    }
    return Obx(
      () => ListView.builder(
        itemCount: controller.places.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return locationTile(
            context: context,
            tile: controller.places[index].description,
            onTap: () async {
              await controller
                  .setSelectedPlace(controller.places[index].description);
            },
          );
        },
      ),
    );
  }

  InkWell locationTile(
      {required BuildContext context,
      required String tile,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          getHeight(context, 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: context.width * 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                              title: tile,
                              fontSize: 16,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.normal,
                              colorOpecity: 0.7,
                              ),
                        )
                      ],
                    )),
                Image.asset(
                  Constant.tick,
                  height: 20,
                ),
              ],
            ),
          ),
          getHeight(context, 0.01),
          divider(context: context, withOpacity: 0.2)
        ],
      ),
    );
  }
}
