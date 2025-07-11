import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
// import 'package:propertier/App/Auth/Login/Model/login_response_model.dart';
// import 'package:propertier/App/PropertiesAndShortVideo/Model/all_properties_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/price_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Model/property.dart';
import '../../../../Utils/border.dart';
import '../../../../extensions/ago_time_converter.dart';
import '../../../Home/Model/properties_tiler_button_model.dart';
import '../../ViewModel/service_provider_profile_viewmodel.dart';

Widget propertiesTile(
    {required Property property,
    required BuildContext context,
    required ServiceProviderProfileViewModel controller,
    required Agent user}) {
  return Container(
    padding: const EdgeInsets.all(3),
    margin: EdgeInsets.only(
        left: 2, right: context.getSize.width * 0.015, top: 5, bottom: 5),
    width: context.getSize.width / 2,
    // height: context.getSize.height * 0.281,
    decoration: BoxDecoration(
        color: AppColor.white,
        border: border(),
        boxShadow: [
          boxShadow(),
        ],
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.propertyDetailView,
                arguments: {"slug": property.slug!, "user": "null"});
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.020,
                vertical: context.getSize.height * 0.01),
            alignment: Alignment.topRight,
            height: context.getSize.height * 0.190,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(property.image ?? Constant.dummyImage),
                    fit: BoxFit.cover)),
            child: GestureDetector(
                onTap: () {},
                // onTap: () {},
                child: Image.asset(
                  Constant.share,
                  width: context.getSize.width * 0.034,
                  height: context.getSize.height * 0.019,
                )),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      title: getTimeAgo(property.createdAt!),
                      colorOpecity: 0.7,
                      fontSize: 8,
                      fontWeight: FontWeight.w500),
                  CustomText(
                      title: 'Residential',
                      colorOpecity: 0.7,
                      fontSize: 8,
                      fontWeight: FontWeight.w500),
                ],
              ),
              getHeight(context, 0.008),
              CustomText(
                  textAlign: TextAlign.left,
                  title: property.title!,
                  colorOpecity: 1,
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold),
              getHeight(context, 0.008),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "PKR ",
                      style: textStyle(
                          context: context,
                          fontSize: 8,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: double.parse(property.price!).formatPrice(),
                      style: textStyle(context: context, fontSize: 10)),
                ]),
              ),
              getHeight(context, 0.008),
              CustomText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  title: property.address!,
                  colorOpecity: 0.7,
                  fontSize: 8,
                  fontWeight: FontWeight.w500),
              getHeight(context, 0.008),
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
                          title: " ${(property.area! / 250).toString()} Marla",
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
              getHeight(context, 0.008),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    controller.propertiesTileButtonList.length, (i) {
                  PropertiesTileButtonModel propertiesButton =
                      controller.propertiesTileButtonList[i];
                  return GestureDetector(
                    onTap: () {
                      propertiesButton.onTap(
                          user.phoneNumberCountryCode! + user.phoneNumber!);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: propertiesButton.color,
                          border: Border.all(
                            color: propertiesButton.borderColor,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          propertiesButton.icon != null
                              ? Icon(
                                  propertiesButton.icon,
                                  color: propertiesButton.titleColor,
                                  size: 7,
                                )
                              : const SizedBox.shrink(),
                          propertiesButton.icon != null
                              ? const Gap(4)
                              : const Gap(0),
                          propertiesButton.icon != null
                              ? const Gap(4)
                              : const Gap(0),
                          CustomText(
                            title: propertiesButton.title,
                            color: propertiesButton.titleColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        )
      ],
    ),
  );
}
