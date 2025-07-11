import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Rental/Components/rental_facilities.dart';
import 'package:propertier/App/Rental/Components/rental_location.dart';
import 'package:propertier/App/Rental/Components/rental_property_info.dart';
import 'package:propertier/App/Rental/ViewModel/rental_viewmodel.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/appbar.dart';
import '../../../Utils/box_shadow.dart';
import '../../../Utils/height_width_box.dart';
import '../../../Utils/text_botton.dart';
import '../Components/rental_cutom_btn.dart';
import '../Components/rental_inspector_report.dart';

class RentalView extends GetView<RentalViewModel> {
  const RentalView({super.key});

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
                getHeight(context, 0.060),
                customAppBar(
                  context: context,
                  onTap: () {
                    Get.back();
                  },
                  title: context.local.rental,
                ),
                Image.asset(
                  Constant.onboardingIcon,
                  height: context.getSize.height * 0.03,
                ),
                getHeight(context, 0.045),
                rentalCustomButton(
                    title: context.local.rent_For_Me,
                    buttonColor: AppColor.greenColor,
                    onTap: () {}),
                getHeight(context, 0.008),
                GestureDetector(
                  onTap: () {},
                  child: CustomText(
                      title: context.local.post_your_property,
                      color: AppColor.facebookColor,
                      ),
                ),
                getHeight(context, 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(title:context.local.title, fontSize: 18),
                  ],
                ),
                getHeight(context, 0.008),
                CustomAddTextField(
                  textEditingController: controller.titleController,
                  border: InputBorder.none,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.local.please_enter_title;
                    }
                    return null;
                  },
                ),
                getHeight(context, 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                        title: context.local.description, fontSize: 18),
                  ],
                ),
                getHeight(context, 0.008),
                CustomAddTextField(
                  textEditingController: controller.descriptionController,
                  border: InputBorder.none,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.local.provide_description;
                    }
                    return null;
                  },
                ),
                getHeight(context, 0.015),
                locations(controller: controller, context: context),
                getHeight(context, 0.017),
                rentalPropertyInfo(controller: controller, context: context),
                getHeight(context, 0.015),
                rentalFacilities(controller: controller, context: context),
                getHeight(context, 0.015),
                const InspectReportView(),
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
                          title: context.local.submit,
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

class CustomAddTextField extends StatelessWidget {
  const CustomAddTextField({
    super.key,
    this.labelText,
    required this.textEditingController,
    this.height = 0.1,
    this.validator,
    this.border,
    this.color,
    this.isShadowless,
  });

  final String? labelText;
  final TextEditingController textEditingController;
  final double? height;
  final String? Function(String?)? validator;
  final InputBorder? border;
  final Color? color;
  final bool? isShadowless;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: height != null
            ? context.getSize.height * height!
            : context.getSize.height * 0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color ?? AppColor.white,
            boxShadow: isShadowless == null ? [] : [boxShadow()]),
        child: TextFormField(
            maxLength: null,
            maxLines: null,
            decoration: InputDecoration(
              border: border,
              labelText: labelText,
            ),
            controller: textEditingController,
            validator: validator),
      ),
    );
  }
}
