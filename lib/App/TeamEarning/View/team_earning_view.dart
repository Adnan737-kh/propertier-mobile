import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/About/View/about_view.dart';
import 'package:propertier/App/TeamEarning/View/component/lost_and_gain_indicator.dart';
import 'package:propertier/App/TeamEarning/View/component/team_earning_circular_progress_indicator.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

import 'package:propertier/extensions/size_extension.dart';

class TeamEarningView extends StatelessWidget {
  const TeamEarningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          children: [
            SizedBox(
              height: context.getSize.height * 0.04,
            ),
            customAppBar(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                context: context,
                onTap: () {
                  Get.back();
                },
                title: context.local.team_earning),
            Expanded(
                child: Column(
              children: [
                getHeight(context, 0.15),
                CustomPaint(
                    painter: TeamEarningCircularProgressPainter(
                      innervalue: 100 / 100,
                      strokeWidth: 30,
                      color: AppColor.lightBlueColor,
                      value: 100 / 100,
                    ),
                    child: Container(
                      height: context.getSize.height * 0.25,
                      width: context.getSize.height * 0.25,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: CustomText(
                          title: context.local.criteria,
                          fontSize: 19,
                          colorOpecity: 0.6,
                          fontWeight: FontWeight.w600),
                    )),
                getHeight(context, 0.10),
                lostAndGainTile(context,
                    width: context.getSize.width,
                    color: AppColor.buttonColor,
                    title: "1 K",
                    subtitle: context.local.followers),
                getHeight(context, 0.002),
                lostAndGainTile(context,
                    width: context.getSize.width,
                    color: AppColor.lightBlueColor,
                    title: "65 K",
                    subtitle: context.local.time_watch),
                getHeight(context, 0.041),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPaint(
                        painter: LostAndGainCircularProgressPainter(
                            strokeWidth: 10,
                            color: AppColor.buttonColor,
                            value: 10 / 100),
                        child: Container(
                          alignment: Alignment.center,
                          height: context.getSize.height * 0.1,
                          width: context.getSize.height * 0.1,
                          child: CustomText(
                              title: context.local.all_time,
                              colorOpecity: 0.7,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        )),
                    getWidth(context, 0.050),
                    Column(
                      children: [
                        lostAndGainTile(context,
                            width: context.getSize.width * 0.5,
                            color: AppColor.lightBlueColor,
                            title: "1 K",
                            subtitle: context.local.followers_lost),
                        getHeight(context, 0.008),
                        lostAndGainTile(context,
                            width: context.getSize.width * 0.5,
                            color: AppColor.buttonColor,
                            title: "3 K",
                            subtitle: context.local.followers_gained),
                      ],
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      )),
    );
  }

  Container lostAndGainTile(BuildContext context,
      {required double width,
      required Color color,
      required String title,
      required String subtitle}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.white,
          border: border(),
          boxShadow: [boxShadow()]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: color,
            height: context.getSize.height * 0.008,
            width: context.getSize.height * 0.008,
          ),
          getWidth(context, 0.020),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                fontSize: 14,
                colorOpecity: 0.6,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                title: subtitle,
                fontSize: 16,
                colorOpecity: 0.7,
                fontWeight: FontWeight.w400,
              )
            ],
          )
        ],
      ),
    );
  }
}
