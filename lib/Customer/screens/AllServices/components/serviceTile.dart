import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../App/Services/Model/ServiceDashboardModel.dart';
import '../../../../App/What are you searching/View/Components/custom_botton_wryf.dart';
import '../../../../extensions/navigate_to_dailpad.dart';


Widget serviceTile(
    BuildContext context, {
      required SellingServices service,
    }) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColor.buttonColor.withOpacity(0.0),
    ),
    height: sizeHeight(0.33, 0.3),
    width: double.infinity,
    child: Stack(
      fit: StackFit.loose,
      alignment: Alignment.topCenter,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.ServiceDetail,
                arguments: service);
          },
          child: Container(
            height: sizeHeight(0.22, 0.18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(
                  service.imageUrls?.first ?? Constant.dummyImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: sizeWidth(0.35, 0.2)),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.getSize.width * 0.015,
              vertical: context.getSize.height * 0.010,
            ),
            margin: EdgeInsets.symmetric(horizontal: sizeWidth(0.020, 0.010)),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [boxShadow()],
            ),
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
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackColor,
                      ),
                      title: service.title ?? 'No Title',
                    ),
                    appText(
                      title: service.fixedPrice != null
                          ? "Rs ${service.fixedPrice!}"
                          : "Price Not Available",
                      context: context,
                      fontSize: 12,
                      color: AppColor.greenColor,
                      fontWeight: FontWeight.w700,
                      colorOpecity: 0.8,
                    ),
                  ],
                ),
                getHeight(context, 0.006),
                Row(
                  children: [
                    Icon(
                      Ionicons.location,
                      color: AppColor.buttonColor,
                      size: sizeWidth(0.030, 0.020),
                    ),
                    scrollableText(
                      context: context,
                      textStyle: textStyle(
                        context: context,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor.withOpacity(0.8),
                      ),
                      title: 'No Address',
                    ),
                    Spacer(),
                    appText(
                      title: '',
                      context: context,
                      fontSize: 12,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w500,
                      colorOpecity: 0.8,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    appText(
                      title: 'Added Recently',
                      context: context,
                      colorOpecity: 0.7,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                getHeight(context, 0.004),
                divider(context: context),
                getHeight(context, 0.01),
                Row(
                  children: [
                    getWidth(context, 0.020),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.nearesServiceDetail,
                              arguments: service);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(42),
                            color: AppColor.greenColor,
                          ),
                          child: appText(
                            color: AppColor.white,
                            title: 'Get Service',
                            context: context,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    getWidth(context, 0.020),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.ServiceDetail,
                              arguments: service);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.buttonColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(42),
                            color: AppColor.buttonColor,
                          ),
                          child: appText(
                            color: AppColor.blackColor,
                            title: 'Detail',
                            context: context,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
