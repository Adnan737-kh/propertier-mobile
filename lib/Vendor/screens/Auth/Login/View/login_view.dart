import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:propertier/App/About/View/about_view.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/logo_tile.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/Vendor/screens/Auth/Login/Services/facebook_login_services.dart';
import 'package:propertier/Vendor/screens/Auth/Login/ViewModel/login_view_model.dart';
import 'package:propertier/Vendor/screens/Auth/Sign%20Up/View/signup_view.dart';
import 'package:propertier/Vendor/screens/Auth/Sign%20Up/ViewModel/signup_view_model.dart';
import 'package:propertier/constant/AppButton/text_button.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

// import '../../../../RoutesAndBindings/app_routes.dart';
// import '../../../../constant/AppButton/text_button.dart';
// import '../../../../constant/AppTextField/app_textfield.dart';
// import '../../../../constant/colors.dart';
// import '../../../../Utils/app_text.dart';
import '../../Components/social_links.dart';


class LoginView extends StatelessWidget {
  LoginView({super.key});
  final loginVM = Get.find<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => Container(
          // color: Colors.red,
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
          ),

          child: Center(
            child: Form(
              key: loginVM.formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getSize.width * 0.060),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: logoTile(context)),
                      const SizedBox(
                        height: 80,
                      ),
                      customTextField(
                        label: "Enter Email/Phone Number",
                        controller: loginVM.usernameController,
                        hintText: 'Enter Email/Phone Number',
                        textInputType: TextInputType.emailAddress,
                        suffix: GestureDetector(
                          onTap: () {
                            loginVM.startListening(textFieldNo: 0);
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
                        height: 12,
                      ),
                      customTextField(
                        label: "Password",
                        obSecureText: !loginVM.isShowPassword.value,
                        controller: loginVM.passwordController,
                        suffix: GestureDetector(
                            onTap: () {
                              loginVM.isShowPassword.value =
                                  !loginVM.isShowPassword.value;
                            },
                            child: Icon(
                              loginVM.isShowPassword.value
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye,
                              size: context.getSize.width * 0.050,
                              color: !loginVM.isShowPassword.value
                                  ? null
                                  : AppColor.secondaryColor,
                            )),
                        hintText: 'Enter your Password',
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Oops! we could not find matching credentials.';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.forgotPasswordView);
                              },
                              child: CustomText(
                                  title: context.local.forgot_password,
                                  fontSize: 14,
                                  color: AppColor.facebookColor,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Expanded(
                              child: loginVM.isSuccess == false
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor.buttonColor,
                                      ),
                                    )
                                  : customTextButton(
                                      height: 48,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      onTap: () async {
                                        if (loginVM.formKey.currentState!
                                            .validate()) {
                                          loginVM.formKey.currentState?.save();
                                          bool isSuccess =
                                              await loginVM.loginUserData(
                                                  context: context,
                                                  email: loginVM
                                                      .usernameController.text,
                                                  password: loginVM
                                                      .passwordController.text);
                                          if (isSuccess == true) {
                                            loginVM.changeLoading(true);
                                            Get.offAllNamed(
                                                AppRoutes.navBarView);
                                          } else if (isSuccess == false) {
                                            loginVM.changeLoading(true);
                                          }
                                        } else if (loginVM
                                            .passwordController.text.isEmpty) {}
                                      },
                                      title: 'SIGN IN',
                                      buttonColor: AppColor.buttonColor,
                                      textColor: AppColor.blackColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => loginVM.isGoogleSigninLoading.value == true
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColor.googleColor,
                                    ),
                                  )
                                : Expanded(
                                    child: customTextButton(
                                        height: 48,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        onTap: () async {
                                          loginVM.loginWithGoogle(
                                              context: context);
                                        },
                                        iconData: Bootstrap.google,
                                        // iconColor: AppColor.googleColor,
                                        title: 'Sign In with Google',
                                        buttonColor: AppColor.googleColor
                                        // textColor: AppColor.,
                                        ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: customTextButton(
                                height: 48,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                onTap: () async {
                                  FacebookLoginServices().signInWithFacebook();
                                },
                                iconData: Bootstrap.facebook,
                                // iconColor: AppColor.googleColor,
                                title: 'Sign in with Facebook',
                                buttonColor: AppColor.facebookColor
                                // textColor: AppColor.,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SocialLinks(),
                      getHeight(context, 0.012),
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
                                    Get.put(SignUpViewModel());
                                    Get.to(() => Get.put(SignUpView()));
                                    // Get.toNamed(AppRoutes.signUpView);
                                  })
                          ])),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
