import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Monetization/View/component/linear_progress_bar.dart';
import 'package:propertier/App/Monetization/ViewModel/monetization_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

class MonetizationView extends StatelessWidget {
  MonetizationView({super.key});
  final viewModel = Get.find<MonetizationViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                title: 'Monetization'),
            getHeight(context, 0.2),
            appText(
                title: 'Followers',
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                colorOpecity: 0.8),
            getHeight(context, 0.01),
            CustomPaint(
              size: Size(context.getSize.width, 6),
              painter: LinearProgressBarPainter(
                  value: 600 / 1000, color: AppColor.buttonColor),
            ),
            getHeight(context, 0.005),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        style: textStyle(
                            context: context,
                            color: AppColor.primaryColor.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        text: '600',
                        children: [
                      TextSpan(
                        style: textStyle(
                            context: context,
                            color: AppColor.primaryColor.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        text: ' Followers',
                      )
                    ])),
                appText(
                  title: '1 K',
                  context: context,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  colorOpecity: 0.6,
                )
              ],
            ),
            getHeight(context, 0.030),
            appText(
                title: 'Watch Time',
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                colorOpecity: 0.8),
            getHeight(context, 0.01),
            CustomPaint(
              size: Size(context.getSize.width, 6),
              painter: LinearProgressBarPainter(
                  value: viewModel.convertDaysToFractionOfYear(189),
                  color: AppColor.lightBlueColor),
            ),
            getHeight(context, 0.005),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                  style: textStyle(
                      context: context,
                      color: AppColor.primaryColor.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  text: '189',
                )),
                appText(
                  title: '365 Days',
                  context: context,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  colorOpecity: 0.6,
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
