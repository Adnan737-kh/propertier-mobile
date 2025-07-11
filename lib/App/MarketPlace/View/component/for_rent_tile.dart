import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/font_size_extension.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:text_scroll/text_scroll.dart';

class ForRentTile extends StatelessWidget {
  const ForRentTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getSize.height * 0.535,
      decoration: BoxDecoration(
          boxShadow: [boxShadow()],
          borderRadius: BorderRadius.circular(10),
          color: AppColor.white),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: context.getSize.height * 0.37,
            width: context.getSize.width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(Constant.dummyImage),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: context.getSize.height * 0.030,
                          width: context.getSize.height * 0.030,
                          decoration: BoxDecoration(
                              border: border(
                                color: AppColor.buttonColor,
                              ),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  image: NetworkImage(
                                    Constant.dummyImage,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        getWidth(context, 0.020),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: context.getSize.width * 0.55,
                              child: TextScroll(
                                'AS Real Estates PVT LTD',
                                mode: TextScrollMode.bouncing,
                                velocity: const Velocity(
                                    pixelsPerSecond: Offset(150, 0)),
                                delayBefore: const Duration(milliseconds: 500),
                                numberOfReps: 5,
                                pauseBetween: const Duration(milliseconds: 50),
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: context.fontSize(14),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Rubik'),
                                textAlign: TextAlign.right,
                                selectable: true,
                              ),
                            ),
                            CustomText(
                                title: context.local.residential,
                                color: AppColor.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        Constant.share,
                        height: context.getSize.height * 0.023,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: context.getSize.height * 0.060,
                ).paddingOnly(bottom: context.getSize.height * 0.030),
                // getHeight(context, context.getSize.height * 0.0030),
                Flexible(
                  // color: Colors.red,
                  // height: 100,
                  child: Wrap(
                    // spacing: context.getSize.width * 0.088,
                    runSpacing: context.getSize.height * 0.010,
                    // maxCrossAxisExtent: 3,
                    children: List.generate(
                        9,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    index == 9 - 1
                                        ? Icons.location_city
                                        : Icons.home,
                                    color: AppColor.white,
                                    size: context.getSize.height * 0.030,
                                  ),
                                  getWidth(context, 0.024),
                                  CustomText(
                                    title: index == 9 - 1 ? 'ISB' : '1',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.white,
                                  )
                                ],
                              ),
                            )),
                  ),
                )
              ],
            ),
          ),
          getHeight(context, 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      title: '-05:35:10',
                      fontSize: 8,
                      colorOpecity: 0.7,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      title: context.local.residential,
                      fontSize: 8,
                      colorOpecity: 0.7,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                getHeight(context, 0.015),
                CustomText(
                  textAlign: TextAlign.start,
                  title: context.local.house_for_sale,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                getHeight(context, 0.008),
                const CustomText(
                  textAlign: TextAlign.start,
                  title: 'PKR 1.7 Crore',
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
                getHeight(context, 0.008),
                const CustomText(
                  textAlign: TextAlign.start,
                  title: 'Bahria Town Phase 7 islamabad',
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
                getHeight(context, 0.008),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          Constant.marla,
                          width: context.getSize.width * 0.030,
                          height: context.getSize.height * 0.01,
                        ),
                        const CustomText(
                            title: ' 5 Marla',
                            colorOpecity: 1,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                    const Icon(
                      Ionicons.heart_outline,
                      size: 12,
                    ),
                  ],
                ),
                getHeight(context, 0.008),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          Constant.bid,
                          width: context.getSize.width * 0.030,
                          height: context.getSize.height * 0.01,
                        ),
                        CustomText(
                            title: context.local.last_bids,
                            colorOpecity: 1,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                    const CustomText(
                        title: '1.7 Crore',
                        colorOpecity: 1,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                getHeight(context, 0.005),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {},
                    child: CustomText(
                        color: AppColor.greenColor,
                        title: context.local.view_details,
                        colorOpecity: 1,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
