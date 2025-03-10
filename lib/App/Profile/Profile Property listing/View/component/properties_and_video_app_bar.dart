import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Home/View/home_view.dart';
import 'package:propertier/Utils/animated_toggle.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/bottom_sheet.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../ViewModel/profile_property_listing_view_model.dart';
import 'properties_search_tile.dart';

class PropertiesAndVideosAppBar extends StatelessWidget {
  final PropertiesAndVideoEnum poropertiesAndShortVideoEnum;
  // final HomeViewModel homeViewModel;

  const PropertiesAndVideosAppBar({
    super.key,
    required this.poropertiesAndShortVideoEnum,
    required this.viewModel,
    // required this.homeViewModel,
  });

  final ProfilePropertyListingViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // List<ServicesModel> tabList =
    //     poropertiesAndShortVideoEnum == PoropertiesAndVideoEnum.properties
    //         ? viewModel.tabListShortVideo
    //         : poropertiesAndShortVideoEnum == PoropertiesAndVideoEnum.topselling
    //             ? viewModel.tabListtopSelling
    //             : poropertiesAndShortVideoEnum == PoropertiesAndVideoEnum.video
    //                 ? viewModel.tabListShortVideo
    //                 : [];
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(vertical: context.getSize.height * 0.010),
        decoration: BoxDecoration(
            color: const Color(0xffFBFBFB),
            border: Border.all(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            boxShadow: [boxShadow()],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Column(
          children: [
            getHeight(context, 0.05),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.090,
              ),
              // color: AppColor.buttonColor.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          Constant.backArrow,
                          width: context.getSize.height * 0.016,
                          height: context.getSize.height * 0.016,
                        ),
                      ),
                      getWidth(context, 0.1 - 0.016)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      appText(
                          title: context.local.location,
                          context: context,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          colorOpecity: 0.6),
                      getHeight(context, 0.008),
                      GestureDetector(
                        onTap: () {
                          // showLocationBottomSheet(
                          //     selectedLocation: viewModel.currentLocation,
                          //     context: context,
                          //     dataList:
                          //         viewModel.allPropertiesModel.value.data !=
                          //                 null
                          //             ? viewModel
                          //                 .allPropertiesModel.value.data!.cities
                          //             : [],
                          //     onChange: (val) {
                          //       viewModel.onChangeLocation(val);
                          //       Get.back();
                          //     });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Ionicons.location,
                              size: context.getSize.width * 0.030,
                              color: AppColor.buttonColor,
                            ),
                            appText(
                                title: viewModel.currentLocation,
                                context: context,
                                fontSize: 14),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: context.getSize.width * 0.05,
                              color: AppColor.buttonColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  AnimatedToggle(
                      values: const ['Buy', 'Rent'],
                      onToggleCallback: (val) {
                        if (val == 1) {
                          viewModel.setPurpose("rent");
                        } else {
                          viewModel.setPurpose("sale");
                        }
                      })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.090,
              ),
              child: Column(
                children: [
                  getHeight(context, 0.012),
                  propertiesSearchTile(
                      filterCallBack: () {},
                      controller: viewModel.searchController,
                      context: context),
                  getHeight(context, 0.010),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      viewModel.setSelectTab("All Types");
                    },
                    child: Obx(() => Container(
                          margin: EdgeInsets.only(
                              right: context.getSize.width * 0.020),
                          padding: EdgeInsets.symmetric(
                              horizontal: context.getSize.width * 0.020,
                              vertical: context.getSize.height * 0.010),
                          decoration: BoxDecoration(
                              color: "All Types" == viewModel.selectedTab
                                  ? AppColor.buttonColor
                                  : AppColor.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppColor.blackColor.withOpacity(0.1),
                                width: 0.4,
                              )),
                          child: Row(
                            children: [
                              appText(
                                  title: "All Types",
                                  context: context,
                                  fontSize: 10,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.normal)
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(
                    height: 35,
                    width: context.getSize.width * 0.8,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: viewModel.listOfTab.length,
                      itemBuilder: (context, index) {
                        print("Get Group values $index");
                        return GestureDetector(
                          onTap: () {
                            viewModel.setSelectTab(viewModel.listOfTab[index]);
                          },
                          child: Obx(
                            () => Container(
                              margin: EdgeInsets.only(
                                  right: context.getSize.width * 0.020),
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.getSize.width * 0.020,
                                  vertical: context.getSize.height * 0.010),
                              decoration: BoxDecoration(
                                  color: viewModel.listOfTab[index] ==
                                          viewModel.selectedTab
                                      ? AppColor.buttonColor
                                      : AppColor.white,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: AppColor.blackColor.withOpacity(0.1),
                                    width: 0.4,
                                  )),
                              child: Row(
                                children: [
                                  appText(
                                      title: viewModel.listOfTab[index],
                                      context: context,
                                      fontSize: 12,
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.normal)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
