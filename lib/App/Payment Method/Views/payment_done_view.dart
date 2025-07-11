import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/appbar.dart';
import '../../../Utils/height_width_box.dart';

class PaymentDoneView extends StatelessWidget {
  const PaymentDoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: SingleChildScrollView(
          child: Column(
            children: [
              getHeight(context, 0.050),
              customAppBar(
                context: context,
                title: "",
                onTap: () {
                  Get.back();
                },
              ),
              getHeight(context, 0.292),
              CustomText(
                  textAlign: TextAlign.start,
                  title: "✓",
                  fontSize: 120,
                  color: AppColor.buttonColor,
                  colorOpecity: 0.9),
              getHeight(context, 0.008),
              CustomText(
                  textAlign: TextAlign.start,
                  title: context.local.congratulation,
                  fontSize: 16,
                  colorOpecity: 0.6),
              getHeight(context, 0.008),
              CustomText(
                  textAlign: TextAlign.start,
                  title: context.local.your_amount_is_sended,
                  fontSize: 16,
                  colorOpecity: 0.6),
            ],
          ),
        ),
      ),
    ));
  }
}
