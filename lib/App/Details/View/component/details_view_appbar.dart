import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:propertier/App/Details/ViewModel/properties_detail_view_model.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget detailsAppBar(
  BuildContext context, {
  // required VideoDetailModel detail,
  required DetailsViewModel viewModel,
  // required VoidCallback playCallBack,
  required VoidCallback favoriteCallBack,
}) {
  return InstaImageViewer(
    imageUrl: viewModel.specificPropertyModel.value.detailDataModel!
            .galleryImages.isNotEmpty
        ? viewModel.specificPropertyModel.value.detailDataModel!
            .galleryImages[viewModel.selectedVideoIndex].imageUrl
        : Constant.dummayImage,
    child: Container(
        padding: EdgeInsets.only(
            left: context.getSize.width * 0.090,
            right: context.getSize.width * 0.090,
            top: context.getSize.height * 0.060,
            bottom: context.getSize.height * 0.012),
        height: context.getSize.height * 0.36,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [boxShadow(blurRadius: 10)],
            color: AppColor.blackColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            image: viewModel.specificPropertyModel.value.detailDataModel!
                    .galleryImages.isEmpty
                ? null
                : DecorationImage(
                    image: NetworkImage(viewModel
                        .specificPropertyModel
                        .value
                        .detailDataModel!
                        .galleryImages[viewModel.selectedVideoIndex]
                        .imageUrl),
                    fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.white,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      size: context.isPhone ? 30 : 40,
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.share,
                        size: context.isPhone ? 30 : 40,
                        color: AppColor.white,
                      ),
                    ),
                    getWidth(context, 0.020),
                    GestureDetector(
                      onTap: favoriteCallBack,
                      child: SvgPicture.asset(Constant.heartunFill),
                    )
                  ],
                ),
              ],
            ),
            // Icon(
            //   Icons.play_arrow,
            //   color: AppColor.white,
            //   size: context.getSize.height * 0.050,
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    viewModel.specificPropertyModel.value.detailDataModel!
                        .galleryImages.length,
                    (index) => GestureDetector(
                          onTap: () {
                            viewModel.changeVideoIndex(index);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: context.getSize.width * 0.012),
                            height: context.getSize.height * 0.050,
                            width: context.getSize.width * 0.100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(viewModel
                                        .specificPropertyModel
                                        .value
                                        .detailDataModel!
                                        .galleryImages[index]
                                        .imageUrl),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(5),
                                border: border(
                                    width: 2,
                                    color: viewModel.selectedVideoIndex == index
                                        ? AppColor.buttonColor
                                        : AppColor.white),
                                color: AppColor.blackColor),
                          ),
                        )),
              ),
            )
          ],
        )),
  );
}
