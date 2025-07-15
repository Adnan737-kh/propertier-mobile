import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Vendor/screens/drawer/vehicle_list/controller/AddVehicleController.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/app_text.dart';
import '../../../../constant/colors.dart';
import '../../widgets/primary_textfield.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  late String vendorUserId;
  AddVehicleController controller = Get.put(AddVehicleController());

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    vendorUserId = box.read('vendorUserId') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: Get.size.width,
            height: Get.height * .124,
            padding: const EdgeInsets.only(top: 38, left: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFF131A22),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.black.withOpacity(0.05),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    context.local.add_new_transport,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      context.local.enter_vehicle_information,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Field: Make
                    PrimaryTextField(
                      controller: controller.makeController,
                      headertext: context.local.make,
                      text: 'Enter vehicle make (e.g., Toyota)',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF131A22),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Field: Model
                    PrimaryTextField(
                      controller: controller.modelController,
                      headertext: 'Model',
                      text: 'Enter vehicle model (e.g. Camry)',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF131A22),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Field: Year
                    PrimaryTextField(
                      controller: controller.yearController,
                      headertext: context.local.year,
                      text: 'Enter year of manufacture (e.g., 2020)',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF131A22),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field: Color
                    PrimaryTextField(
                      controller: controller.colorController,
                      headertext: context.local.color,
                      text: 'Enter color (e.g., Blue)',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF131A22),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field: Registration Number
                    PrimaryTextField(
                      controller: controller.registrationNumberController,
                      headertext: context.local.registration_number,
                      text: 'Enter registration number (e.g., ABC1234)',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF131A22),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field: Owner Name
                    PrimaryTextField(
                      controller: controller.ownerNameController,
                      headertext: context.local.owner_name,
                      text: 'Enter owner name (e.g., John Doe)',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF131A22),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field: Capacity
                    PrimaryTextField(
                      controller: controller.capacityController,
                      headertext: context.local.capacity,
                      text: 'Enter capacity (e.g., 5 passengers)',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF131A22),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Field: Fuel Type
                    PrimaryTextField(
                      controller: controller.fuelTypeController,
                      headertext: context.local.fuel_type,
                      text: 'Enter fuel type (e.g., Gasoline)',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF131A22),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Field: Transmission Type
                    PrimaryTextField(
                      controller: controller.transmissionTypeController,
                      headertext: context.local.transmission_type,
                      text: 'Enter transmission type (e.g., Automatic)',
                      suffixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF131A22),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Obx(
                      () => controller.galleryImage.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                controller.multiImagePick();
                              },
                              child: Container(
                                height: context.getSize.height * 0.2,
                                width: context.width * 0.8,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.black.withOpacity(0.4),
                                        size: 38,
                                      ),
                                      CustomText(
                                          title:
                                              context.local.pick_gallery_images,
                                          fontSize: 16,
                                          colorOpecity: 0.4,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: List.generate(
                                controller.galleryImage.length,
                                (index) => Container(
                                  height: context.getSize.height * 0.1,
                                  width: context.getSize.width * 0.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(controller.galleryImage[index]),
                                        ),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.3),
                                          BlendMode.colorBurn,
                                        ),
                                      )),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.removeImage(index);
                                    },
                                    child: const Icon(
                                      Icons.close_outlined,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),

                    const SizedBox(height: 24),

                    // Submit Button
                    InkWell(
                      onTap: () {
                        controller.submitForm(context, vendorUserId);
                      },
                      child: Container(
                        width: Get.size.width,
                        height: Get.height * .071,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFDCD54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            context.local.save,
                            style: const TextStyle(
                              color: Color(0xFF131A22),
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget buildTextFormField({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    ),
  );
}
