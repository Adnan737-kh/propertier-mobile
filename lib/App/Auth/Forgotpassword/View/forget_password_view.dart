import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../Utils/logo_tile.dart';
import '../../../../Utils/textStyle.dart';
import '../../../../constant/AppTextField/app_textfield.dart';
import '../../../../constant/colors.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/text_botton.dart';
import '../../../../constant/constant.dart';
import '../../Components/social_links.dart';
import '../ViewModel/forget_password_view_model.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});
  final forgetPassVM = Get.find<ForgotPasswordViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Form(
            key: forgetPassVM.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  getHeight(context, 0.03),
                  customAppBar(
                      fontWeight: FontWeight.w600,
                      context: context,
                      title: context.local.forgot_password,
                      onTap: () {
                        Get.back();
                      }),
                  getHeight(context, 0.079),
                  Align(alignment: Alignment.center, child: logoTile(context)),
                  const SizedBox(
                    height: 80,
                  ),
                  CustomText(
                      textAlign: TextAlign.left,
                      title: context.local
                          .please_enter_your_email_to_receive_a_verification_code,
                      fontSize: 12,
                      color: const Color(0xFF6D6E6F),
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 30,
                  ),
                  customTextField(
                    label: context.local.enter_your_email,
                    hintText: context.local.email,
                    controller: forgetPassVM.emailController,
                    textInputType: TextInputType.emailAddress,
                    suffix: GestureDetector(
                      onTap: () {
                        // if (kDebugMode) {
                        //   print("Start Listing");
                        // }
                        // forgetPassVM.startListening(textFieldNo: 0);
                      },
                      child: Image.asset(
                        Constant.mic,
                        height: context.getSize.height * 0.022,
                        width: context.getSize.width * 0.038,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.local.please_enter_valid_email;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => forgetPassVM.isLoading.value == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.buttonColor,
                                ),
                              )
                            : Expanded(
                                child: textButton(
                                  textFontWeight: FontWeight.bold,
                                  onClick: () async {
                                    forgetPassVM.forgetPasswordViaEmail(
                                        email:
                                            forgetPassVM.emailController.text,
                                        context: context);
                                  },
                                  context: context,
                                  title: 'Send',
                                ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  const SocialLinks(),
                  const SizedBox(
                    height: 12,
                  ),
                  getHeight(context, 0.012),
                  RichText(
                      text: TextSpan(
                          style: textStyle(context: context, fontSize: 12),
                          text: context.local.do_not_have_an_account,
                          children: [
                        TextSpan(
                            style: textStyle(
                                context: context,
                                fontWeight: FontWeight.bold,
                                color: AppColor.buttonColor,
                                fontSize: 14),
                            text: context.local.sign_up,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.signUpView);
                                // Get.toNamed(AppRoutes.signUpView);
                              })
                      ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
