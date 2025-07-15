import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../ViewModel/service_provider_profile_viewmodel.dart';

Widget sPPrewardsAndAppricationTile(
    BuildContext context, ServiceProviderProfileViewModel viewModel) {
  return Obx(() => Column(
        children: [
          viewModel.serviceProviderProfileModel.value.properties != null &&
                  viewModel.serviceProviderProfileModel.value.awards!.isNotEmpty
              ? SizedBox(
                  width: context.getSize.width,
                  height: context.getSize.height / 3,
                  child: ListView.builder(
                    // reverse: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.serviceProviderProfileModel.value
                                    .properties !=
                                null &&
                            viewModel.serviceProviderProfileModel.value.awards!
                                .isNotEmpty
                        ? viewModel
                            .serviceProviderProfileModel.value.awards!.length
                        : null,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 5.0, bottom: 5, top: 5, left: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                                title: viewModel.serviceProviderProfileModel
                                    .value.awards![index].title!,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                 ),
                            getHeight(context, 0.008),
                            InstaImageViewer(
                              imageUrl: viewModel.serviceProviderProfileModel
                                          .value.awards![index].image !=
                                      null
                                  ? viewModel.serviceProviderProfileModel.value
                                      .awards![index].image!
                                  : Constant.dummyImage,
                              child: Container(
                                height: 225,
                                width: context.getSize.width * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(viewModel
                                                    .serviceProviderProfileModel
                                                    .value
                                                    .awards![index]
                                                    .image !=
                                                null
                                            ? viewModel
                                                .serviceProviderProfileModel
                                                .value
                                                .awards![index]
                                                .image!
                                            : Constant.dummyImage),
                                        fit: BoxFit.cover)),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ))
              : const CustomText(title: "No Awards",),
        ],
      ));
}
