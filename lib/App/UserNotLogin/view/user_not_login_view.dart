import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

class UserNotLoginView extends StatelessWidget {
  const UserNotLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.getSize.width * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getHeight(context, 0.2),
            Container(
                height: context.getSize.height * 0.2,
                width: context.getSize.width * 0.4,
                decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: Image.asset(Constant.appLogo)),
            getHeight(context, 0.1),
            appText(
                title: 'Using more features kindly\nlogin first',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                context: context),
            getHeight(context, 0.05),
            textButton(
                textColor: AppColor.darkGreyColor.withOpacity(0.7),
                textFontSize: 20,
                height: 0.070,
                buttonColor: AppColor.white,
                context: context,
                title: 'Login',
                onClick: () {
                  Get.toNamed(AppRoutes.loginView);
                }),
            getHeight(context, 0.020),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  style: textStyle(
                    context: context,
                  ),
                  text: "Don't have an account?"),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(AppRoutes.signUpView);
                    },
                  style: textStyle(
                      context: context,
                      color: AppColor.buttonColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                  text: ' Signup')
            ]))
          ],
        ),
      ),
    );
  }
}
