import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Offered%20Services/ViewModel/offered_services_viewmodel.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/appbar.dart';
import '../../../Utils/box_shadow.dart';
import '../../../Utils/height_width_box.dart';
import '../../../Utils/textStyle.dart';

class OfferedServiceView extends GetView<OfferedServicesViewModel> {
  const OfferedServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.oSFormKey,
            child: Column(
              children: [
                getHeight(context, 0.090),
                customAppBar(
                    context: context,
                    title: "Offered Services",
                    onTap: () {
                      Get.back();
                    }),
                getHeight(context, 0.045),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: controller.serviceController,
                    validator: (value) {
                      if (value!.isEmpty || value == "") {
                        return "Please Write service name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Add Your Service",
                        hintStyle: textStyle(
                            context: context, fontSize: 14, withOpacity: 0.2),
                        suffix: GestureDetector(
                          onTap: () {
                            if (controller.oSFormKey.currentState!.validate()) {
                              controller.services
                                  .add(controller.serviceController.text);
                              controller.serviceController.text = "";
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                                color: AppColor.greenColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: appText(
                              title: "Add",
                              context: context,
                              color: AppColor.white,
                            ),
                          ),
                        )),
                  ),
                ),
                getHeight(context, 0.009),
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      boxShadow: [boxShadow()],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        width: context.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            boxShadow: [boxShadow()],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Center(
                          child: appText(title: "Plumber", context: context),
                        ),
                      ),
                      Obx(() => Wrap(
                            direction: Axis.horizontal,
                            children: controller.services
                                .map((service) => Container(
                                      decoration: const BoxDecoration(
                                          border: Border(bottom: BorderSide())),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 9, vertical: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          appText(
                                              title: service,
                                              context: context,
                                              colorOpecity: 0.6),
                                          GestureDetector(
                                            onTap: () {
                                              controller.services
                                                  .remove(service);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                  color: AppColor.greenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: appText(
                                                title: "Remove",
                                                context: context,
                                                color: AppColor.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )),
                      Container(
                        width: context.width,
                        height: 21,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            boxShadow: [boxShadow()],
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
