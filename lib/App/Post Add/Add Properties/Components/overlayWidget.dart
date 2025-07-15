import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class OverlayWidget extends StatelessWidget {
  final vm = Get.put(UploadPropertyViewModel());

  OverlayWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        height: context.getSize.height * 0.07,
        width: context.getSize.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: context.local.uploading_property,),
                progressText(vm.progress, context)
              ],
            ),
            const Spacer(),
            loadingProgress(vm.progress, context)
          ],
        ),
      ),
    );
  }

  Obx progressText(RxDouble progress, BuildContext context) {
    return Obx(() {
      return CustomText(
          title: '${(progress.value * 100).toInt()} %');
    });
  }

  Widget loadingProgress(RxDouble progress, BuildContext context) {
    // print("Progress Value ${progress.value}");
    return Obx(() {
      return SizedBox(
        height: 2,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 2,
              width: context.getSize.width * 1,
              decoration: BoxDecoration(
                color: AppColor.darkGreyColor.withOpacity(0.3),
              ),
            ),
            Container(
              height: 2,
              width: context.getSize.width * progress.value,
              decoration: const BoxDecoration(
                color: AppColor.blueColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}
