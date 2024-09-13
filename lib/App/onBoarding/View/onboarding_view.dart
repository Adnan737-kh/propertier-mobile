import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/App/onBoarding/ViewModel/onboarding_view_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

class OnBoardingView extends GetView<OnBoardingViewModel> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<OnBoardingViewModel>(builder: (controller) {
        return SafeArea(
          child: SizedBox(
            height: context.getSize.height,
            width: context.getSize.width,
            child: Column(
              children: [
                SizedBox(
                  height: context.getSize.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(
                          AppRoutes.navBarView,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColor.buttonColor)),
                        child: appText(
                            title: 'Skip', context: context, fontSize: 16),
                      ),
                    ),
                    const Gap(20)
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // appText(title: '    ', context: context),
                    Image.asset(
                      Constant.onboardingIcon,
                      height: context.getSize.height * 0.043,
                    ),
                  ],
                ),
                SizedBox(
                  height: context.getSize.height * 0.030,
                ),
                SizedBox(
                  height: Platform.isIOS
                      ? context.getSize.height * 0.55
                      : context.getSize.height * 0.6,
                  width: context.getSize.width * 0.8,
                  child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: (val) {
                        controller.changeSelectedPageIndex(val);
                        print(controller.selectedPageIndex);
                      },
                      itemCount: controller.onBoardingList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: context.getSize.height * 0.58,
                          width: context.getSize.width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                    controller.onBoardingList[index].imageUrl,
                                  ),
                                  fit: BoxFit.cover)),
                        );
                      }),
                ),
                getHeight(context, 0.02),
                textButton(
                        textFontWeight: FontWeight.bold,
                        context: context,
                        title: "Next",
                        onClick: () {
                          for (int i = 0;
                              i < controller.onBoardingList.length;
                              i++) {
                            if (controller.selectedPageIndex == i) {
                              controller.pageController.animateToPage(i + 1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linearToEaseOut);
                            }
                            if (controller.selectedPageIndex == 3 && i == 3) {
                              Get.offAllNamed(AppRoutes.navBarView);
                            }
                          }
                        })
                    .paddingSymmetric(horizontal: context.getSize.width * 0.3),
                SizedBox(
                  height: context.getSize.height * 0.020,
                ),
                appText(
                    title: controller
                        .onBoardingList[controller.selectedPageIndex].title,
                    context: context),
                SizedBox(
                  height: context.getSize.height * 0.020,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      controller.onBoardingList.length,
                      (index) => Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: context.getSize.width * 0.010),
                            height: context.getSize.height * 0.010,
                            width: context.getSize.width * 0.020,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.selectedPageIndex == index
                                    ? AppColor.forgroundColor
                                    : AppColor.primaryColor.withOpacity(0.2)),
                          )),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
