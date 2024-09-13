import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Post%20Add/Add%20Material/Views/component/add_post_text_field.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/constant.dart';
import '../../../Rental/Components/rental_cutom_btn.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../Utils/text_botton.dart';
import '../Components/material_inspector_report.dart';
import '../ViewModel/add_material_viewmodel.dart';

class AddMaterialView extends GetView<AddMaterialViewModel> {
  const AddMaterialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                getHeight(context, 0.050),
                customAppBar(
                  context: context,
                  onTap: () {
                    Get.back();
                  },
                ),
                getHeight(context, 0.045),
                Image.asset(
                  Constant.onboardingIcon,
                  height: context.getSize.height * 0.03,
                ),
                getHeight(context, 0.045),
                rentalCustomButton(
                    title: context.local.material,
                    buttonColor: AppColor.greenColor,
                    onTap: () {}),
                getHeight(context, 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    appText(title: "Title", context: context, fontSize: 18),
                  ],
                ),
                getHeight(context, 0.008),
                AddPostTextField(
                  textEditingController: controller.titleController,
                  validatorCallback: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Title';
                    }
                    return null;
                  },
                ),
                getHeight(context, 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    appText(
                        title: "Description", context: context, fontSize: 18),
                  ],
                ),
                getHeight(context, 0.008),
                AddPostTextField(
                  height: 0.1,
                  textEditingController: controller.descriptionController,
                  validatorCallback: (value) {
                    if (value.isEmpty) {
                      return 'Provide Description';
                    }
                    return null;
                  },
                ),
                getHeight(context, 0.015),
                Row(
                  children: [
                    Expanded(
                      child: AddPostTextField(
                        bgColor: Colors.transparent,
                        isBorder: true,
                        isExpanded: false,
                        paddingHorizontal: 0,
                        labelText: "Price",
                        // decoration: const InputDecoration(labelText: "Price"),
                        textEditingController: controller.priceController,
                        validatorCallback: (value) {
                          if (value.isEmpty) {
                            return 'Provide Price';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(52),
                    Expanded(
                      child: AddPostTextField(
                        bgColor: Colors.transparent,
                        isBorder: true,
                        isExpanded: false,
                        paddingHorizontal: 0,
                        labelText: "Units",
                        // decoration: const InputDecoration(labelText: "Units"),
                        textEditingController: controller.unitsController,
                        validatorCallback: (value) {
                          if (value.isEmpty) {
                            return 'Provide Units';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                getHeight(context, 0.015),
                Row(
                  children: [
                    Expanded(
                      child: AddPostTextField(
                        bgColor: Colors.transparent,
                        isBorder: true,
                        isExpanded: false,
                        paddingHorizontal: 0,
                        labelText: "Location",
                        // decoration:
                        //     const InputDecoration(labelText: "Location"),
                        textEditingController: controller.priceController,
                        validatorCallback: (value) {
                          if (value.isEmpty) {
                            return 'Provide Location';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                getHeight(context, 0.034),
                const MaterialInspectReportView(),
                getHeight(context, 0.016),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: textButton(
                          onClick: () async {
                            if (controller.formKey.currentState!.validate()) {}
                          },
                          context: context,
                          title: 'Post',
                        ),
                      ),
                    ],
                  ),
                ),
                getHeight(context, 0.016),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
