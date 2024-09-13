import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:propertier/App/Rental/ViewModel/rental_viewmodel.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/divider.dart';
import '../../../Utils/height_width_box.dart';
import 'rental_dropdown.dart';

Widget rentalPropertyInfo({
  required RentalViewModel controller,
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
      divider(context: context),
      getHeight(context, 0.015),
      Row(
        children: [
          Expanded(
              child: rentalDropdown(
            context: context,
            title: "Bedrooms",
            items: controller.bedrooms
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select How Many';
              }
              return null;
            },
          )),
          const Gap(5),
          Expanded(
              child: rentalDropdown(
            context: context,
            title: "Bathrooms",
            items: controller.bathrooms
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select How Many';
              }
              return null;
            },
          )),
          const Gap(5),
          Expanded(
              child: rentalDropdown(
            context: context,
            title: "Floors",
            items: controller.floors
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select How Many';
              }
              return null;
            },
          )),
        ],
      ),
    ],
  );
}
