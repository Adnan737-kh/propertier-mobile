import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/appbar.dart';
import '../../../Utils/box_shadow.dart';
import '../../../Utils/divider.dart';
import '../../../Utils/height_width_box.dart';
import '../../../Utils/search_text_field.dart';
import '../../../Utils/text_botton.dart';
import '../../../constant/colors.dart';
import '../../../constant/constant.dart';
import '../../ServicesSearch/View/component/description_text_field.dart';
import '../../ServicesSearch/View/component/upload_work_photos_tile.dart';
import '../../ServicesSearch/View/component/yourself_textfield.dart';
import '../ViewModel/NearestServiceDetailViewModel.dart';
import 'component/service_detail_widget.dart';


class ServiceDetail extends GetView<NearestServiceDetailViewModel>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(alignment: Alignment.topCenter, children: [
            Image.asset(
              Constant.curve,
              width: context.getSize.width,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.getSize.width * 0.09),
                child: Column(
                  children: [
                    getHeight(context, 0.050),
                    customAppBar(
                        context: context,
                        onTap: () {
                          Get.back();
                        }),
                    getHeight(context, 0.1),
                    getHeight(context, 0.015),
                    controller.nearbyServices.service?.imageUrl != null?
                    Image.network(controller.nearbyServices.service?.imageUrl??Constant.dummayImage,height: 100,
                      width: 86,):
                    SvgPicture.asset(
                      Constant.servicesSearchIcon,
                      height: 100,
                      width: 86,
                    ),
                    getHeight(context, 0.01),
                    appText(
                        title: controller.nearbyServices.service?.title??"",
                        fontSize: 18,
                        colorOpecity: 0.6,
                        fontWeight: FontWeight.w500,
                        context: context),
                    Column(
                      children: [
                        InstaImageViewer(
                          imageUrl:
                          controller.nearbyServices.imageUrls?.first??
                              Constant.dumyImage2,
                          child: Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(
                                left: 36,
                                right: 36,
                                top: context.getSize.height * 0.050),
                            width: context.getSize.width,
                            height: context.getSize.height * 0.20,
                            decoration: BoxDecoration(
                              // border: Border.all(width: 5),
                                boxShadow: [boxShadow()],
                                image: controller.nearbyServices.imageUrls?.first == null
                                    ? null
                                    : DecorationImage(
                                    image: NetworkImage(controller.nearbyServices.imageUrls?.first??
                                        Constant.dumyImage2),
                                    fit: BoxFit.cover)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 36),
                          width: context.getSize.width,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              boxShadow: [boxShadow()],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          // height: context.getSize.height * 0.12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  appText(
                                      title: controller.nearbyServices.title ??"",
                                      context: context,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  getWidth(context, 0.010),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.buttonColor),
                                    child: Icon(
                                      Icons.check,
                                      size: context.getSize.width * 0.03,
                                      color: AppColor.blackColor,
                                    ),
                                  )
                                ],
                              ),
                              getHeight(context, 0.010),
                              Align(
                                alignment: Alignment.centerRight,
                                child: RatingBarIndicator(
                                  rating: 4,
                                  unratedColor: AppColor.greenColor,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: context.getSize.width * 0.034,
                                  direction: Axis.horizontal,
                                ),
                              ),
                              getHeight(context, 0.020),
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: appText(
                              //       colorOpecity: 0.6,
                              //       title: controller.nearbyServices.fixedPrice != null ?"Fixed Charges: ${controller.nearbyServices.fixedPrice}":"",
                              //       fontSize: 10,
                              //       fontWeight: FontWeight.w600,
                              //       context: context),
                              // ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: appText(
                                    colorOpecity: 0.6,
                                    title: controller.nearbyServices.visitingCharges != null ?"Visiting Charges:  ${controller.nearbyServices.visitingCharges} Rs":"",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    context: context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    getHeight(context, 0.016),
                    appText(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        title: "Select Service",
                        context: context),
                    Obx(()=> controller.subServices.isEmpty?SizedBox():DropdownButton<int>(
                      hint: Text("Select an option"),
                      value: controller.selectedServiceId!.value == 0 ? null : controller.selectedServiceId!.value,
                      items: controller.subServices.map((item) {
                        return DropdownMenuItem<int>(
                          value: item['id'],
                          child: Text(item['title']??""),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        controller.selectedServiceId!.value = newValue??0;
                      },
                    )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getHeight(context, 0.01),
                        divider(
                            context: context,
                            color: AppColor.blackColor.withOpacity(0.75)),
                        getHeight(context, 0.015),
                        appText(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            title: context.local.uploadWorkPhoto,
                            context: context),
                        getHeight(context, 0.008),
                        const UploadWorkPhotosWidget(),
                        getHeight(context, 0.015),
                        appText(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            title: context.local.descriptionAboutYourWork,
                            context: context),
                        getHeight(context, 0.008),
                        DescriptionTextField(
                          descriptionController:
                          controller.descriptionController,
                        ),
                        getHeight(context, 0.024),
                        textButton(
                            textFontSize: 20,
                            textFontWeight: FontWeight.w500,
                            context: context,
                            title: 'Offer to Plumber',
                            onClick: () {
                              // viewModel.createBidByCustomer(context,parentServicesModel,subservices);
                              print(controller.imageFileList.length);
                              print(controller.descriptionController.text);
                              print(controller.nearbyServices.id);
                              print(controller.selectedServiceId?.value);
                              controller.createBidByCustomer(context);
                            })
                      ],
                    )
                  ],
                )),
          ]),
        ));
  }
}