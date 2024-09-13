import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Home/Model/properties_tiler_button_model.dart';
import 'package:propertier/App/Home/View/home_view.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/price_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Model/property.dart';
import '../../../../extensions/ago_time_converter.dart';

// ignore: must_be_immutable
class Properties extends StatelessWidget {
  List<Property> propertyList;
  HomeViewModel viewModel;
  Properties({super.key, required this.propertyList, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    List<Property> property = [];
    if (viewModel.isSale.value == true) {
      property = propertyList
          .where((element) => element.purpose!.toLowerCase() == "sale")
          .toList();
    } else {
      property = propertyList
          .where((element) => element.purpose!.toLowerCase() == "rent")
          .toList();
    }
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.getSize.width * 0.036),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText(
                title: context.local.properties,
                context: context,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.propertiesAndVideoView, arguments: {
                    "PropertyEnum": PoropertiesAndVideoEnum.properties,
                    "PropertiesType": ""
                  });
                },
                child: appText(
                  title: context.local.viewMore,
                  context: context,
                  color: AppColor.greenColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        getHeight(context, 0.011),
        SizedBox(
          height: sizeHeight(0.37, 0.34),
          width: context.getSize.width,
          child: property.isEmpty
              ? Center(
                  child: appText(title: 'No Data Avaliable', context: context),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getSize.width * 0.036),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: property.isNotEmpty
                      ? property.length <= 5
                          ? property.length
                          : 5
                      : 0,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(3),
                      margin: EdgeInsets.only(
                          left: 2,
                          right: context.getSize.width * 0.015,
                          top: 5,
                          bottom: 5),
                      width: context.isPhone ? 200 : 250,
                      height: sizeHeight(0.38, 0.34),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          border: border(),
                          boxShadow: [
                            boxShadow(),
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        // mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.detailView, arguments: {
                                "id": viewModel.homeModel.value.data!
                                    .properties[index].id!,
                                "user": "null"
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.getSize.width * 0.020,
                                  vertical: context.getSize.height * 0.01),
                              alignment: Alignment.topRight,
                              height: context.getSize.height * 0.190,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          property[index].image ??
                                              Constant.dummayImage),
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
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              bottom: 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    appText(
                                        title: getTimeAgo(
                                            property[index].createdAt!),
                                        context: context,
                                        colorOpecity: 0.7,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                    appText(
                                        title: 'Residential',
                                        context: context,
                                        colorOpecity: 0.7,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                                getHeight(context, 0.008),
                                appText(
                                    textAlign: TextAlign.left,
                                    title: property[index].title!,
                                    context: context,
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
                                        text:
                                            double.parse(property[index].price!)
                                                .formatPrice(),
                                        style: textStyle(
                                            context: context, fontSize: 10)),
                                  ]),
                                ),
                                getHeight(context, 0.008),
                                appText(
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    title: property[index].address!,
                                    context: context,
                                    colorOpecity: 0.7,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                                getHeight(context, 0.008),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          Constant.marla,
                                          width: context.getSize.width * 0.050,
                                          height: context.getSize.height * 0.02,
                                        ),
                                        appText(
                                            title:
                                                " ${(property[index].area! / 250).toString()} Marla",
                                            context: context,
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
                                        appText(
                                            fontSize: 10,
                                            colorOpecity: 0.60,
                                            title: property[index]
                                                .likes!
                                                .toString(),
                                            context: context),
                                      ],
                                    ),
                                  ],
                                ),
                                getHeight(context, 0.008),
                                // Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      viewModel.propertiesTileButtonList.length,
                                      (i) {
                                    PropertiesTileButtonModel propertiesButton =
                                        viewModel.propertiesTileButtonList[i];
                                    return GestureDetector(
                                      onTap: () {
                                        propertiesButton.onTap(property[index]
                                                    .agent !=
                                                null
                                            ? property[index]
                                                    .agent!
                                                    .phoneNumberCountryCode! +
                                                property[index]
                                                    .agent!
                                                    .phoneNumber!
                                            : '');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: propertiesButton.color,
                                            border: Border.all(
                                              color:
                                                  propertiesButton.borderColor,
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            propertiesButton.icon != null
                                                ? Icon(
                                                    propertiesButton.icon,
                                                    color: propertiesButton
                                                        .titleColor,
                                                    size: 7,
                                                  )
                                                : const SizedBox.shrink(),
                                            propertiesButton.icon != null
                                                ? const Gap(4)
                                                : const Gap(0),
                                            propertiesButton.icon != null
                                                ? const Gap(4)
                                                : const Gap(0),
                                            appText(
                                              title: propertiesButton.title,
                                              context: context,
                                              color:
                                                  propertiesButton.titleColor,
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
                  }),
        )
      ],
    );
  }
}
