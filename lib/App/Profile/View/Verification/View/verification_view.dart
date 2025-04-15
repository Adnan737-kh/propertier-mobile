import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/toast.dart';
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
    return GetBuilder<VerficationViewModel>(builder: (verificationVM) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
          ),
          child: Form(
            key: verificationVM.formKey,
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
                    verifyTile(
                      title: "Email",
                      verify: (() {
                        switch (verificationVM.emailVerificationStatus.value) {
                          case 'pending':
                            return "pending";
                          case 'unverified':
                            return "unverified";
                          case 'verified':
                            return "verified";
                          default:
                            return "unknown";
                        }
                      })(),
                      onTap: () {
                        switch (verificationVM.emailVerificationStatus.value) {
                          case 'pending':
                            return toast(
                                title: "Email Verification in Progress",
                                context: context);
                          case 'unverified':
                            return Get.toNamed(AppRoutes.emailVerificationView);
                          case 'verified':
                            return toast(
                                title: "Your Email is Already Verified",
                                context: context);
                          default:
                            return Get.toNamed(AppRoutes
                                .emailVerificationView); // Handle any unknown status
                        }
                      },
                    ),
                    const Gap(5),
                    verifyTile(
                      title: "Number",
                      verify: (() {
                        switch (verificationVM.numberVerificationStatus.value) {
                          case 'pending':
                            return "pending";
                          case 'unverified':
                            return "unverified";
                          case 'verified':
                            return "verified";
                          default:
                            return "unknown";
                        }
                      })(),
                      onTap: () {
                        switch (verificationVM.numberVerificationStatus.value) {
                          case 'pending':
                            return toast(
                                title: "Phone Number Verification in Progress",
                                context: context);
                          case 'unverified':
                            return Get.toNamed(
                                AppRoutes.numberVerificationView);
                          case 'verified':
                            return toast(
                                title: "Your Phone Number is Already Verified",
                                context: context);
                          default:
                            return Get.toNamed(AppRoutes
                                .numberVerificationView); // Handle any unknown status
                        }
                      },
                    ),
                    const Gap(5),
                    verifyTile(
                      title: "ID Card",
                      verify: (() {
                        switch (verificationVM.idCardVerificationStatus.value) {
                          case 'pending':
                            return "pending"; // Return "pending" if status is 'pending'
                          case 'unverified':
                            return "unverified"; // Return "unverified" if status is 'unverified'
                          case 'verified':
                            return "verified"; // Return "verified" if status is 'verified'
                          default:
                            return "unknown"; // Handle any unknown status
                        }
                      })(),
                      onTap: () {
                        switch (verificationVM.idCardVerificationStatus.value) {
                          case 'pending':
                            return toast(
                                title: "ID Card Verification in Progress",
                                context: context);
                          case 'unverified':
                            return Get.toNamed(AppRoutes.idVerificationView);
                          case 'verified':
                            return toast(
                                title: "Your ID Card is Already Verified",
                                context: context);
                          default:
                            return Get.toNamed(AppRoutes
                                .idVerificationView); // Handle any unknown status
                        }
                      },
                    ),
                    getHeight(context, 0.06),
                    Row(
                      children: [
                        Expanded(
                          child: customTextButton(
                            onTap: () async {
                              // Get.toNamed(AppRoutes.verifySigningView);
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
    });
  }
}

// const Gap(5),
// VerifyTile(
//     title: "Incorporation",
//     verify: false,
//     onTap: () =>
//         Get.toNamed(AppRoutes.incorporationVerificationView)),
// const Gap(5),
// VerifyTile(
//   title: "Address Verification",
//   verify: false,
// ),
// const Gap(5),
// VerifyTile(
//     title: "Text Document",
//     verify: false,
//     onTap: () =>
//         Get.toNamed(AppRoutes.documentsVerificationView)),
// const Gap(5),
// VerifyTile(title: "Face Verification", verify: false,
//     onTap: () =>
//         Get.toNamed(AppRoutes.faceRecognitionView )),
