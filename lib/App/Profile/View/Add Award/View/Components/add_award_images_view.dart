import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../Utils/app_text.dart';
import '../../../../../../Utils/height_width_box.dart';
import '../../../../../../constant/colors.dart';
import '../../ViewModel/add_award_viewmolel.dart';

class AddAwardImageView extends StatefulWidget {
  const AddAwardImageView({super.key});

  @override
  State<AddAwardImageView> createState() => _AddAwardImageViewState();
}

class _AddAwardImageViewState extends State<AddAwardImageView> {
  File? _pickedFrontImage;
  var vm = Get.find<AddAwardViewModel>();

  Future<void> pickImage(bool front) async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (imageFile != null) {
      if (front) {
        setState(() {
          _pickedFrontImage = File(imageFile.path);
          vm.image = _pickedFrontImage!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              title: "File",
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
        getHeight(context, 0.015),
        iDUploadTile(
          isLoading: false,
          image: _pickedFrontImage,
          onTap: () {
            setState(() {
              _pickedFrontImage = null;
            });
            pickImage(true);
          },
        ),
        getHeight(context, 0.015),
      ],
    );
  }
}

Widget iDUploadTile({required bool isLoading, File? image, Function()? onTap}) {
  var context = Get.context!;
  return GestureDetector(
    onTap: onTap,
    child: DottedBorder(
      stackFit: StackFit.loose,
      padding: const EdgeInsets.all(0),
      radius: const Radius.circular(5),
      dashPattern: const [7, 7],
      borderType: BorderType.RRect,
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),

          // color: AppColor.darkGreyColor.withOpacity(.3)
        ),
        child: image == null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      color: AppColor.darkGreyColor.withOpacity(0.5),
                      size: 38,
                    ),
                    CustomText(
                        title: "Upload File Here",
                        fontSize: 16,
                        colorOpecity: 0.5,
                        color: AppColor.darkGreyColor,
                        fontWeight: FontWeight.bold),
                  ],
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  image,
                  fit: BoxFit.fill,
                )),
      ),
    ),
  );
}
