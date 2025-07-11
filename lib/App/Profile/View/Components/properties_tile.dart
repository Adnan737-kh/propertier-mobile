import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/price_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../Model/property.dart';
import '../../../../extensions/ago_time_converter.dart';
import '../../Service/profile_service.dart';

Container propertiesTile(BuildContext context,
    {required Property property,String? accessToken,
    bool isItFromFeatured = false,
      bool isItSelected = false,
    void Function()? onFeaturedClick,
    required ProfileViewModel viewModel}) {
  return Container(
    padding: const EdgeInsets.only(left: 3, right: 3, top: 3),
    margin: EdgeInsets.symmetric(
        horizontal: context.getSize.width * 0.015, vertical: 5),
    width: context.getSize.width / 2,
    // height: context.getSize.height * 0.42,
    decoration: BoxDecoration(
        color: AppColor.white,
        border: border(),
        boxShadow: [
          boxShadow(),
        ],
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.propertyDetailView,
                arguments: {"slug": property.slug, "user": "user"});
          },
          child: Container(
            height: context.getSize.height * 0.190,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(property.image ?? Constant.dummyImage),
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 5,
                  child: GestureDetector(
                      onTap: () {},
                      // onTap: () {},
                      child: Image.asset(
                        Constant.share,
                        width: context.getSize.width * 0.034,
                        height: context.getSize.height * 0.019,
                      )),
                ),
                Positioned(
                  left: 0,
                  bottom: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: const BoxDecoration(
                        color: AppColor.buttonColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )),
                    child: CustomText(
                        fontSize: 12, title: property.propertyType!,),
                  ),
                ),
              ],
            ),
          ),
        ),
        getHeight(context, 0.010),
        Padding(
          padding: EdgeInsets.only(
            left: context.getSize.width * 0.008,
            right: context.getSize.width * 0.008,
            bottom: context.getSize.width * 0.008,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              isItFromFeatured
                  ?
                  InkWell(
                    onTap: onFeaturedClick,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: CustomText(
                              title: context.local.click_to_feature_ad,
                              textDecoration: TextDecoration.underline,
                              color: AppColor.greenColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                        const Icon(Icons.add,color: AppColor.greenColor,)
                      ],
                    ),
                  )
                  : const Gap(0),
              getHeight(context, 0.008),
              CustomText(
                  title: getTimeAgo(property.createdAt!),
                  colorOpecity: 0.7,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
              getHeight(context, 0.005),
              CustomText(
                  textAlign: TextAlign.left,
                  title: property.title!,
                  colorOpecity: 1,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold),
              getHeight(context, 0.008),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "PKR ",
                      style: textStyle(
                          context: context,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: double.parse(property.price!.toString())
                          .formatPrice(),
                      style: textStyle(context: context, fontSize: 10)),
                ]),
              ),
              getHeight(context, 0.008),
              // appText(
              //     textAlign: TextAlign.left,
              //     overflow: TextOverflow.ellipsis,
              //     title: property.address!,
              //     context: context,
              //     colorOpecity: 0.7,
              //     fontSize: 10,
              //     fontWeight: FontWeight.w500),
              // getHeight(context, 0.008),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Constant.marla,
                        width: context.getSize.width * 0.050,
                        height: context.getSize.height * 0.02,
                      ),
                      CustomText(
                          title: '${(property.area!.toString()).toString()} ${property.areaUnit ?? ''}',

                          // title:
                          //     " ${double.parse(property.area!.toString()).convertArea(areaType: property.areaUnit ?? '')} ${property.areaUnit ?? ''} ",
                          colorOpecity: 1,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Ionicons.heart_outline,
                        size: 12,
                      ),
                      const Gap(4),
                      CustomText(
                          fontSize: 10,
                          colorOpecity: 0.60,
                          title: property.likes!.toString(),
                          ),
                    ],
                  ),
                ],
              ),
              // getHeight(context, 0.004),
              // Spacer(),
            ],
          ),
        ),
        isItFromFeatured
            ? const Gap(0)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton.icon(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColor.googleColor)),
                        // color: AppColor.googleColor,
                        label: CustomText(
                            title: "Delete",
                            color: AppColor.white,),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this property?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Cancel action
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Proceed with delete action
                                      viewModel.isLoading.value = true;
                                      ProfileService()
                                          .deleteProperty(
                                              context: context,
                                              id: property.id!.toString(),
                                        accessToken: accessToken!
                                      )
                                          .whenComplete(() {
                                        viewModel.getProfile(
                                          context: context,
                                          accessToken:viewModel.accessToken!
                                        );
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: AppColor.googleColor,
                                        foregroundColor: AppColor.white
                                        // primary: Colors.red, // Make the Delete button red
                                        ),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColor.white,
                        )),
                  ),
                ],
              )
      ],
    ),
  );
}
