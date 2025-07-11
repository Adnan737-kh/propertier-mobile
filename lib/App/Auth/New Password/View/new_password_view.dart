import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/localization_extension.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../Utils/logo_tile.dart';
import '../../../../constant/AppButton/text_button.dart';
import '../../../../constant/AppTextField/app_textfield.dart';
import '../../../../constant/colors.dart';
import '../../../../Utils/app_text.dart';
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
                      title: context.local.forgot_password,
                      onTap: () {
                        Get.back();
                      }),
                  getHeight(context, 0.079),
                  Align(alignment: Alignment.center, child: logoTile(context)),
                  getHeight(context, 0.101),
                  CustomText(
                      textAlign: TextAlign.left,
                      title: context.local
                          .your_new_password_must_be_different_from_previously_used_password,
                      fontSize: 14,
                      color: const Color(0xFF6D6E6F),
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 30,
                  ),
                  customTextField(
                    label: context.local.new_password,
                    hintText: context.local.enter_your_password,
                    obSecureText: newPassVM.isShowPassword.value,
                    controller: newPassVM.newPasswordController,
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
                        return context.local.please_enter_new_password;
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  customTextField(
                    obSecureText: newPassVM.isShowConfirmPassword.value,
                    label: context.local.confirm_password,
                    hintText: context.local.enter_password_again,
                    controller: newPassVM.reNewPasswordController,
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
                        return context.local.please_enter_password_again;
                      } else if (newPassVM.newPasswordController.text !=
                          newPassVM.reNewPasswordController.text) {
                        return context.local.password_mismatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Expanded(
                          child: newPassVM.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : customTextButton(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  onTap: () async {
                                    newPassVM.confirmRestPassword();
                                  },
                                  title: context.local.save,
                                  textColor: AppColor.blackColor,
                                  buttonColor: AppColor.buttonColor),
                        ),
                      )
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
