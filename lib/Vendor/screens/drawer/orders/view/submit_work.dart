import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:propertier/Vendor/screens/drawer/orders/viewmodel/OrderViewModel.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../../../App/ServicesSearch/View/component/description_text_field.dart';
import '../../../../../Utils/app_text.dart';
import '../../../../../Utils/divider.dart';
import '../../../../../Utils/height_width_box.dart';
import '../../../../../Utils/text_botton.dart';
import '../../../../../constant/colors.dart';
import '../components/components.dart';

class SubmitWork extends StatefulWidget {
  const SubmitWork({super.key, required this.id});
  final String id;
  @override
  State<SubmitWork> createState() => _SubmitWorkState();
}

class _SubmitWorkState extends State<SubmitWork> {


  OrderViewModel controller = Get.put(OrderViewModel());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getHeight(context, 0.01),
                  divider(
                      context: context,
                      color: AppColor.blackColor.withOpacity(0.75)),
                  getHeight(context, 0.015),
                  CustomText(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      title: context.local.upload_work_photo,
                      ),
                  getHeight(context, 0.008),
                  const UploadWorkPhotosWidget(),
                  getHeight(context, 0.015),
                  CustomText(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      title: context.local.description_about_your_work,
                      ),
                  getHeight(context, 0.008),
                  DescriptionTextField(
                    descriptionController:
                    controller.descriptionController,
                  ),
                  getHeight(context, 0.015),
                  const CustomText(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      title: "Extra price",
                      ),
                  getHeight(context, 0.008),
                  DescriptionTextField(
                    descriptionController:
                    controller.extraPriceC,
                    hintText: "Enter extra price is have.",
                  ),
                  getHeight(context, 0.024),
                  textButton(
                      textFontSize: 20,
                      textFontWeight: FontWeight.w500,
                      context: context,
                      title: 'Submit Work',
                      onClick: () {
                        if (kDebugMode) {
                          print(widget.id);
                          print(controller.imageFileList.length);
                          print(controller.descriptionController.text);
                          print(controller.extraPriceC.text);
                        }

                        controller.submitWork(context, widget.id);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
