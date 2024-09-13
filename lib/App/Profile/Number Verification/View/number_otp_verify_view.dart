import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/font_size_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../ViewModel/number_otp_confirm_ViewModel.dart';
import 'components/otp_verify_pin_field.dart';

class NumberOTPVerifyView extends StatelessWidget {
  NumberOTPVerifyView({super.key});
  final viewModel = Get.find<NumberOTPViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<NumberOTPViewModel>(
          init: NumberOTPViewModel(),
          builder: (viewModel) {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.080),
              child: Column(
                children: [
                  SizedBox(
                    height: context.getSize.height * 0.04,
                  ),
                  customAppBar(
                      context: context,
                      title: 'Number Verification',
                      onTap: () {
                        Get.back();
                      }),
                  SizedBox(
                    height: context.getSize.height * 0.1,
                  ),
                  SizedBox(
                    height: context.getSize.height * 0.06,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: context.fontSize(16),
                              fontFamily: 'Rubik',
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w400),
                          text: 'Waiting to automatically detect an ',
                          children: [
                            TextSpan(
                                style: TextStyle(
                                    fontSize: context.fontSize(16),
                                    fontFamily: 'Rubik',
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w500),
                                text: '\nmessage sent to Number.')
                          ])),
                  SizedBox(
                    height: context.getSize.height * 0.04,
                  ),
                  OTPVerifyPinField(
                      viewModel: viewModel,
                      pinLength: 6,
                      onComplete: (value) {
                        print(value);
                      }),
                  getHeight(context, 0.030),
                  viewModel.isTimerStart == false
                      ? getHeight(context, 0.02)
                      : appText(
                          title: '${viewModel.counterValue} Sec Left',
                          context: context,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                  getHeight(context, 0.07),
                  viewModel.isTimerStart == true
                      ? appText(title: '', context: context, fontSize: 12)
                      : RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontFamily: 'Rubik',
                                  fontSize: context.fontSize(12),
                                  fontWeight: FontWeight.w500),
                              text: 'Don’t receive OTP?',
                              children: [
                              TextSpan(
                                  text: 'Recend',
                                  style: TextStyle(
                                      color: const Color(0xff109B0E),
                                      fontFamily: 'Rubik',
                                      fontSize: context.fontSize(12),
                                      fontWeight: FontWeight.w500),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      viewModel.startCounterAgain();
                                    })
                            ])),
                  getHeight(context, 0.010),
                  textButton(
                      context: context,
                      title: 'Verify',
                      onClick: () {
                        Get.toNamed(AppRoutes.joinAsView);
                      }),
                ],
              ),
            ));
          }),
    );
  }
}
