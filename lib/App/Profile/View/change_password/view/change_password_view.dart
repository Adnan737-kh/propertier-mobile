import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/What%20are%20you%20searching/View/Components/custom_botton_wryf.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../../constant/colors.dart';
import '../../../../../constant/constant.dart';
import '../view_model/change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});
  final changePasswordVM = Get.find<ChangePasswordViewModel>();

  final myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(context.local.change_password),
            backgroundColor: AppColor.forGroundColor,
          ),
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                customTextField(
                  isFilled: true,
                  label: context.local.current_password,
                  textInputType: TextInputType.text,
                  controller: changePasswordVM.currentPasswordController,
                  hintText: context.local.enter_current_password,
                  suffix: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      Constant.mic,
                      height: context.getSize.height * 0.022,
                      width: context.getSize.width * 0.038,
                    ),
                  ),
                  onFieldSubmitted: (_) => changePasswordVM.updateFocusNode(
                      changePasswordVM.newPasswordFocusNode, context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                  focusNode: changePasswordVM.currentPasswordFocusNode,
                ),
                const SizedBox(
                  height: 25,
                ),
                customTextField(
                  isFilled: true,
                  label: context.local.new_password,
                  textInputType: TextInputType.text,
                  controller: changePasswordVM.newPasswordController,
                  hintText: context.local.enter_new_password,
                  suffix: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      Constant.mic,
                      height: context.getSize.height * 0.022,
                      width: context.getSize.width * 0.038,
                    ),
                  ),
                  onFieldSubmitted: (_) => changePasswordVM.updateFocusNode(
                      changePasswordVM.confirmNewPasswordFocusNode, context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.local.please_enter_your_new_password;
                    }
                    return null;
                  },
                  focusNode: changePasswordVM.newPasswordFocusNode,
                ),
                const SizedBox(
                  height: 25,
                ),
                customTextField(
                  isFilled: true,
                  label: context.local.confirm_new_password,
                  textInputType: TextInputType.text,
                  controller: changePasswordVM.confirmNewPasswordController,
                  hintText: context.local.re_enter_new_password,
                  suffix: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      Constant.mic,
                      height: context.getSize.height * 0.022,
                      width: context.getSize.width * 0.038,
                    ),
                  ),
                  onFieldSubmitted: (_) {
                    changePasswordVM.updateFocusNode(null, context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.local.please_enter_your_new_password;
                    }
                    return null;
                  },
                  focusNode: changePasswordVM.confirmNewPasswordFocusNode,
                ),
                const SizedBox(
                  height: 25,
                ),
                Obx(
                  () => changePasswordVM.isLoading.value
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          title: context.local.change_password,
                          onTap: () {
                            changePasswordVM.changePassword(
                              context,
                              changePasswordVM.currentPasswordController.text,
                              changePasswordVM.newPasswordController.text,
                              changePasswordVM
                                  .confirmNewPasswordController.text,
                            );
                          }),
                )
              ],
            ),
          )),
    );
  }
}
