import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Rental/ViewModel/rental_viewmodel.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/height_width_box.dart';
import 'rental_checkbox.dart';

Widget rentalFacilities({
  required RentalViewModel controller,
  required BuildContext context,
}) {
  return Column(
    children: [
      CustomText(title: context.local.facilities, fontSize: 18),
      getHeight(context, 0.015),
      Obx(() => Wrap(
            direction: Axis.horizontal,
            children: controller.facilities
                .map((service) => SizedBox(
                      width: context.getSize.width * 0.4,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: CustomCheckBox(
                          type: MyCheckboxType.none,
                          title: service,
                          value:
                              controller.selectedFacilities.contains(service),
                          onChanged: (value) => value != false
                              ? controller.selectedFacilities.add(service)
                              : controller.selectedFacilities.remove(service),
                        ),
                      ),
                    ))
                .toList(),
          ))
    ],
  );
}
