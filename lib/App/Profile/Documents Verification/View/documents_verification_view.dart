import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';
import '../ViewModel/documents_card_verification_view_model.dart';
import 'components/documents_verify_tile.dart';

class DocumentsVerificationView extends StatelessWidget {
  DocumentsVerificationView({super.key});
  final editProfileVM = Get.find<DocumentsVerficationViewModel>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.060),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  getHeight(context, 0.03),
                  customAppBar(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      context: context,
                      onTap: () {
                        Get.back();
                      },
                      title: 'Text Documents Verification'),
                  getHeight(context, 0.3),
                  documentsVerifyTile(
                      title: "Your Text Documents is not verified",
                      isVerify: false),
                  const Gap(5),
                  getHeight(context, 0.06),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
