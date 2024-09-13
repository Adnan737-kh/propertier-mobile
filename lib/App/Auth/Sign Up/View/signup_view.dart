import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:propertier/Utils/loading_view.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/logo_tile.dart';
import '../../../../constant/AppButton/text_button.dart';
import '../../../../constant/AppTextField/app_textfield.dart';
import '../../../../constant/colors.dart';
import '../../../../Utils/height_width_box.dart';
import '../../Components/social_links.dart';
import '../ViewModel/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final signupVM = Get.find<SignUpViewModel>();

  Future<bool> _showPrivacyPolicyDialog() async {
    bool? accept = await showDialog<bool>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SizedBox(
            height: 300.0, // Set a fixed height for the dialog content
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'At Propertier, we offer a comprehensive suite of services designed to meet all your property needs. '
                    'Our team of experts and specialists are dedicated to providing top-notch solutions in various aspects '
                    'of real estate and construction. Our services include:',
                  ),
                  SizedBox(height: 10),
                  Text(
                      '1. Document Verification: Ensure the legality and authenticity of property documents with our expert team of advocates and legal professionals.'),
                  SizedBox(height: 5),
                  Text(
                      '2. Property Expertise: Our seasoned property experts provide valuable insights and advice for buying, selling, and managing properties.'),
                  SizedBox(height: 5),
                  Text(
                      '3. Property Valuation: Get accurate and reliable property valuations for all types of real estate.'),
                  SizedBox(height: 5),
                  Text(
                      '4. Architectural and Design Services: From 2D and 3D AutoCAD mapping to architectural design, our skilled architects, exterior designers, and interior designers bring your vision to life.'),
                  SizedBox(height: 5),
                  Text(
                      '5. Surveying Services: We offer land surveying, quantity surveying, and quality surveying services to ensure precise planning and execution of projects.'),
                  SizedBox(height: 5),
                  Text(
                      '6. Engineering Services: Our team of engineers, including civil engineers, provides expert guidance on construction and infrastructure projects.'),
                  SizedBox(height: 5),
                  Text(
                      '7. Utility and Logistics: We facilitate water provision, transportation, and material supply, along with construction machinery services like excavators, bulldozers, and cranes.'),
                  SizedBox(height: 5),
                  Text(
                      '8. Machinery and Equipment Rental: Access a wide range of construction machinery, including excavators, bobcats, backhoe loaders, motor graders, and more.'),
                  SizedBox(height: 5),
                  Text(
                      '9. Labor Services: We provide skilled labor for various tasks, including masonry, plastering, carpentry, steel fixing, shuttering, and more. Our team also includes experts in electrical, plumbing, HVAC systems, and other specialized trades.'),
                  SizedBox(height: 5),
                  Text(
                      '10. Property Maintenance and Development: From caretakers and security guards to surveillance services and land development, we ensure your property is well-maintained and secure.'),
                  SizedBox(height: 5),
                  Text(
                      '11. Registry and Documentation: We offer registry, intaqal, and property document services to streamline the legal aspects of property ownership and transactions.'),
                  SizedBox(height: 5),
                  Text(
                      '12. Marketing and Advertising: Our SMM services for real estate, billboard advertising, and drafting services help promote and market your properties effectively.'),
                  SizedBox(height: 10),
                  Text(
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
              child: const Text('Decline'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Accept'),
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
        () => signupVM.isLoading.value
            ? const LoadingView()
            : Form(
                key: signupVM.formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getHeight(context, 0.065),
                        customAppBar(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            context: context,
                            title: 'Sign Up',
                            onTap: () {
                              Get.back();
                            }),
                        SizedBox(
                          width: sizeWidth(1, 0.7),
                          child: Column(
                            children: [
                              getHeight(context, 0.069),
                              Align(
                                  alignment: Alignment.center,
                                  child: logoTile(context)),
                              getHeight(context, 0.090),
                              customTextField(
                                labal: "Email",
                                controller: signupVM.userEmailController,
                                hintText: 'Enter Your Email',
                                textInputType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == '' || value!.isEmpty) {
                                    return "Please Enter Your Email";
                                  } else if (!value.isEmail) {
                                    return "Please Enter valid email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Obx(
                                () => customTextField(
                                  labal: "Password",
                                  obsecureText: !signupVM.isShowPassword.value,
                                  controller: signupVM.passwordController,
                                  suffix: GestureDetector(
                                      onTap: () {
                                        signupVM.isShowPassword.value =
                                            !signupVM.isShowPassword.value;
                                      },
                                      child: Icon(
                                        signupVM.isShowPassword.value
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.remove_red_eye,
                                        color: !signupVM.isShowPassword.value
                                            ? null
                                            : AppColor.secondaryColor,
                                      )),
                                  hintText: 'Enter your password',
                                  textInputType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Oops! we could not find matching credentials.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Obx(
                                () => customTextField(
                                  labal: "Confirm Password",
                                  obsecureText:
                                      !signupVM.isShowConfirmPassword.value,
                                  controller:
                                      signupVM.confirmPasswordController,
                                  suffix: GestureDetector(
                                      onTap: () {
                                        signupVM.isShowConfirmPassword.value =
                                            !signupVM
                                                .isShowConfirmPassword.value;
                                      },
                                      child: Icon(
                                        signupVM.isShowConfirmPassword.value
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.remove_red_eye,
                                        color: !signupVM
                                                .isShowConfirmPassword.value
                                            ? null
                                            : AppColor.secondaryColor,
                                      )),
                                  hintText: 'Enter Confirm password',
                                  textInputType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Oops! we could not find matching credentials.';
                                    } else if (signupVM
                                            .passwordController.text !=
                                        signupVM
                                            .confirmPasswordController.text) {
                                      return 'Password Mismatch';
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Obx(
                                    () => Expanded(
                                      child: signupVM.isSuccess == true
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
                                                if (signupVM
                                                    .formKey.currentState!
                                                    .validate()) {
                                                  if (await _showPrivacyPolicyDialog()) {
                                                    signupVM
                                                        .formKey.currentState
                                                        ?.save();
                                                    signupVM
                                                        .signUpUserData(
                                                            context:
                                                                Get.context!,
                                                            email: signupVM
                                                                .userEmailController
                                                                .text,
                                                            password: signupVM
                                                                .confirmPasswordController
                                                                .text)
                                                        .whenComplete(
                                                            () async {});
                                                  }
                                                }
                                              },
                                              buttonColor: AppColor.buttonColor,
                                              title: 'Sign Up',
                                              textColor: AppColor.blackColor,
                                            ),
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
                                    () => signupVM
                                                .isGoogleSigninLoading.value ==
                                            true
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
                                                  if (await _showPrivacyPolicyDialog()) {
                                                    signupVM.loginWithGoogle(
                                                        context: Get.context!);
                                                  }
                                                },
                                                icondata: Bootstrap.google,
                                                title: 'Sign In with Google',
                                                buttonColor:
                                                    AppColor.googleColor),
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
                                          signupVM.loginWithApple(
                                              context: context);
                                        },
                                        icondata: Bootstrap.apple,
                                        // iconColor: AppColor.googleColor,
                                        title: 'Sign in with Apple',
                                        buttonColor: AppColor.appleColor
                                        // textColor: AppColor.,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SocialLinks(),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                        getHeight(context, 0.012),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }
}
