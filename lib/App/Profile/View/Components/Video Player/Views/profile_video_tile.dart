import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:propertier/App/Home/Model/home_model.dart';
import 'package:propertier/App/Home/View/home_view.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../../../Model/property.dart';
import '../../../../../../Utils/thumbnail_tile.dart';

// ignore: must_be_immutable
class ProfileVideosTile extends StatelessWidget {
  // ProfileViewModel viewModel;
  List<Property> listOfProperties;
  // User user;
  ProfileVideosTile({
    super.key,
    required this.listOfProperties,
  });
  @override
  Widget build(BuildContext context) {
    return listOfProperties.isEmpty
        ?  Text(context.local.no_data)
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: context.local.videos,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.profilePropertyListingView,
                          arguments: {
                            "PropertyEnum": PropertiesAndVideoEnum.video,
                            "PropertiesType":
                                listOfProperties.first.agent!.id.toString()
                          });
                    },
                    child: CustomText(
                      title: context.local.view_more,
                      color: AppColor.greenColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              getHeight(context, 0.011),
              listOfProperties.isEmpty
                  ? Text(context.local.no_data)
                  : SizedBox(
                      height: 150,
                      width: context.getSize.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          cacheExtent: 500000,
                          padding: const EdgeInsets.all(0),
                          physics: const BouncingScrollPhysics(),
                          itemCount: listOfProperties.isNotEmpty
                              ? listOfProperties.length <= 5
                                  ? listOfProperties.length
                                  : 5
                              : 0,
                          itemBuilder: (context, index) {
                            Property property = listOfProperties[index];
                            return property.video == null
                                ? const SizedBox.shrink()
                                :
                            GestureDetector(
                                    onTap: () {
                                      // Get.toNamed(AppRoutes.playerView,
                                      //     arguments: property.video);
                                    },
                                    child: VideoThumbnailTile(
                                      videoUrl: property.video!,
                                    ),
                                  );
                            // });
                          }),
                    )
            ],
          );
  }
}
