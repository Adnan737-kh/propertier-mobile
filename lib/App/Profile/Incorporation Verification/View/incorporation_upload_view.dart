import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../constant/colors.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../Utils/textStyle.dart';
import '../../../../Utils/text_botton.dart';
import '../ViewModel/incorporation_card_verification_view_model.dart';
import 'components/incorporation_upload_tile.dart';

class IncorporationUploadView extends StatefulWidget {
  const IncorporationUploadView({super.key});

  @override
  State<IncorporationUploadView> createState() =>
      _IncorporationUploadViewState();
}

class _IncorporationUploadViewState extends State<IncorporationUploadView> {
  final iDCardVM = Get.find<IncorporationViewModel>();
  File? _pickedFirstImage;
  File? _pickedSecondImage;
  File? _pickedThridImage;
  // File? _pickedBackImage;

  Future<void> pickImage(int n) async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (imageFile != null) {
      if (n == 1) {
        setState(() {
          _pickedFirstImage = File(imageFile.path);
        });
      } else if (n == 2) {
        setState(() {
          _pickedSecondImage = File(imageFile.path);
        });
      } else {
        setState(() {
          _pickedThridImage = File(imageFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getHeight(context, 0.02),
                customAppBar(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    context: context,
                    onTap: () {
                      Get.back();
                    },
                    title: 'Confirm Verification'),
                getHeight(context, 0.1),
                Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 5,
                  spacing: 5,
                  children: [
                    inCoporationUploadTile(
                      isLoading: false,
                      image: _pickedFirstImage,
                      onTap: () {
                        setState(() {
                          _pickedFirstImage = null;
                        });
                        pickImage(1);
                      },
                    ),
                    inCoporationUploadTile(
                      isLoading: false,
                      image: _pickedSecondImage,
                      onTap: () {
                        setState(() {
                          _pickedSecondImage = null;
                        });
                        pickImage(2);
                      },
                    ),
                    inCoporationUploadTile(
                      isLoading: false,
                      image: _pickedThridImage,
                      onTap: () {
                        setState(() {
                          _pickedThridImage = null;
                        });
                        pickImage(3);
                      },
                    ),
                  ],
                ),
                getHeight(context, 0.008),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      style: textStyle(
                          context: context,
                          color: const Color(0xFF6D6E6F).withOpacity(0.6),
                          fontWeight: FontWeight.w400),
                      text: "Please Take photo of your "),
                  TextSpan(
                      style: textStyle(
                          color: AppColor.facebookColor, context: context),
                      text:
                          "Certificate of In Corporation, Artificial of Association "),
                  TextSpan(
                      style: textStyle(
                          context: context,
                          color: const Color(0xFF6D6E6F).withOpacity(0.6),
                          fontWeight: FontWeight.w400),
                      text: "and "),
                  TextSpan(
                      style: textStyle(
                          color: AppColor.facebookColor, context: context),
                      text: "Member of Association.")
                ])),
                getHeight(context, 0.034),
                Row(
                  children: [
                    Expanded(
                      child: textButton(
                        onClick: () async {
                          // _pickedImage == null ?_pickAndCropImage : null;
                        },
                        context: context,
                        title: 'Next',
                      ),
                    ),
                  ],
                ),
                getHeight(context, 0.090),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
