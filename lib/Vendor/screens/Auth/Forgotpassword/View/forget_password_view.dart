import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/logo_tile.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

// import '../../../../RoutesAndBindings/app_routes.dart';
// import '../../../../Utils/appbar.dart';
// import '../../../../Utils/height_width_box.dart';
// import '../../../../Utils/logo_tile.dart';
// import '../../../../Utils/textStyle.dart';
// import '../../../../constant/AppTextField/app_textfield.dart';
// import '../../../../constant/colors.dart';
// import '../../../../Utils/app_text.dart';
// import '../../../../Utils/text_botton.dart';
// import '../../../../constant/constant.dart';
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
                      title: 'Forgot Password',
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
                      title:
                          'Please enter your Email/Phone number to receive a verification code',
                      fontSize: 12,
                      color: const Color(0xFF6D6E6F),
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 30,
                  ),
                  customTextField(
                    label: "Enter Your Email",
                    hintText: 'Email',
                    controller: forgetPassVM.emailController,
                    textInputType: TextInputType.emailAddress,
                    suffix: GestureDetector(
                      onTap: () {
                        print("Start Listing");
                        forgetPassVM.startListening(textFieldNo: 0);
                      },
                      child: Image.asset(
                        Constant.mic,
                        height: context.getSize.height * 0.022,
                        width: context.getSize.width * 0.038,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid  Email/phone number';
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
                                    forgetPassVM.postForgetPassword(
                                        email:
                                            forgetPassVM.emailController.text,
                                        context: context);
                                    // if (forgetPassVM.formKey.currentState!.validate()) {
                                    //   forgetPassVM.formKey.currentState?.save();

                                    //   // Get.toNamed(AppRoutes.newPasswordView);
                                    // } else {}
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
                          text: "Don't have an account?",
                          children: [
                        TextSpan(
                            style: textStyle(
                                context: context,
                                fontWeight: FontWeight.bold,
                                color: AppColor.buttonColor,
                                fontSize: 14),
                            text: ' Sign Up',
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
