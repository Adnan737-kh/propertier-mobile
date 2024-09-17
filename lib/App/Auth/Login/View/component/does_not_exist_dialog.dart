import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

doesNotExist({required BuildContext context, required String subtitle}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: context.getSize.height * 0.37,
          width: context.getSize.width * 0.8,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getSize.width * 0.040,
                      vertical: context.getSize.height * 0.020),
                  height: context.getSize.height * 0.3,
                  width: context.getSize.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Spacer(),
                      appText(
                          fontWeight: FontWeight.w600,
                          title: 'Oops !',
                          context: context,
                          color: const Color(0xffD13135),
                          fontSize: 17),
                      getHeight(context, 0.01),
                      appText(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff00060E),
                          title: subtitle,
                          context: context),
                      const Spacer(),
                      textButton(
                          context: context,
                          title: 'Try Again',
                          textFontSize: 20,
                          textColor: Colors.white,
                          buttonColor: const Color(0xffD13135),
                          onClick: () {
                            Get.back();
                          })
                    ],
                  ),
                ),
              ),
              Image.asset(
                Constant.closeLogin,
                height: context.getSize.height * 0.15,
                width: context.getSize.width * 0.3,
              )
            ],
          ),
        ),
      );
    },
  );
}
