import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/App/Profile/View/component/about_tile.dart';
import 'package:propertier/App/Profile/View/component/appbar.dart';
import 'package:propertier/App/Profile/View/component/profile_info_tile.dart';
import 'package:propertier/App/Profile/View/component/profile_post_tile.dart';
import 'package:propertier/App/Profile/View/component/rewards_and_apprication_tile.dart';
import 'package:propertier/App/Profile/View/component/short_video_tile.dart';
// import 'package:propertier/App/Profile/View/component/video_tile.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/app_text.dart';
import '../../Home/View/home_view.dart';
import 'Components/properties_tile.dart';
import 'Components/Video Player/Views/profile_video_tile.dart';

class ProfileStatusView extends StatelessWidget {
  ProfileStatusView({super.key});
  final viewModel = Get.put(ProfileViewModel());

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //       statusBarColor: Colors.transparent,
    //       statusBarIconBrightness: Brightness.dark,
    //       systemNavigationBarIconBrightness: Brightness.dark,
    //       systemNavigationBarColor: AppColor.backgroundColor),
    // );
    viewModel.getProfilePageData(
        context: context, id: GetStorage().read("id").toString());
    return Obx(
      () => viewModel.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.buttonColor,
              ),
            )
          : viewModel.profileModel.value.userProfile == null
              ? Center(
                  child: InkWell(
                      onTap: () {
                        viewModel.getProfilePageData(
                            context: context,
                            id: GetStorage().read("id").toString());
                      },
                      child: appText(title: "No User Found", context: context)))
              : Scaffold(
                  appBar: profileAppBar(context, viewModel),
                  body: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getSize.width * 0.036),
                    children: [
                      getHeight(
                        context,
                        0.008,
                      ),
                      aboutTile(
                          context,
                          viewModel.profileModel.value.properties != null
                              ? viewModel
                                      .profileModel.value.userProfile!.about ??
                                  ""
                              : ""),
                      getHeight(context, 0.015),
                      rewardsAndAppricationTile(context, viewModel),
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
                                        PoropertiesAndVideoEnum.properties,
                                    "PropertiesType":
                                        GetStorage().read("id").toString()
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
                ),
    );
  }

  SizedBox propertiesListView(BuildContext context) {
    return SizedBox(
      height: context.getSize.height * 0.4,
      width: context.getSize.width,
      child: ListView.builder(
        // reverse: true,
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
