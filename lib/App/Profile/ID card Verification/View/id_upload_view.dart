import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/text_botton.dart';
import 'components/id_upload_tile.dart';

class IDUploadView extends StatefulWidget {
  const IDUploadView({super.key});

  @override
  State<IDUploadView> createState() => _IDUploadViewState();
}

class _IDUploadViewState extends State<IDUploadView> {
  // final iDCardVM = Get.find<IDVerficationViewModel>();
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
                  Gap(context.height * 0.1),
                  iDUploadTile(
                    isLoading: false,
                    image: _pickedFrontImage,
                    onTap: () {
                      setState(() {
                        _pickedBackImage = null;
                      });
                      pickImage(true);
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  appText(
                      title: "Please Take photo of your ID Card from front.",
                      context: context,
                      fontSize: 16,
                      color: const Color(0xFF6D6E6F),
                      fontWeight: FontWeight.bold),
                  const Gap(20),
                  //

                  iDUploadTile(
                    isLoading: false,
                    image: _pickedBackImage,
                    onTap: () {
                      setState(() {
                        _pickedBackImage = null;
                      });
                      pickImage(false);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  appText(
                      title: "Please Take photo of your ID Card from Back",
                      context: context,
                      fontSize: 16,
                      color: const Color(0xFF6D6E6F),
                      fontWeight: FontWeight.bold),
                  const SizedBox(
                    height: 80,
                  ),
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
