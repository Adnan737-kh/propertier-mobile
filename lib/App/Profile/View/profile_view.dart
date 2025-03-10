import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Profile/View/component/about_tile.dart';
import 'package:propertier/App/Profile/View/component/appbar.dart';
import 'package:propertier/App/Profile/View/component/profile_info_tile.dart';
import 'package:propertier/App/Profile/View/component/profile_post_tile.dart';
import 'package:propertier/App/Profile/View/component/rewards_and_apprication_tile.dart';
import 'package:propertier/App/Profile/View/component/short_video_tile.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/app_text.dart';
import '../../Drawer/View/drawer.dart';
import '../../Home/View/home_view.dart';
import 'Components/properties_tile.dart';
import 'Components/Video Player/Views/profile_video_tile.dart';

class ProfileStatusView extends StatelessWidget {
  ProfileStatusView({super.key});
  final viewModel = Get.put(ProfileViewModel());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        if (viewModel.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.buttonColor,
            ),
          );
        } else if (viewModel.profileModel.value.userProfile == null ||
        viewModel.profileModel.value.userProfile!.id == null ){
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Get.offAllNamed(AppRoutes.loginView);
          // });
          return const SizedBox();
        } else {
          return Scaffold(
            key: _scaffoldKey,
            appBar: profileAppBar(context, viewModel, _scaffoldKey),
            drawer: customDrawer(context: context),
            body: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.036),
              children: [
                getHeight(context, 0.008),
                aboutTile(
                    context,
                    viewModel.profileModel.value.properties != null
                        ? viewModel
                        .profileModel.value.userProfile!.about ??
                        ""
                        : ""),
                getHeight(context, 0.015),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      // boxShadow(),
                    ],
                  ),
                  child: Column(
                    children: [
                      features(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.selectFeaturedtype);
                            },
                            child: appText(
                                fontSize: 18,
                                color: AppColor.facebookColor,
                                title: "Click here",
                                context: context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                rewardsAndAppreciationTile(context, viewModel),
                getHeight(context, 0.015),
                profileInformationTile(
                    context, viewModel.profileModel.value.userProfile!),
                getHeight(context, 0.015),
                Row(
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
                        Get.toNamed(AppRoutes.profilePropertyListingView,
                            arguments: {
                              "PropertyEnum":
                              PropertiesAndVideoEnum.properties,
                              "PropertiesType": viewModel.userID
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
                getHeight(context, 0.015),
                propertiesListView(context),
                getHeight(context, 0.015),
                ProfilePostsTile(viewModel: viewModel),
                getHeight(context, 0.015),
                ProfileShortVideosTile(
                    listOfProperties:
                    viewModel.profileModel.value.userProfile == null
                        ? []
                        : viewModel.profileModel.value.properties!),
                getHeight(context, 0.015),
                ProfileVideosTile(
                  listOfProperties:
                  viewModel.profileModel.value.properties == null
                      ? []
                      : viewModel.profileModel.value.properties!,
                ),
                getHeight(context, 0.12),
              ],
            ),
          );
        }
      },
    );

    // return Obx(
    //   () => viewModel.isLoading.value
    //       ? const Center(
    //           child: CircularProgressIndicator(
    //             color: AppColor.buttonColor,
    //           ),
    //         )
    //       : viewModel.profileModel.value.userProfile == null
    //           ? Scaffold(
    //               body: Center(
    //                   child: InkWell(
    //                       onTap: () {
    //                         viewModel.getProfilePageData(
    //                             context: context,
    //                             id: GetStorage().read("id").toString());
    //                       },
    //                       child: appText(
    //                           title: "No User Found", context: context))),
    //             )
    //           : Scaffold(
    //               key: _scaffoldKey,
    //               appBar: profileAppBar(context, viewModel, _scaffoldKey),
    //               drawer: customDrawer(context: context),
    //               body: ListView(
    //                 shrinkWrap: true,
    //                 physics: const BouncingScrollPhysics(),
    //                 padding: EdgeInsets.symmetric(
    //                     horizontal: context.getSize.width * 0.036),
    //                 children: [
    //                   getHeight(context, 0.008),
    //                   aboutTile(
    //                       context,
    //                       viewModel.profileModel.value.properties != null
    //                           ? viewModel
    //                                   .profileModel.value.userProfile!.about ??
    //                               ""
    //                           : ""),
    //                   getHeight(context, 0.015),
    //                   Container(
    //                     padding: const EdgeInsets.all(16),
    //                     margin: const EdgeInsets.symmetric(vertical: 10),
    //                     decoration: BoxDecoration(
    //                       color: AppColor.white,
    //                       borderRadius: BorderRadius.circular(10),
    //                       boxShadow: const [
    //                         // boxShadow(),
    //                       ],
    //                     ),
    //                     child: Column(
    //                       children: [
    //                         features(context),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.end,
    //                           children: [
    //                             InkWell(
    //                               onTap: () {
    //                                 Get.toNamed(AppRoutes.selectFeaturedtype);
    //                               },
    //                               child: appText(
    //                                   fontSize: 18,
    //                                   color: AppColor.facebookColor,
    //                                   title: "Click here",
    //                                   context: context),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   rewardsAndAppricationTile(context, viewModel),
    //                   getHeight(context, 0.015),
    //                   profileInformationTile(
    //                       context, viewModel.profileModel.value.userProfile!),
    //                   getHeight(context, 0.015),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       appText(
    //                         title: context.local.properties,
    //                         context: context,
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                       GestureDetector(
    //                         onTap: () {
    //                           Get.toNamed(AppRoutes.profilePropertyListingView,
    //                               arguments: {
    //                                 "PropertyEnum":
    //                                     PropertiesAndVideoEnum.properties,
    //                                 "PropertiesType":
    //                                     GetStorage().read("id").toString()
    //                               });
    //                         },
    //                         child: appText(
    //                           title: context.local.viewMore,
    //                           context: context,
    //                           color: AppColor.greenColor,
    //                           fontSize: 14,
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   getHeight(context, 0.015),
    //                   propertiesListView(context),
    //                   getHeight(context, 0.015),
    //                   ProfilePostsTile(viewModel: viewModel),
    //                   getHeight(context, 0.015),
    //                   ProfileShortVideosTile(
    //                       listOfProperties:
    //                           viewModel.profileModel.value.userProfile == null
    //                               ? []
    //                               : viewModel.profileModel.value.properties!),
    //                   getHeight(context, 0.015),
    //                   ProfileVideosTile(
    //                     listOfProperties:
    //                         viewModel.profileModel.value.properties == null
    //                             ? []
    //                             : viewModel.profileModel.value.properties!,
    //                   ),
    //                   getHeight(context, 0.12),
    //                 ],
    //               ),
    //             ),
    // );
  }

  Column features(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText(
            title: "Get your Ad Featured:",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            context: context),
        radioFeatureButtons(
          context,
          "Reach up to 10x more buyers.",
          true,
          (p0) {
            // controller.onChangeTenXMoreBuyers(p0!);
          },
        ),
        radioFeatureButtons(
          context,
          "Show your Ad in top position.",
          true,
          (p0) {
            // controller.onChangeAdOnTopPostion(p0!);
          },
        ),
        radioFeatureButtons(
          context,
          "Get noticed with a Feature Ad tag.",
          true,
          (p0) {
            // controller.onChangeFeatureAdTag(p0!);
          },
        ),
      ],
    );
  }

  Row radioFeatureButtons(BuildContext context, String title, bool isSelect,
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
        appText(
            title: title, fontSize: 14, context: context, colorOpecity: 0.6),
      ],
    );
  }

  SizedBox propertiesListView(BuildContext context) {
    return SizedBox(
      height: 380,
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
          return propertiesTile(context,
              viewModel: viewModel,
              property: viewModel.profileModel.value.properties![index]);
        },
      ),
    );
  }

}
