import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/app_text.dart';
import '../../../Utils/height_width_box.dart';
import '../../../constant/colors.dart';
import '../../Home/View/home_view.dart';
import '../../Profile/View/Components/Video Player/Views/profile_video_tile.dart';
import '../../Profile/View/component/about_tile.dart';
import '../../Profile/View/component/profile_info_tile.dart';
import '../../Profile/View/component/short_video_tile.dart';
import '../ViewModel/service_provider_profile_viewmodel.dart';
import 'Components/service_provider_profile_appbar.dart';
import 'Components/spp_properties_tile.dart';
import 'Components/spp_rewards_and_apprication_tile.dart';

class ServiceProviderProfile extends GetView<ServiceProviderProfileViewModel> {
  const ServiceProviderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.backgroundColor),
    );
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColor.buttonColor,
            ),
          )
        : Scaffold(
            appBar: serviceProviderProfileAppBar(context, controller),
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
                      controller.serviceProviderProfileModel.value
                                  .userProfile !=
                              null
                          ? controller.serviceProviderProfileModel.value
                                  .userProfile!.email ??
                              ""
                          : ""),
                  getHeight(context, 0.015),
                  sPPrewardsAndAppricationTile(context, controller),
                  getHeight(context, 0.015),
                  profileInformationTile(
                      context,
                      controller
                          .serviceProviderProfileModel.value.userProfile!),
                  getHeight(context, 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: context.local.properties,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.profilePropertyListingView,
                              arguments: {
                                "PropertyEnum":
                                    PropertiesAndVideoEnum.properties,
                                "PropertiesType": controller
                                    .serviceProviderProfileModel
                                    .value
                                    .userProfile!
                                    .id
                                    .toString()
                              });
                        },
                        child: CustomText(
                          title: context.local.view_more,
                          color: AppColor.greenColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  propertiesListView(context),
                  getHeight(context, 0.015),
                  getHeight(context, 0.015),
                  Obx(
                    () => ProfileShortVideosTile(
                        listOfProperties: controller.serviceProviderProfileModel
                                    .value.properties ==
                                null
                            ? []
                            : controller
                                .serviceProviderProfileModel.value.properties!),
                  ),
                  ProfileVideosTile(
                    listOfProperties: controller
                                .serviceProviderProfileModel.value.properties ==
                            null
                        ? []
                        : controller
                            .serviceProviderProfileModel.value.properties!,
                  ),
                  getHeight(context, 0.12),
                ]),
          ));
  }

  SizedBox propertiesListView(BuildContext context) {
    return SizedBox(
      height: context.getSize.height * 0.37,
      width: context.getSize.width,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount:
            controller.serviceProviderProfileModel.value.properties != null
                ? controller.serviceProviderProfileModel.value.properties!
                        .isNotEmpty
                    ? controller.serviceProviderProfileModel.value.properties!
                                .length <=
                            5
                        ? controller.serviceProviderProfileModel.value
                            .properties!.length
                        : 5
                    : 0
                : 0,
        itemBuilder: (context, index) {
          print(
              " property image ${controller.serviceProviderProfileModel.value.properties![index].image}");
          return propertiesTile(
              context: context,
              controller: controller,
              user: controller
                  .serviceProviderProfileModel.value.properties!.first.agent!,
              property: controller
                  .serviceProviderProfileModel.value.properties![index]);
        },
      ),
    );
  }
}
