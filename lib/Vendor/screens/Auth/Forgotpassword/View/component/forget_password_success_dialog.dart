import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

forgetPasswordSuccessDialog({required BuildContext context}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.getSize.width * 0.040,
              vertical: context.getSize.height * 0.020),
          height: context.getSize.height * 0.3,
          width: context.getSize.width * 0.8,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(28)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.2,
                ),
                child: Image.asset(Constant.appLogo),
              ),
              getHeight(context, 0.020),
              CustomText(
                  fontWeight: FontWeight.w700,
                  title: 'Password change successfully.',
                  fontSize: 16),
              getHeight(context, 0.01),
              CustomText(
                textAlign: TextAlign.left,
                title:
                    'You can recieved your new password at your email with in 2 to 3 minutes.You can change your new password from "Edit" section of your profile.',
              ),
              getHeight(context, 0.01),
              textButton(
                  context: context,
                  title: 'Close',
                  onClick: () {
                    Get.offAllNamed(AppRoutes.loginView);
                  })
            ],
          ),
        ),
      );
    },
  );
}
