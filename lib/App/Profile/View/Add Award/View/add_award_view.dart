import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/App/Profile/View/Add%20Award/ViewModel/add_award_viewmolel.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/App/What%20are%20you%20searching/View/Components/custom_botton_wryf.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/toast.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../../Utils/height_width_box.dart';
import '../../../../../Utils/textStyle.dart';
import 'Components/add_award_images_view.dart';

class AddAwardView extends GetView<AddAwardViewModel> {
  const AddAwardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.060),
              decoration: const BoxDecoration(
                  color: AppColor.buttonColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  getHeight(context, 0.060),
                  Row(
                    children: [
                      customAppBar(
                          context: context,
                          onTap: () => Get.back(),
                          title: "Add Award",
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                  getHeight(context, 0.025),
                  appText(
                      title: "Add Award Information",
                      color: AppColor.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      context: context),
                  getHeight(context, 0.015),
                ],
              ),
            ),
            getHeight(context, 0.025),
            appText(
                title: "Please Upload your information for propertier account.",
                // color: AppColor.blackColor,
                colorOpecity: 0.6,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                context: context),
            getHeight(context, 0.025),
            additionalDetailsWRYSF(context, controller),
            getHeight(context, 0.025),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.030),
              child: Obx(
                () => controller.isSuccess == true
                    ? customButton(
                        fontSize: 16,
                        buttonColor: AppColor.buttonColor,
                        textColor: AppColor.blackColor,
                        fontWeight: FontWeight.bold,
                        title: "Submit",
                        onTap: () async {
                          if (controller.selectedStringDate == '') {
                            toast(
                                title: 'Please select award date and time',
                                context: context);
                          } else {
                            await controller
                                .postAward(
                                    id: GetStorage().read("id").toString(),
                                    title: controller.titleController.text,
                                    dessrcption:
                                        controller.descriptionController.text,
                                    imageData: controller.image,
                                    context: context,
                                    date: controller.selectedDate.value!)
                                .whenComplete(() {
                              final vm = Get.put(ProfileViewModel());
                              vm.getProfilePageData(
                                  context: context,
                                  id: GetStorage().read('id').toString());
                            });
                          }
                        })
                    : const CircularProgressIndicator(
                        color: AppColor.buttonColor,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container additionalDetailsWRYSF(BuildContext context, AddAwardViewModel vm) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.getSize.width * 0.016),
      width: context.width,
      margin: EdgeInsets.symmetric(horizontal: context.getSize.width * 0.030),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.darkGreyColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getHeight(context, 0.010),
          textFieldWRYSF(
              context: context, hint: "Title:", controller: vm.titleController),
          getHeight(context, 0.010),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              // border: Border.all(color: ),

              color: AppColor.darkGreyColor.withOpacity(0.1),
              // borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => appText(
                    title: controller.selectedDate.value ?? "Select",
                    context: context)),
                InkWell(
                    onTap: () {
                      controller.chooseDate(context);
                    },
                    child: const Icon(Icons.date_range))
              ],
            ),
          ),
          getHeight(context, 0.010),
          textFieldWRYSF(
              context: context,
              hint: "Description:",
              expend: true,
              controller: vm.descriptionController),
          getHeight(context, 0.010),
          const AddAwardImageView(),
          getHeight(context, 0.010),
        ],
      ),
    );
  }

  Column textFieldWRYSF(
      {required BuildContext context,
      required String hint,
      bool? expend,
      TextEditingController? controller,
      Widget? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText(
            title: hint,
            context: context,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            colorOpecity: 0.7),
        getHeight(context, 0.004),
        SizedBox(
          height: expend != null ? context.height * 0.158 : null,
          child: TextFormField(
            controller: controller,
            maxLines: expend != null ? null : 1,
            expands: expend ?? false,
            style: textStyle(
              context: context,
              fontSize: 12,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                suffixIcon: suffix,
                fillColor: AppColor.darkGreyColor.withOpacity(0.1)),
          ),
        )
      ],
    );
  }
}
