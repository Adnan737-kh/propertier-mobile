import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Vendor/screens/drawer/VendorForm/VendorFormController.dart';
import 'package:propertier/Vendor/screens/drawer/VendorForm/model/VendorFormModal.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

class VendorForm extends GetView<VendorFormController> {
  const VendorForm({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: controller.getMyData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<VendorFormModal> items = snapshot.data ?? [];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              VendorFormModal vendorFormModal = items[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        title: vendorFormModal
                                                .requirementDetails
                                                ?.fieldName ??
                                            "",
                                        fontWeight: FontWeight.w600),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    vendorFormModal.value is List
                                        ? vendorFormModal.value.isEmpty
                                            ?  Text(context.local.no_images_selected)
                                            : Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                children: vendorFormModal.value
                                                    .map<Widget>((imagePath) =>
                                                        Stack(
                                                          alignment: Alignment
                                                              .topRight,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child:
                                                                  Image.network(
                                                                imagePath,
                                                                width: 80,
                                                                height: 80,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder:
                                                                    (context,
                                                                        obj,
                                                                        track) {
                                                                  return const SizedBox();
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ))
                                                    .toList(),
                                              )
                                        : Text(vendorFormModal.value.toString())
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                    return const SizedBox();
                  })),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.editVendorForm,
                  arguments: controller.items);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: Get.size.width,
              height: Get.height * .071,
              decoration: ShapeDecoration(
                color: const Color(0xFFFDCD54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:  Center(
                child: Text(
                  context.local.edit_data,
                  style: const TextStyle(
                    color: Color(0xFF131A22),
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
