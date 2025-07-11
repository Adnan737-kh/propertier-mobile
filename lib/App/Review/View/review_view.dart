import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/About/View/about_view.dart';
import 'package:propertier/App/Review/Components/review_tile.dart';
import 'package:propertier/App/Review/ViewModel/review_viewmodel.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../Utils/appbar.dart';

class ReviewView extends StatelessWidget {
  ReviewView({super.key});
  final viewModel = Get.find<ReviewViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.060),
          child: Column(
            children: [
              Column(
                children: [
                  getHeight(context, 0.050),
                  customAppBar(
                      context: context,
                      onTap: () => Get.back(),
                      title: context.local.review,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  getHeight(context, 0.050),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: context.local.customer_reviews,),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                              color: AppColor.darkGreyColor.withOpacity(0.5),
                              blurRadius: 4,
                              offset: const Offset(-1, 0))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        children: [
                          CustomText(
                              title: context.local.this_month,
                              fontSize: 12),
                          const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              //Reviews
              reviewTile(title: "Ifthakar Thoker", context: context),
              reviewTile(title: "Sarmad", context: context),
              reviewTile(title: "Umar khan", context: context),
            ],
          ),
        ),
      ),
    );
  }
}
