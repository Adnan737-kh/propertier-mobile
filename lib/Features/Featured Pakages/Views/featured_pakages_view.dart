import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
// import 'package:json_serializable/type_helper.dart';
import 'package:propertier/Features/Featured%20Pakages/Controller/featured_pakages_controller.dart';
import 'package:propertier/Features/SelectFeatuedType/Controller/select_featued_type_controller.dart';
import 'package:propertier/Utils/Shimmer/shimmer_effect.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/divider.dart';
import '../../../Utils/height_width_box.dart';
import '../../../constant/colors.dart';

// ignore: must_be_immutable
class FeaturedPakagesView extends StatelessWidget {
  FeaturedPakagesView({super.key});

  var selectedIndex = 0.obs;
  final controller = Get.put(FeaturedPakagesController());

  @override
  Widget build(BuildContext context) {
    return selectDurationMethod(context);
  }

  Obx selectDurationMethod(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Column(
            children: List.generate(
                3,
                (i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ShimmerEffect(
                          child: Container(
                        height: 50,
                        color: AppColor.darkBack,
                        width: context.width,
                      )),
                    )),
          )
        : Column(
            children:
                List.generate(controller.featuredPakages.length, (int index) {
            if (controller.featuredPakages[index].status == "active") {
              if (Get.find<SelectFeatuedTypeController>()
                          .selectedFeaturedType
                          .value ==
                      'Feature Ad' &&
                  controller.featuredPakages[index].priorityType == 'normal') {
                return selectDurationAd(
                  context: context,
                  dueration: formatDaysOnlyFromString(
                      controller.featuredPakages[index].featureDuration!),
                  pkr: controller.featuredPakages[index].price!,
                  days: controller.featuredPakages[index].title!,
                  isVerification: false,
                  isVerificationAvil: false,
                  selectDays: selectedIndex.value == index,
                  onChangedRadio: (p0) {},
                  onChanged: (v) {
                    selectedIndex.value = index;
                    controller.selectedFeaturedPakages.value =
                        controller.featuredPakages[index];
                  },
                );
              } else if (Get.find<SelectFeatuedTypeController>()
                          .selectedFeaturedType
                          .value ==
                      'Blazing Ad' &&
                  controller.featuredPakages[index].priorityType == 'blazing') {
                return selectDurationAd(
                  context: context,
                  dueration: formatDaysOnlyFromString(
                      controller.featuredPakages[index].featureDuration!),
                  pkr: controller.featuredPakages[index].price!,
                  days: controller.featuredPakages[index].title!,
                  isVerification: false,
                  isVerificationAvil: false,
                  selectDays: selectedIndex.value == index,
                  onChangedRadio: (p0) {},
                  onChanged: (v) {
                    selectedIndex.value = index;
                    controller.selectedFeaturedPakages.value =
                        controller.featuredPakages[index];
                  },
                );
              } else if (Get.find<SelectFeatuedTypeController>()
                          .selectedFeaturedType
                          .value ==
                      'Banner Ad' &&
                  controller.featuredPakages[index].priorityType == 'slider') {
                return selectDurationAd(
                  context: context,
                  dueration: formatDaysOnlyFromString(
                      controller.featuredPakages[index].featureDuration!),
                  pkr: controller.featuredPakages[index].price!,
                  days: controller.featuredPakages[index].title!,
                  isVerification: false,
                  isVerificationAvil: false,
                  selectDays: selectedIndex.value == index,
                  onChangedRadio: (p0) {},
                  onChanged: (v) {
                    selectedIndex.value = index;
                    controller.selectedFeaturedPakages.value =
                        controller.featuredPakages[index];
                  },
                );
              } else {
                return const Gap(0);
              }
            } else {
              return const Gap(0);
            }
          })));
  }

  Column selectDurationAd({
    required BuildContext context,
    required String days,
    required String pkr,
    required String dueration,
    required bool selectDays,
    required void Function(bool?)? onChanged,
    required void Function(bool?)? onChangedRadio,
    bool isVerification = true,
    required bool isVerificationAvil,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  activeColor: AppColor.buttonColor,
                  value: selectDays,
                  onChanged: onChanged,
                ),
                const Gap(4),
                appText(title: days, context: context, colorOpecity: 0.6),
              ],
            ),
            appText(
                title: "$pkr PKR",
                context: context,
                color: AppColor.facebookColor),
          ],
        ),
        Row(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Gap(50),
            appText(
                title: "For Duration : $dueration Days",
                context: context,
                colorOpecity: 0.5)
          ],
        ),
        getHeight(context, 0.015),
        divider(context: context, withOpacity: 0.1)
      ],
    );
  }

  String formatDaysOnlyFromString(String durationString) {
    // Split the string based on spaces and colons
    List<String> parts = durationString.split(' ');

    // Extract the number of days
    String days = parts[0]; // The first part contains the number of days

    // Format the string as "days 00:00:00"
    String formattedTime = "$days";
    return formattedTime;
  }
}
