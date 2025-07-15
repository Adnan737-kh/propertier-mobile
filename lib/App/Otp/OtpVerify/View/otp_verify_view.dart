import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Otp/OtpVerify/View/component/otp_verify_pin_field.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/loading_view.dart';
import 'package:propertier/Utils/logo_tile.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/font_size_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../ViewModel/otp_verify_view_model.dart';

class OTPVerifyView extends StatelessWidget {
  OTPVerifyView({super.key});
  final viewModel = Get.find<OTPVerifyViewModel>();
  // final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  // void _checkAndAutoVerify() {
  //   final code = viewModel.otpController.map((c) => c.text).join();
  //   if (code.length == 6) {
  //     viewModel.verifyOtp(code: code);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => viewModel.isLoading.value
          ? const LoadingView()
          : SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.getSize.width * 0.080),
            child: Column(
              children: [
                SizedBox(height: context.getSize.height * 0.04),
                customAppBar(context: context, title: '', onTap: () => Get.back()),
                SizedBox(height: context.getSize.height * 0.1),
                logoTile(context),
                SizedBox(height: context.getSize.height * 0.2),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: context.fontSize(14),
                      fontFamily: 'Rubik',
                      color: AppColor.primaryColor.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                    ),
                    text: 'Your One Time Password(OTP) has been sent via SMS to your registered Email.',
                  ),
                ),
                SizedBox(height: context.getSize.height * 0.04),
            // OTPField(
            //   // controller: viewModel.otpControllers[index],
            //   // focusNode: _focusNodes[index],
            //   onChanged: (_) => _checkAndAutoVerify(),
            // ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: List.generate(6, (index) {
                //     return OTPField(
                //       controller: viewModel.otpControllers[index],
                //       focusNode: _focusNodes[index],
                //       onChanged: (_) =>  _checkAndAutoVerify(),
                //     );
                //   }),
                // ),

                OTPField(
                  controller: viewModel.otpController,
                  onChanged: (code) => print('OTP: $code'),

                  onSubmit: (code) {
                    if (kDebugMode) {
                      print('Submit OTP: $code');
                    }
                    viewModel.verifyOtp(code: code); // ✅ Call your verification function here
                  },
                ),
                getHeight(context, 0.03),
                viewModel.isTimerStart
                    ? CustomText(
                  title: '${viewModel.counterValue} Sec Left',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )
                    : RichText(
                  text: TextSpan(
                    text: 'Didn’t receive OTP?',
                    style: TextStyle(
                      fontSize: context.fontSize(12),
                      fontWeight: FontWeight.w500,
                      color: AppColor.primaryColor,
                    ),
                    children: [
                      TextSpan(
                        text: ' Resend',
                        style: TextStyle(
                          color: const Color(0xff109B0E),
                          fontSize: context.fontSize(14),
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            viewModel.startCounterAgain();
                          },
                      ),
                    ],
                  ),
                ),
                getHeight(context, 0.02),
                textButton(
                  textFontSize: 14,
                  textFontWeight: FontWeight.bold,
                  context: context,
                  title: 'Verify',
                  onClick: () {
                    final code = viewModel.otpController.text;
                    if (code.length == 6) {
                      viewModel.verifyOtp(code: code);
                    } else {
                      if (kDebugMode) {
                        print("Enter complete 6-digit OTP");
                      }
                    }
                  },

                ),
                getHeight(context, 0.06),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
