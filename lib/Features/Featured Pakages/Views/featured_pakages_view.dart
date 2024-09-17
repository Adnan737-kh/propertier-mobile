import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Features/Featured%20Pakages/Controller/featured_pakages_controller.dart';
import 'package:propertier/Utils/Shimmer/shimmer_effect.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/divider.dart';
import '../../../Utils/height_width_box.dart';
import '../../../constant/colors.dart';

// ignore: must_be_immutable
class FeaturedPakagesView extends StatelessWidget {
  FeaturedPakagesView({super.key, this.onChanged, this.selectedIndex = 0});
  void Function(bool?)? onChanged;
  int selectedIndex;
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
            return controller.featuredPakages[index].status == "active"
                ? selectDurationAd(
                    context: context,
                    Pkr: controller.featuredPakages[index].price!,
                    days: controller.featuredPakages[index].title!,
                    isVerification: false,
                    isVerificationAvil: false,
                    selectDays: false,
                    onChangedRadio: (p0) {},
                    onChanged: (p0) {},
                  )
                : const Gap(0);
          })));
  }

  Column selectDurationAd({
    required BuildContext context,
    required String days,
    required String Pkr,
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
                title: "$Pkr PKR",
                context: context,
                color: AppColor.facebookColor),
          ],
        ),
        isVerificationAvil
            ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Gap(40),
                  Radio(
                    toggleable: true,
                    activeColor: AppColor.buttonColor,
                    value: isVerification,
                    groupValue: true,
                    onChanged: onChangedRadio,
                  ),
                  // const Gap(4),
                  Expanded(
                    child: appText(
                        title:
                            "Propertier property evaluation and verification.",
                        context: context,
                        colorOpecity: 0.5),
                  )
                ],
              )
            : const Gap(0),
        getHeight(context, 0.015),
        divider(context: context, withOpacity: 0.1)
      ],
    );
  }
}
