import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';


PreferredSize ServiceAppBar(BuildContext context, FixedServicesModel service) {
  return PreferredSize(
      preferredSize: Size(context.getSize.width, context.getSize.height * 3),
      child: FittedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                InstaImageViewer(
                  imageUrl:
                  service.imageUrls?.first??
                      Constant.dumyImage2,
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                        left: 36,
                        right: 36,
                        top: context.getSize.height * 0.050),
                    width: context.getSize.width,
                    height: context.getSize.height * 0.20,
                    decoration: BoxDecoration(
                      // border: Border.all(width: 5),
                        boxShadow: [boxShadow()],
                        image: service.imageUrls?.first == null
                            ? null
                            : DecorationImage(
                            image: NetworkImage(service.imageUrls?.first ??
                                Constant.dumyImage2),
                            fit: BoxFit.cover)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.share,
                            color: AppColor.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 36),
                  width: context.getSize.width,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      boxShadow: [boxShadow()],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  height: context.getSize.height * 0.12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          appText(
                              title: service.title ??"",
                              context: context,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          getWidth(context, 0.010),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.buttonColor),
                            child: Icon(
                              Icons.check,
                              size: context.getSize.width * 0.03,
                              color: AppColor.blackColor,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // appText(
                          //     title: '( Service Provider )',
                          //     fontSize: 10,
                          //     fontWeight: FontWeight.w600,
                          //     color: const Color(0xffB8B8B8),
                          //     context: context),
                          appText(
                              colorOpecity: 0.6,
                              title: service.service?.title??"",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              context: context),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          appText(
                            title: "Rs${service.fixedPrice??""}",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffB8B8B8),
                            context: context,
                          ),
                          RatingBarIndicator(
                            rating: 4,
                            unratedColor: AppColor.greenColor,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: context.getSize.width * 0.034,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          appText(
                              title: 'Likes',
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              colorOpecity: 0.6,
                              context: context),
                          appText(
                              color: const Color(0xffB8B8B8),
                              title: service.likes?.toString()??"",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              context: context),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: context.getSize.height * 0.14,
              right: context.getSize.width * 0.1,
              child: SizedBox(
                height: context.getSize.height * 0.090,
                width: context.getSize.width * 0.180,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    InstaImageViewer(
                      imageUrl: service.vendor?.profilePictureUrl??Constant.dumyImage2,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: AppColor.white),
                          shape: BoxShape.circle,
                          image:
                          service.vendor?.profilePictureUrl == null
                              ? null
                              : DecorationImage(
                              image: NetworkImage(service.vendor?.profilePictureUrl ?? Constant.dumyImage2
                                  ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.editProfileView);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: border(color: AppColor.white),
                            shape: BoxShape.circle,
                            color: Colors.blue),
                        child: Icon(
                          Icons.edit,
                          size: context.getSize.width * 0.020,
                          color: AppColor.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ));
}
