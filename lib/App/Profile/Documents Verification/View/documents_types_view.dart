import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/AppButton/text_button.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';
import '../ViewModel/documents_card_verification_view_model.dart';

class DocumentsTypesView extends StatelessWidget {
  DocumentsTypesView({super.key});
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
                  customTextButton(
                      title: " In Corporate?",
                      fontSize: 14,
                      buttonColor: Colors.white,
                      textColor: AppColor.blackColor,
                      onTap: () {
                        Get.toNamed(AppRoutes.documentsUploadView);
                      }),
                  getHeight(context, 0.005),
                  appText(
                      title: "Will Verify  every three Months",
                      context: context,
                      colorOpecity: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  getHeight(context, 0.025),
                  customTextButton(
                      title: " Sole Proprietor",
                      fontSize: 14,
                      buttonColor: Colors.white,
                      textColor: AppColor.blackColor,
                      onTap: () {
                        Get.toNamed(AppRoutes.documentsUploadView);
                      }),
                  getHeight(context, 0.005),
                  appText(
                      title: "Will Verify every year",
                      context: context,
                      colorOpecity: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
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
