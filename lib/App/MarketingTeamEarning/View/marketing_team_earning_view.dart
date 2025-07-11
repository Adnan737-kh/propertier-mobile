import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/MarketingTeamEarning/View/component/chart_bar.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/withdrawal_amount_tile.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class MarketingTeamEarningView extends StatelessWidget {
  const MarketingTeamEarningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          children: [
            getHeight(context, 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customAppBar(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    context: context,
                    title: 'Marketing Team Earnings',
                    onTap: () {
                      Get.back();
                    }),
                const Icon(Icons.calendar_month, color: Color(0xffACACAC))
              ],
            ),
            getHeight(context, 0.045),
            Container(
              padding: EdgeInsets.only(
                left: context.getSize.width * 0.026,
                right: context.getSize.width * 0.01,
                top: context.getSize.height * 0.007,
                bottom: context.getSize.height * 0.007,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: border(),
                  boxShadow: [boxShadow()]),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          title: context.local.weekly_earning,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          colorOpecity: 0.7),
                      const CustomText(
                          title: '23 K',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          colorOpecity: 0.6),
                      getHeight(context, 0.005),
                      SizedBox(
                        height: context.getSize.height * 0.12,
                        width: context.getSize.width * 0.6,
                        child: const Chart(),
                      )
                    ],
                  ),
                  getWidth(context, 0.010),
                  Container(
                    height: context.getSize.height * 0.15,
                    width: context.getSize.width * 0.22,
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        boxShadow: [boxShadow()],
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: NetworkImage(Constant.dummyImage),
                          fit: BoxFit.cover,
                        ),
                        border: border()),
                  )
                ],
              ),
            ),
            getHeight(context, 0.030),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    title: context.local.withdrawal_amount,
                    fontSize: 14,
                    colorOpecity: 0.6,
                    fontWeight: FontWeight.w500),
                Row(
                  children: List.generate(
                      2,
                      (index) => Container(
                            margin:
                                EdgeInsets.only(right: index == 2 - 1 ? 0 : 4),
                            height: context.getSize.height * 0.01,
                            width: context.getSize.height * 0.01,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff71757A)),
                          )),
                ),
              ],
            ),
            getHeight(context, 0.010),
            Column(
              children: List.generate(
                  2,
                  (index) => withdrawalTile(context,
                      bankName: 'Bank Alfalah',
                      date: '10 feb 2023',
                      ammount: "10K",
                      bankIcon: Constant.alfalah)),
            )
          ],
        ),
      )),
    );
  }
}
