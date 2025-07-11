import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

Row sellAndRentForMeButtons(BuildContext context,
    {required HomeViewModel viewModel}) {
  return Row(
    children: List.generate(viewModel.buttonTitle.length, (index) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            viewModel.buttonTitle[index] == context.local.rent_for_me
                ? Get.toNamed(AppRoutes.rentalView)
                : null;
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: context.getSize.height * 0.030,
            decoration: BoxDecoration(
                color: AppColor.greenColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.primaryColor,
                  width: 1,
                )),
            child: CustomText(
                title: viewModel.buttonTitle[index],
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.white),
          ),
        ),
      );
    }),
  );
}
