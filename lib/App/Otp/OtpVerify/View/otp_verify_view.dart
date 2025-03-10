import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Otp/OtpVerify/View/component/otp_verify_pin_field.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/App/Otp/OtpVerify/ViewModel/otp_verify_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/logo_tile.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/font_size_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/loading_view.dart';

class OTPVerifyView extends StatelessWidget {
  OTPVerifyView({super.key});
  final viewModel = Get.find<OTPVerifyViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => viewModel.isLoading.value
            ? const LoadingView()
            : GetX<OTPVerifyViewModel>(
                init: OTPVerifyViewModel(),
                builder: (viewModel) {
                  return SingleChildScrollView(
                    child: SafeArea(
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
                              title: '',
                              onTap: () {
                                Get.back();
                              }),
                          SizedBox(
                            height: context.getSize.height * 0.1,
                          ),
                          logoTile(context),
                          SizedBox(
                            height: context.getSize.height * 0.2,
                          ),
                          RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: context.fontSize(14),
                                      fontFamily: 'Rubik',
                                      color: AppColor.primaryColor
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.w400),
                                  text:
                                      'Your One Time Password(OTP) has been sent via SMS to your registered mobile number / Email.',
                                  children: const [])),
                          SizedBox(
                            height: context.getSize.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              6,
                              (index) => OTPField(
                                  controller: viewModel.otpControllers[index]),
                            ),
                          ),
                          getHeight(context, 0.030),
                          viewModel.isTimerStart == false
                              ? getHeight(context, 0.02)
                              : appText(
                                  title: '${viewModel.counterValue} Sec Left',
                                  context: context,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                          getHeight(context, 0.07),
                          viewModel.isTimerStart == true
                              ? appText(
                                  title: '', context: context, fontSize: 12)
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
                                          text: ' Resend',
                                          style: TextStyle(
                                              color: const Color(0xff109B0E),
                                              fontFamily: 'Rubik',
                                              fontSize: context.fontSize(14),
                                              fontWeight: FontWeight.w500),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              viewModel.startCounterAgain();
                                            })
                                    ])),
                          getHeight(context, 0.020),
                          textButton(
                              textFontSize: 14,
                              textFontWeight: FontWeight.bold,
                              context: context,
                              title: 'Verify',
                              onClick: () {
                                // Get.offAllNamed(AppRoutes.navBarView);
                                String otpCode = viewModel.otpControllers.map((controller)
                                => controller.text).join();
                                print("otpCode $otpCode");
                                // Ensure b OTP is 6 digits
                                if (otpCode.length == 6) {
                                  viewModel.verifyOtp(
                                    code: otpCode,
                                    // otpToken: viewModel.getOtpToken().toString(),
                                  );
                                  print(otpCode);
                                } else {
                                  print("Enter complete 6-digit OTP");
                                }
                              }),
                          getHeight(context, 0.069),
                          getHeight(context, 0.020),
                          getHeight(context, 0.011),
                        ],
                      ),
                    )),
                  );
                }),
      ),
    );
  }
}
