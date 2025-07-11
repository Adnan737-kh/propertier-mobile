import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/About/View/about_view.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/app_text.dart';
import '../../../../Utils/height_width_box.dart';
import 'add_property_checkbox.dart';

Widget addPropertyFacilities({
  required AddPropertiesViewModel controller,
  required BuildContext context,
}) {
  return Column(
    children: [
      CustomText(title: context.local.facilities, fontSize: 18),
      getHeight(context, 0.015),
      Obx((){
        if (controller.featuresList.value.data == null) {
          return const Center(child: CircularProgressIndicator()); // Show loading indicator
        }
        if (controller.featuresList.value.data!.features.isEmpty) {
          return  Center(child: Text(context.local.no_features_available));
        }
        return Wrap(
          direction: Axis.horizontal,
          children: List.generate(
              controller.featuresList.value.data!.features.length,
                  (index) => SizedBox(
                width: context.getSize.width * 0.4,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CustomCheckBox(
                    type: MyCheckboxType.none,
                    title: controller.featuresList.value.data!
                        .features[index].name!,
                    value: controller.selectedFacilities.contains(
                        controller.featuresList.value.data!
                            .features[index].id),
                    onChanged: (value) => value != false
                        ? controller.selectedFacilities.add(
                        controller.featuresList.value.data!
                            .features[index].id!)
                        : controller.selectedFacilities.remove(
                        controller.featuresList.value.data!
                            .features[index].id),
                  ),
                ),
              )).toList(),
        );

      })
    ],
  );
}
