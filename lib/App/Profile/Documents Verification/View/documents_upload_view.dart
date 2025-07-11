import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/App/About/View/about_view.dart';
import 'package:propertier/extensions/localization_extension.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/text_botton.dart';
import '../ViewModel/documents_card_verification_view_model.dart';
import 'components/documents_upload_tile.dart';

class DocumentsUploadView extends StatefulWidget {
  const DocumentsUploadView({super.key});

  @override
  State<DocumentsUploadView> createState() => _DocumentsUploadViewState();
}

class _DocumentsUploadViewState extends State<DocumentsUploadView> {
  final documentsCardVM = Get.find<DocumentsVerficationViewModel>();
  File? _pickedFrontImage;
  File? _pickedBackImage;

  Future<void> pickImage(bool front) async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (imageFile != null) {
      if (front) {
        setState(() {
          _pickedFrontImage = File(imageFile.path);
        });
      } else {
        setState(() {
          _pickedBackImage = File(imageFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: const BackButton(
      //     color: AppColor.blackColor,
      //   ),
      //   title: const Text(
      //     "Confirm Verification",
      //     style: TextStyle(
      //       color: AppColor.blackColor,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(context.height * 0.02),
                  customAppBar(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      context: context,
                      onTap: () {
                        Get.back();
                      },
                      title: 'Confirm Verification'),
                  Gap(context.height * 0.3),
                  documentsUploadTile(
                    isLoading: false,
                    image: _pickedFrontImage,
                    onTap: () {
                      setState(() {
                        _pickedBackImage = null;
                      });
                      pickImage(true);
                    },
                  ),
                  Gap(context.height * 0.019),
                  CustomText(
                      title:context.local.please_take_photo_of_your_in_corporate_text_document,
                      fontSize: 16,
                      color: const Color(0xFF6D6E6F).withOpacity(0.6),
                      fontWeight: FontWeight.w400),
                  Gap(context.height * 0.198),
                  Row(
                    children: [
                      Expanded(
                        child: textButton(
                          onClick: () async {
                            // _pickedImage == null ?_pickAndCropImage : null;
                          },
                          context: context,
                          title: context.local.next,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 45,
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
