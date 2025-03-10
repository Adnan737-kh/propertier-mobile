import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
// import 'package:video_player/video_player.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/height_width_box.dart';
import 'add_property_dropdown.dart';

Widget addPropertyInfo({
  required AddPropertiesViewModel controller,
  required BuildContext context,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          appText(
              title: "Property Information", context: context, fontSize: 18),
        ],
      ),
      getHeight(context, 0.015),
      Row(
        children: [
          Obx(() => Expanded(
                  child: addPropertyDropdown(
                enable: controller.selectedPropertyType.value != "Plots",
                onChange: (val) {
                  controller.selectedBedRoom.value = val!;
                },
                context: context,
                title: "Bedrooms",
                items: controller.bedrooms
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select How Many';
                  } else {}
                  return null;
                },
              ))),
          const Gap(5),
          Obx(() => Expanded(
                  child: addPropertyDropdown(
                enable: controller.selectedPropertyType.value != "Plots",
                onChange: (val) {
                  controller.selectedBathroom.value = val!;
                },
                context: context,
                title: "Bathrooms",
                items: controller.bathrooms
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select How Many';
                  } else {}
                  return null;
                },
              ))),
          const Gap(5),
          Obx(() => Expanded(
                  child: addPropertyDropdown(
                enable: controller.selectedPropertyType.value != "Plots",
                context: context,
                title: "Floors",
                onChange: (p0) {
                  controller.selectedFloors.value = p0!;
                },
                items: List.generate(
                    100,
                    (index) => DropdownMenuItem(
                        value: index.toString(),
                        child: Text(index.toString()))).toList(),
                // .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select How Many';
                  }
                  return null;
                },
              ))),
        ],
      ),
    ],
  );
}
