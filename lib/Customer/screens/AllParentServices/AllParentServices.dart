import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Customer/screens/AllParentServices/AllParentServicesController.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../App/Services/Model/services_model.dart';
import '../../../RoutesAndBindings/app_routes.dart';
import '../../../constant/colors.dart';
import 'components/component.dart';

class AllParentServices extends GetView<AllParentServicesController> {
  const AllParentServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.blackColor,
            )),
        title: CustomText(title: context.local.services, ),
      ),
      body: Scaffold(
        body: FutureBuilder(
            future: controller.getAllParentServices(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.buttonColor,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                List<ParentServicesModel> services = snapshot.data ?? [];
                return GridView.builder(
                    padding: const EdgeInsets.all(0),
                    // physics:
                    //     const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: context.getSize.height * 0.18,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return servicesTile(
                        onTap: () {
                          Get.toNamed(AppRoutes.subServices,
                              arguments: services[index]);
                        },
                        service: services[index],
                        context: context,
                      );
                    });
              }
              return const SizedBox();
            }),
      ),
    );
  }
}
