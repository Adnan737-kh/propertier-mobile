import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../../Utils/appbar.dart';
import '../../../../../constant/AppButton/text_button.dart';
import '../../../../../constant/colors.dart';

import '../../../../../Utils/height_width_box.dart';
import '../ViewModel/verification_view_model.dart';
import 'components/verify_tile.dart';

class VerificationView extends StatelessWidget {
  VerificationView({super.key});
  final editProfileVM = Get.find<VerficationViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: Form(
          key: editProfileVM.formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.060),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getHeight(context, 0.065),
                  customAppBar(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      context: context,
                      onTap: () {
                        Get.back();
                      },
                      title: 'Verification'),
                  getHeight(context, 0.045),
                  VerifyTile(
                    title: "Email",
                    verify: true,
                    onTap: () => Get.toNamed(AppRoutes.emailVerificationView),
                  ),
                  const Gap(5),
                  VerifyTile(
                      title: "Number",
                      verify: false,
                      onTap: () =>
                          Get.toNamed(AppRoutes.numberVerificationView)),
                  const Gap(5),
                  VerifyTile(
                      title: "ID Card",
                      verify: false,
                      onTap: () => Get.toNamed(AppRoutes.idVerificationView)),
                  const Gap(5),
                  VerifyTile(
                      title: "Incorporation",
                      verify: false,
                      onTap: () =>
                          Get.toNamed(AppRoutes.incorporationVerificationView)),
                  const Gap(5),
                  VerifyTile(
                    title: "Address Verification",
                    verify: false,
                  ),
                  const Gap(5),
                  VerifyTile(
                      title: "Text Document",
                      verify: false,
                      onTap: () =>
                          Get.toNamed(AppRoutes.documentsVerificationView)),
                  const Gap(5),
                  VerifyTile(title: "Face Verification", verify: false),
                  getHeight(context, 0.06),
                  Row(
                    children: [
                      Expanded(
                        child: customTextButton(
                          onTap: () async {
                            // Get.toNamed(AppRoutes.verifySigninView);
                          },
                          buttonColor: AppColor.buttonColor,
                          title: 'Save',
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
  }
}
