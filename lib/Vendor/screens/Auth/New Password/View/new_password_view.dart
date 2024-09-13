import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/logo_tile.dart';
import 'package:propertier/constant/AppButton/text_button.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/constant/colors.dart';

// import '../../../../RoutesAndBindings/app_routes.dart';
// import '../../../../Utils/appbar.dart';
// import '../../../../Utils/height_width_box.dart';
// import '../../../../Utils/logo_tile.dart';
// import '../../../../constant/AppButton/text_button.dart';
// import '../../../../constant/AppTextField/app_textfield.dart';
// import '../../../../constant/colors.dart';
// import '../../../../Utils/app_text.dart';
import '../../Components/social_links.dart';
import '../ViewModel/new_password_view_model.dart';

class NewPasswordView extends StatelessWidget {
  NewPasswordView({super.key});
  final newPassVM = Get.find<NewPasswordViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Form(
              key: newPassVM.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  getHeight(context, 0.065),
                  customAppBar(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      context: context,
                      title: 'Forgot Password',
                      onTap: () {
                        Get.back();
                      }),
                  getHeight(context, 0.079),
                  Align(alignment: Alignment.center, child: logoTile(context)),
                  getHeight(context, 0.101),
                  appText(
                      textAlign: TextAlign.left,
                      title:
                          'Your new Password must be different from previously used Password.',
                      context: context,
                      fontSize: 14,
                      color: const Color(0xFF6D6E6F),
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 30,
                  ),
                  customTextField(
                    labal: "New Password",
                    hintText: 'Enter New Password',
                    obsecureText: newPassVM.isShowPassword.value,
                    controller: newPassVM.newpasswordController,
                    textInputType: TextInputType.emailAddress,
                    suffix: IconButton(
                        onPressed: () {
                          newPassVM.isShowPassword.value =
                              !newPassVM.isShowPassword.value;
                        },
                        icon: Icon(
                          newPassVM.isShowPassword.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          color: !newPassVM.isShowPassword.value
                              ? null
                              : AppColor.secondaryColor,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter New Password';
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  customTextField(
                    obsecureText: newPassVM.isShowConfirmPassword.value,
                    labal: "Confirm Password",
                    hintText: 'Enter Password Again',
                    controller: newPassVM.renewpasswordController,
                    textInputType: TextInputType.text,
                    suffix: IconButton(
                        onPressed: () {
                          newPassVM.isShowConfirmPassword.value =
                              !newPassVM.isShowConfirmPassword.value;
                        },
                        icon: Icon(
                          newPassVM.isShowConfirmPassword.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          color: !newPassVM.isShowConfirmPassword.value
                              ? null
                              : AppColor.secondaryColor,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password Again';
                      } else if (newPassVM.newpasswordController.text !=
                          newPassVM.renewpasswordController.text) {
                        return 'Password Mismatch';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customTextButton(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            onTap: () async {
                              if (newPassVM.formKey.currentState!.validate()) {
                                newPassVM.formKey.currentState?.save();
                                Get.offAllNamed(AppRoutes.joinAsView);
                              }
                            },
                            title: 'Save',
                            textColor: AppColor.blackColor,
                            buttonColor: AppColor.buttonColor),
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
                  // RichText(
                  //     text: TextSpan(
                  //         style: textStyle(context: context, fontSize: 18),
                  //         text: "Don't have an account?",
                  //         children: [
                  //       TextSpan(
                  //           style: textStyle(
                  //               context: context,
                  //               fontWeight: FontWeight.bold,
                  //               color: AppColor.buttonColor,
                  //               fontSize: 20),
                  //           text: ' Sign Up',
                  //           recognizer: TapGestureRecognizer()
                  //             ..onTap = () {
                  //               Get.toNamed(AppRoutes.signUpView);
                  //             })
                  //     ])),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
