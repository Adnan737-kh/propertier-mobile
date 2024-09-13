import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/email/view/verification_error_screen.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/face/view/face_verificatiion_eror_screen.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/incorporation/view/incorporation_error_screen.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/success_screen.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/text_document/view/document_error_screen.dart';

import 'id_card/view/idcard_verification_error_screen.dart';

class SelectVerficationScreen extends StatefulWidget {
  const SelectVerficationScreen({super.key});

  @override
  State<SelectVerficationScreen> createState() =>
      _SelectVerficationScreenState();
}

class _SelectVerficationScreenState extends State<SelectVerficationScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  Future<void> _checkCnicVerification() async {
    String cnicFront = profileController.profile.value.cnicFrontUrl ?? '';
    String cnicBack = profileController.profile.value.cnicBackUrl ?? '';

    if (cnicFront.isNotEmpty && cnicBack.isNotEmpty) {
      Get.to(() => const SuccessScreen(
            text: 'Sucess',
          ));
    } else {
      Get.to(() => const IdCardVerificationScreen());
    }
  }

  Future<void> _checkCertificateVerification() async {
    String certiIncorporation =
        profileController.profile.value.certificateOfIncorporationUrl ?? '';
    String certiAssociation =
        profileController.profile.value.artificialOfAssociationUrl ?? '';
    String certiMember =
        profileController.profile.value.memberOfAssociationUrl ?? '';

    if (certiIncorporation.isNotEmpty &&
        certiAssociation.isNotEmpty &&
        certiMember.isNotEmpty) {
      Get.to(() => const SuccessScreen(
            text: 'Sucess',
          ));
    } else {
      Get.to(() => const IncorporationErrorScreen());
    }
  }

  Future<void> _checkdocVerification() async {
    String incoporatedoc =
        profileController.profile.value.incorporateDocumentUrl ?? '';
    String propertydoc =
        profileController.profile.value.solePropertiierDocumentUrl ?? '';

    if (incoporatedoc.isNotEmpty && propertydoc.isNotEmpty) {
      Get.to(() => const SuccessScreen(
            text: 'Sucess',
          ));
    } else {
      Get.to(() => const TextDocumentErrorScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Get.size.width,
            height: Get.height * .124,
            padding: const EdgeInsets.only(top: 38, left: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFF131A22),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.black.withOpacity(0.05),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Verification',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          VerificationWidget(
            text: 'Email',
            iconPath: Image.asset('assets/vendor_assets/done.png'),
            onTap: () {
              Get.to(() => const VerificationErrorScreen());
            },
          ),
          VerificationWidget(
            text: 'Number',
            iconPath: SvgPicture.asset(
              'assets/vendor_assets/verification.svg',
              height: 20,
            ),
            onTap: () {},
          ),
          VerificationWidget(
            text: 'ID Card',
            iconPath: SvgPicture.asset(
              'assets/vendor_assets/verification.svg',
              height: 20,
            ),
            onTap: _checkCnicVerification,
          ),
          VerificationWidget(
            text: 'Incorporation',
            iconPath: SvgPicture.asset(
              'assets/vendor_assets/verification.svg',
              height: 20,
            ),
            onTap: _checkCertificateVerification,
          ),
          VerificationWidget(
            text: 'Address Verification',
            iconPath: SvgPicture.asset(
              'assets/vendor_assets/verification.svg',
              height: 20,
            ),
            onTap: () {},
          ),
          VerificationWidget(
              text: 'Text Document',
              iconPath: SvgPicture.asset(
                'assets/vendor_assets/verification.svg',
                height: 20,
              ),
              onTap: _checkdocVerification),
          VerificationWidget(
            text: 'Face Verification',
            iconPath: SvgPicture.asset(
              'assets/vendor_assets/verification.svg',
              height: 20,
            ),
            onTap: () {
              Get.to(() => const FaceVerificatiionErorScreen());
            },
          ),
          SizedBox(height: Get.height * .05),
          InkWell(
            onTap: () {
              // validateAndCreate();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              width: Get.size.width,
              height: Get.height * .07,
              decoration: ShapeDecoration(
                color: const Color(0xFFFDCD54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Color(0xFF131A22),
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationWidget extends StatelessWidget {
  final String text;
  final Widget iconPath;
  final VoidCallback onTap;

  const VerificationWidget({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFD1D8E0)),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                iconPath,
                const SizedBox(width: 8),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0x99131A22),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFF131A22),
            ),
          ],
        ),
      ),
    );
  }
}
