import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/loading_view.dart';
import 'package:propertier/Utils/logo_tile.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../constant/AppButton/text_button.dart';
import '../../../../constant/AppTextField/app_textfield.dart';
import '../../../../constant/colors.dart';
import '../../../../Utils/app_text.dart';
import '../../Components/social_links.dart';
import '../ViewModel/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final loginVM = Get.find<LoginViewModel>();

  Future<bool> _showPrivacyPolicyDialog() async {
    bool? accept = await showDialog<bool>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.local.privacy_policy),
          content: SizedBox(
            height: 300.0, // Set a fixed height for the dialog content
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    context.local.privacy_policy,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'At Propertier, we offer a comprehensive suite of services designed to meet all your property needs. '
                    'Our team of experts and specialists are dedicated to providing top-notch solutions in various aspects '
                    'of real estate and construction. Our services include:',
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      '1. Document Verification: Ensure the legality and authenticity of property documents with our expert team of advocates and legal professionals.'),
                  const SizedBox(height: 5),
                  const Text(
                      '2. Property Expertise: Our seasoned property experts provide valuable insights and advice for buying, selling, and managing properties.'),
                  const SizedBox(height: 5),
                  const Text(
                      '3. Property Valuation: Get accurate and reliable property valuations for all types of real estate.'),
                  const SizedBox(height: 5),
                  const Text(
                      '4. Architectural and Design Services: From 2D and 3D AutoCAD mapping to architectural design, our skilled architects, exterior designers, and interior designers bring your vision to life.'),
                  const SizedBox(height: 5),
                  const Text(
                      '5. Surveying Services: We offer land surveying, quantity surveying, and quality surveying services to ensure precise planning and execution of projects.'),
                  const SizedBox(height: 5),
                  const Text(
                      '6. Engineering Services: Our team of engineers, including civil engineers, provides expert guidance on construction and infrastructure projects.'),
                  const SizedBox(height: 5),
                  const Text(
                      '7. Utility and Logistics: We facilitate water provision, transportation, and material supply, along with construction machinery services like excavators, bulldozers, and cranes.'),
                  const SizedBox(height: 5),
                  const Text(
                      '8. Machinery and Equipment Rental: Access a wide range of construction machinery, including excavators, bobcats, backhoe loaders, motor graders, and more.'),
                  const SizedBox(height: 5),
                  const Text(
                      '9. Labor Services: We provide skilled labor for various tasks, including masonry, plastering, carpentry, steel fixing, shuttering, and more. Our team also includes experts in electrical, plumbing, HVAC systems, and other specialized trades.'),
                  const SizedBox(height: 5),
                  const Text(
                      '10. Property Maintenance and Development: From caretakers and security guards to surveillance services and land development, we ensure your property is well-maintained and secure.'),
                  const SizedBox(height: 5),
                  const Text(
                      '11. Registry and Documentation: We offer registry, intaqal, and property document services to streamline the legal aspects of property ownership and transactions.'),
                  const SizedBox(height: 5),
                  const Text(
                      '12. Marketing and Advertising: Our SMM services for real estate, billboard advertising, and drafting services help promote and market your properties effectively.'),
                  const SizedBox(height: 10),
                  const Text(
                    'Please read and accept our privacy policy to proceed with login.',
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(context.local.decline),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(context.local.accept),
            ),
          ],
        );
      },
    );

    return accept!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => loginVM.isLoading.value
            ? const LoadingView()
            : Center(
                child: Container(
                  // color: Colors.red,
                  width: sizeWidth(1, 0.7),
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
                                label: context.local.enter_email_phone_number,
                                controller: loginVM.userEmailController,
                                hintText:
                                    context.local.enter_email_phone_number,
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
                                label: context.local.password,
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
                                      color: !loginVM.isShowPassword.value
                                          ? null
                                          : AppColor.secondaryColor,
                                    )),
                                hintText: context.local.enter_your_password,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.local
                                        .oops_we_could_not_find_matching_credentials;
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            AppRoutes.forgotPasswordView);
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
                                                if (loginVM
                                                    .formKey.currentState!
                                                    .validate()) {
                                                  // if (await _showPrivacyPolicyDialog()) {

                                                  loginVM.loginUser();
                                                  // loginVM.formKey.currentState
                                                  //     ?.save();
                                                  // bool isSuccess = await loginVM.loginUserData(context: context, email: loginVM.userEmailController
                                                  //             .text,
                                                  //         password: loginVM
                                                  //             .passwordController
                                                  //             .text);
                                                  // if (isSuccess == true) {
                                                  //   loginVM
                                                  //       .changeLoading(true);
                                                  //   Get.offAllNamed(
                                                  //       AppRoutes.navBarView);
                                                  // } else if (isSuccess ==
                                                  //     false) {
                                                  //   loginVM
                                                  //       .changeLoading(true);
                                                  // }
                                                  // }
                                                } else if (loginVM
                                                    .passwordController
                                                    .text
                                                    .isEmpty) {}
                                              },
                                              title: context.local.sign_in,
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
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Obx(
                              //       () => loginVM.isGoogleSignInLoading.value ==
                              //               true
                              //           ? const Center(
                              //               child: CircularProgressIndicator(
                              //                 color: AppColor.googleColor,
                              //               ),
                              //             )
                              //           : Expanded(
                              //               child: CustomTextButton(
                              //                   height: 48,
                              //                   fontSize: 14,
                              //                   fontWeight: FontWeight.w600,
                              //                   onTap: () async {
                              //                     if (await _showPrivacyPolicyDialog()) {
                              //                       loginVM.loginWithGoogle(
                              //                           context: context);
                              //                     }
                              //                   },
                              //                   iconData: Bootstrap.google,
                              //                   // iconColor: AppColor.googleColor,
                              //                   title: 'Sign In with Google',
                              //                   buttonColor:
                              //                       AppColor.googleColor
                              //                   // textColor: AppColor.,
                              //                   ),
                              //             ),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 12,
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: CustomTextButton(
                              //           height: 48,
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w600,
                              //           onTap: () async {
                              //             loginVM.loginWithApple(
                              //                 context: context);
                              //           },
                              //           iconData: Bootstrap.apple,
                              //           // iconColor: AppColor.googleColor,
                              //           title: 'Sign in with Apple',
                              //           buttonColor: AppColor.appleColor
                              //           // textColor: AppColor.,
                              //           ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 15,
                              ),
                              const SocialLinks(),
                              getHeight(context, 0.012),
                              getHeight(context, 0.012),
                              RichText(
                                  text: TextSpan(
                                      style: textStyle(
                                          context: context, fontSize: 12),
                                      text: context.local.dont_have_an_account,
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
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            //
                                            //   return SignUpViewNEw();
                                            // },));
                                            // Get.offAll(() => AppRoutes.signUpView);
                                            Get.toNamed(AppRoutes.signUpView);
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
      ),
    );
  }
}
