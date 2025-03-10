import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Model/all_properties_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/Utils/thumbnail_tile.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/price_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget videoTile(
  BuildContext context, {
  required Property videoModel,
}) {
  return SizedBox(
    height: context.getSize.height * 0.30,
    width: double.infinity,
    child: Stack(
      fit: StackFit.loose,
      alignment: Alignment.topCenter,
      children: [
        Container(
            width: context.getSize.width,
            // alignment: Alignment.center,
            height: context.getSize.height * 0.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: videoModel.video != null
                    ? null
                    : DecorationImage(
                        image: NetworkImage(
                            videoModel.imageUrl ?? Constant.dummyImage),
                        fit: BoxFit.cover)),
            child: videoModel.video == null
                ? null
                : VideoThumbnailTile(
                    videoUrl: videoModel.video ?? '',
                  )),
        Padding(
          padding: EdgeInsets.only(top: context.getSize.width * 0.32),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.010,
                vertical: context.getSize.height * 0.005),
            margin: EdgeInsets.only(
                left: context.getSize.width * 0.020,
                right: context.getSize.width * 0.020),
            // height: context.getSize.height * 0.135,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [boxShadow()]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    scrollableText(
                        context: context,
                        textStyle: textStyle(
                            context: context,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackColor),
                        title: videoModel.title ?? ''),
                    appText(
                        title: videoModel.price.isNum
                            ? double.parse(videoModel.price).formatPrice()
                            : videoModel.price.toString(),
                        context: context,
                        fontSize: 10,
                        color: AppColor.greenColor,
                        fontWeight: FontWeight.w700,
                        colorOpecity: 0.8)
                  ],
                ),
                getHeight(context, 0.006),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Ionicons.location,
                      color: AppColor.buttonColor,
                      size: context.getSize.width * 0.030,
                    ),
                    scrollableText(
                        context: context,
                        textStyle: textStyle(
                            context: context,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor.withOpacity(0.8)),
                        title: videoModel.address ?? ''),
                  ],
                ),
                getHeight(context, 0.0072),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: List.generate(
                //       videoModel.features.length,
                //       (index) => Row(
                //             children: [
                //               Icon(
                //                 videoModel.features[index].icon,
                //                 size: context.getSize.width * 0.040,
                //               ),
                //               getWidth(context, 0.005),
                //               appText(
                //                   title: videoModel.features[index].quantity,
                //                   context: context,
                //                   fontSize: 8.852,
                //                   fontWeight: FontWeight.w400)
                //             ],
                //           )),
                // ),
                // getHeight(context, 0.005),
                SizedBox(
                  height: context.getSize.height * 0.03,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.detailView,
                          arguments: videoModel.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: context.getSize.width * 0.010,
                          vertical: context.getSize.height * 0.003),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColor.buttonColor,
                      ),
                      child: appText(
                          title: context.local.viewDetail,
                          context: context,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          colorOpecity: 0.9),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
