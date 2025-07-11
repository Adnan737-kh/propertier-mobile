import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

Container customShareAndBuyTile(BuildContext context,
    {required VoidCallback onShareCallBack}) {
  return Container(
    // constraints: BoxConstraints(maxHeight: context.getSize.height * 0.45),
    decoration: BoxDecoration(
        border: border(),
        color: AppColor.white,
        boxShadow: [boxShadow()],
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.topRight,
          height: context.getSize.height * 0.2,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(Constant.dummyImage), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: GestureDetector(
            onTap: onShareCallBack,
            child: const Icon(
              Icons.share,
              color: AppColor.white,
            ),
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
                  onTap: () {
                    Get.toNamed(AppRoutes.saleDetailView);
                  },
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
