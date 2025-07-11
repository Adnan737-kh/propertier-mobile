import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/toast.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../../Utils/appbar.dart';
import '../../../../../constant/AppButton/text_button.dart';
import '../../../../../constant/colors.dart';

import '../../../../../Utils/height_width_box.dart';
import '../ViewModel/verification_view_model.dart';
import 'components/verify_tile.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final verificationVM = Get.find<VerificationViewModel>();

    return Obx(() {
      return verificationVM.isLoading.value
          ? const Scaffold(
        body: Center(child: CircularProgressIndicator(
          color: AppColor.buttonColor,
        )),
      )
          : Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.060,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    getHeight(context, 0.065),
                    customAppBar(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      context: context,
                      onTap: () => Get.back(),
                      title: context.local.verification,
                    ),
                    getHeight(context, 0.045),
                    verifyTile(
                      title: context.local.email,
                      verify: _getVerificationStatus(verificationVM.emailVerificationStatus.value),
                      onTap: () => _handleButtonTap(
                        context,
                        verificationVM.emailVerificationStatus.value,
                        context.local.email_verification_in_progress,
                        context.local.your_email_is_already_verified,
                        AppRoutes.emailVerificationView,
                      ),
                    ),
                    const Gap(5),
                    verifyTile(
                      title:context. local.number,
                      verify: _getVerificationStatus(verificationVM.numberVerificationStatus.value),
                      onTap: () => _handleButtonTap(
                        context,
                        verificationVM.numberVerificationStatus.value,
                        context.local.phone_number_verification_in_progress,
                        context.local.your_phone_number_is_already_verified,
                        AppRoutes.numberVerificationView,
                      ),
                    ),
                    const Gap(5),
                    verifyTile(
                      title: context. local.id_card,
                      verify: _getVerificationStatus(verificationVM.idCardVerificationStatus.value),
                      onTap: () => _handleButtonTap(
                        context,
                        verificationVM.idCardVerificationStatus.value,
                        context.local.id_card_verification_in_progress,
                        context.local.your_id_card_is_already_verified,
                        AppRoutes.idVerificationView,
                      ),
                    ),
                    verifyTile(
                      title: context.local.face_verification,
                      verify: _getVerificationStatus(verificationVM.selfieVerificationStatus.value),
                      onTap: () => _handleButtonTap(
                        context,
                        verificationVM.selfieVerificationStatus.value,
                       context.local.face_Verification_in_progress,
                        context.local.your_face_is_already_verified,
                        AppRoutes.faceRecognitionView,
                      ),
                    ),

                    getHeight(context, 0.06),
                    Row(
                      children: [
                        Expanded(
                          child: customTextButton(
                            onTap: () async {
                              // Save logic
                            },
                            buttonColor: AppColor.buttonColor,
                            title: context.local.save,
                            textColor: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  String _getVerificationStatus(String status) {
    switch (status) {
      case 'pending':
      case 'unverified':
      case 'verified':
        return status;
      default:
        return 'unknown';
    }
  }

  void _handleButtonTap(BuildContext context, String status,String pendingMessage,String verifiedMessage,String route) {
    switch (status) {
      case 'pending':
        toast(title: pendingMessage, context: context);
        break;
      case 'unverified':
        Get.offNamed(route);
        break;
      case 'verified':
        toast(title: verifiedMessage, context: context);
        break;
      default:
        Get.offNamed(AppRoutes.emailVerificationView);
    }
  }

}
