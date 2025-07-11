import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/SubServices/ViewModel/SubServiceModel.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/app_text.dart';
import '../../../Utils/border.dart';
import '../../../Utils/box_shadow.dart';
import '../../../Utils/height_width_box.dart';
import '../../../constant/colors.dart';
import '../../Services/Model/services_model.dart';

class SubService extends GetView<SubServiceViewModel> {
  const SubService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: AppColor.blackColor)),
        title: Text(
          controller.parentServicesModel.title ?? "",
          style: const TextStyle(color: AppColor.blackColor),
        ),
      ),
      body: controller.parentServicesModel.subServices == null ||
              controller.parentServicesModel.subServices!.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No Service Available"),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.waterServiceForm);
                      },
                      child: const Text("Water Provider")),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.propertyServiceForm);
                      },
                      child: const Text("Property Related Service")),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.houseWorkForm);
                      },
                      child: const Text("Kitchen Expert")),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: context.getSize.height * 0.18,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: controller.parentServicesModel.subServices?.length,
                  itemBuilder: (context, index) {
                    Subservices subService =
                        controller.parentServicesModel.subServices![index];
                    return GestureDetector(
                      onTap: () {
                        if (controller.parentServicesModel.title ==
                            "Transport") {
                          Get.toNamed(AppRoutes.transportServiceForm);
                        } else if (controller.parentServicesModel.title ==
                            "Water Provider") {
                          Get.toNamed(AppRoutes.waterServiceForm);
                        } else {
                          Get.toNamed(AppRoutes.servicesSearchView, arguments: {
                            'parentServiceModel':
                                controller.parentServicesModel,
                            'subService': subService
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: border(),
                            boxShadow: [boxShadow()],
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Image.network(
                              subService.iconUrl ?? "",
                              height: context.getSize.height * 0.12,
                            ),
                            getHeight(context, 0.005),
                            CustomText(
                                title: subService.title ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
