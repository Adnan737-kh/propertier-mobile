import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Services/Model/services_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class ServicesCompletedView extends StatelessWidget {
  ServicesCompletedView({super.key});
  ServicesModel service = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.getSize.width * 0.090,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          getHeight(context, 0.2),
          Image.asset(
            Constant.orderComplete,
            height: context.getSize.height * 0.3,
            width: context.getSize.width * 0.5,
          ),
          getHeight(context, 0.015),
          SizedBox(
            width: context.getSize.width * 0.4,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                        "${context.local.orderCompleted}\n${context.local.pleasePay} ",
                    style: textStyle(
                        context: context,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: "PKR 40000\n",
                        style: textStyle(
                          context: context,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.buttonColor,
                        ),
                      ),
                      TextSpan(
                        text: "${context.local.to} Maryam Nawaz",
                        style: textStyle(
                          context: context,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ])),
          ),
          getHeight(context, 0.1),
          textButton(
              context: context,
              title: context.local.continues,
              onClick: () {
                Get.toNamed(AppRoutes.servicesReviewView);
              }),
        ],
      ),
    );
  }
}
