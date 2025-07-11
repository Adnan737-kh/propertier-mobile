import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:propertier/App/ServicesReview/View/component/services_review_textfield.dart';
import 'package:propertier/App/ServicesReview/ViewModel/services_review_view_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class ServicesReviewView extends StatelessWidget {
  const ServicesReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ServicesReviewViewModel>(
          init: ServicesReviewViewModel(),
          builder: (viewModel) {
            return ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.09),
              children: [
                getHeight(context, 0.1),
                CustomText(
                    title: context.local.satisfied_withwork,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                getHeight(context, 0.01),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.changeSelectedselectedsatisfiedWorkIndex(0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: context.getSize.width * 0.12,
                              vertical: context.getSize.height * 0.005),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: border(color: const Color(0xffC10C00)),
                              color: viewModel.selectedsatisfiedWorkIndex == 0
                                  ? const Color(0xffC10C00)
                                  : null),
                          child: CustomText(
                              title: context.local.no,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: viewModel.selectedsatisfiedWorkIndex == 0
                                  ? AppColor.white
                                  : const Color(0xffC10C00)),
                        ),
                      ),
                    ),
                    getWidth(context, 0.022),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.changeSelectedselectedsatisfiedWorkIndex(1);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: context.getSize.width * 0.12,
                              vertical: context.getSize.height * 0.005),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: border(color: AppColor.greenColor),
                              color: viewModel.selectedsatisfiedWorkIndex == 1
                                  ? AppColor.greenColor
                                  : null),
                          child: CustomText(
                              title: context.local.yes,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: viewModel.selectedsatisfiedWorkIndex == 1
                                  ? AppColor.white
                                  : AppColor.greenColor),
                        ),
                      ),
                    ),
                  ],
                ),
                getHeight(context, 0.015),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      title: context.local.work_Completed,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                getHeight(context, 0.008),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      title: context.local.receive_work_from_Vendor,
                      fontSize: 14,
                      colorOpecity: 0.8,
                      fontWeight: FontWeight.w500),
                ),
                getHeight(context, 0.008),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.changeWorkFromVandorIndex(0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: context.getSize.width * 0.12,
                              vertical: context.getSize.height * 0.005),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: border(color: const Color(0xffC10C00)),
                              color: viewModel.workFromVandorIndex == 0
                                  ? const Color(0xffC10C00)
                                  : null),
                          child: CustomText(
                              title: context.local.no,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: viewModel.workFromVandorIndex == 0
                                  ? AppColor.white
                                  : const Color(0xffC10C00)),
                        ),
                      ),
                    ),
                    getWidth(context, 0.022),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.changeWorkFromVandorIndex(1);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: context.getSize.width * 0.12,
                              vertical: context.getSize.height * 0.005),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: border(color: AppColor.greenColor),
                              color: viewModel.workFromVandorIndex == 1
                                  ? AppColor.greenColor
                                  : null),
                          child: CustomText(
                              title: context.local.yes,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: viewModel.workFromVandorIndex == 1
                                  ? AppColor.white
                                  : AppColor.greenColor),
                        ),
                      ),
                    ),
                  ],
                ),
                getHeight(context, 0.015),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      title: context.local.experience_with_Vendor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                getHeight(context, 0.008),
                ServicesReviewTextField(
                    textEditingController:
                        viewModel.servicesReviewCommentController),
                getHeight(context, 0.015),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      title: context.local.give_Rating_to_Vendor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                getHeight(context, 0.008),
                Align(
                  alignment: Alignment.center,
                  child: RatingBarIndicator(
                    rating: 4,
                    unratedColor: const Color(0xffD9D9D9),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: context.getSize.width * 0.1,
                    direction: Axis.horizontal,
                  ),
                ),
                getHeight(context, 0.08),
                textButton(
                    context: context,
                    title: context.local.done,
                    onClick: () {
                      Get.offAllNamed(AppRoutes.servicesView);
                    })
              ],
            );
          }),
    );
  }
}
