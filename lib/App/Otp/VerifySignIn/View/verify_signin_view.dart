import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/App/Otp/VerifySignIn/View/component/dial_button.dart';
import 'package:propertier/App/Otp/VerifySignIn/View/component/pin_text_field.dart';
import 'package:propertier/App/Otp/VerifySignIn/ViewModel/verify_sigin_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/loading_view.dart';
import 'package:propertier/Utils/logo_tile.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

class VerifySigninView extends StatelessWidget {
  const VerifySigninView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetX<VeifySigninViewModel>(
        init: VeifySigninViewModel(),
        builder: (viewModel) {
          return Scaffold(
            bottomSheet: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 5, vertical: context.getSize.width * 0.060),
                height: context.getSize.height * 0.50,
                width: context.getSize.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: AppColor.primaryColor),
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: List.generate(
                      viewModel.numberList.length,
                      (index) => dialButton(viewModel, index,
                          GetStorage().read('authkey') ?? '', context)),
                ),
              ),
            ),
            body: SafeArea(
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
                      title: 'Sign up verification',
                      onTap: () {
                        Get.back();
                      }),
                  SizedBox(
                    height: context.getSize.height * 0.1,
                  ),
                  logoTile(context),
                  SizedBox(
                    height: context.getSize.height * 0.06,
                  ),
                  appText(
                      title: 'Enter your verification Code here',
                      context: context,
                      fontSize: 14,
                      color: AppColor.primaryColor),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: appText(
                      title: 'Wrong Email/Password?',
                      context: context,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff4286F5),
                    ),
                  ),
                  SizedBox(
                    height: context.getSize.height * 0.04,
                  ),
                  viewModel.isLoading.value
                      ? const LoadingView()
                      : VerifySigninPinField(
                          viewModel: viewModel,
                          pinLength: 6,
                          onComplete: (value) {
                            viewModel.verifyEmailOTP(
                                otp: value, context: context);
                          })
                ],
              ),
            )),
          );
        });
  }
}
