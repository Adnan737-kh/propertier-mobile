import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
import 'package:propertier/extensions/localization_extension.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../extensions/list_of_types.dart';
import 'add_property_dropdown.dart';

Widget addPropertyLocations({
  required AddPropertiesViewModel controller,
  required BuildContext context,
}) {
  return Column(
    children: [
      getHeight(context, 0.015),
      Row(
        children: [
          Expanded(
              child: addPropertyDropdown(
            onChange: (val) {
              controller.selectedArea.value = val!;
            },
            context: context,
            title: context.local.area_type,
            items: controller.areaType
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.local.select_area_type;
              } else {}
              return null;
            },
          )),
          const Gap(5),
          Expanded(
              child: addPropertyDropdown(
            onChange: (val) {
              controller.selectedPropertyType.value = val!;
            },
            context: context,
            title: context.local.property_type,
            items: ListOfTypes()
                .types
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.local.select_property_type;
              } else {}
              return null;
            },
          )),
          const Gap(5),
          Expanded(
              child: addPropertyDropdown(
            context: context,
            title: context.local.area_unit,
            onChange: (p0) {
              controller.selectAreaUnitType.value = p0!;
            },
            items: controller.areaUnitType
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.local.select_area_unit;
              }
              return null;
            },
          )),
        ],
      ),
    ],
  );
}
