import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget rewardsAndAppricationTile(
    BuildContext context, ProfileViewModel viewModel) {
  return Obx(() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText(
                  title: "Awards",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  context: context),
              getHeight(context, 0.008),
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.addAward),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_circle,
                    color: AppColor.buttonColor,
                  ),
                ),
              )
            ],
          ),
          viewModel.profileModel.value.awards != null &&
                  viewModel.profileModel.value.awards!.isNotEmpty
              ? SizedBox(
                  width: context.getSize.width,
                  height: context.getSize.height / 3,
                  child: ListView.builder(
                    // reverse: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.profileModel.value.awards != null &&
                            viewModel.profileModel.value.awards!.isNotEmpty
                        ? viewModel.profileModel.value.awards!.length
                        : null,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 5.0, bottom: 5, top: 5, left: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            appText(
                                title: viewModel
                                    .profileModel.value.awards![index].title!,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                context: context),
                            getHeight(context, 0.008),
                            InstaImageViewer(
                              imageUrl: viewModel.profileModel.value
                                          .awards![index].image !=
                                      null
                                  ? viewModel
                                      .profileModel.value.awards![index].image!
                                  : Constant.dummayImage,
                              child: Container(
                                height: 225,
                                width: context.getSize.width * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(viewModel
                                                    .profileModel
                                                    .value
                                                    .awards![index]
                                                    .image !=
                                                null
                                            ? viewModel.profileModel.value
                                                .awards![index].image!
                                            : Constant.dummayImage),
                                        fit: BoxFit.cover)),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ))
              : appText(title: "No Awards", context: context),
        ],
      ));
}
