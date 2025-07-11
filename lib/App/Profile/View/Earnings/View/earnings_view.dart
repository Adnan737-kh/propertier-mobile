import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/About/View/about_view.dart';
import 'package:propertier/App/Profile/View/Earnings/ViewModel/earnings_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class EarningsView extends StatelessWidget {
  EarningsView({super.key});
  final viewModel = Get.find<EarningsViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          children: [
            SizedBox(
              height: context.getSize.height * 0.04,
            ),
            customAppBar(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                context: context,
                onTap: () {
                  Get.back();
                },
                title: context.local.earnings),
            getHeight(context, 0.1),
            Expanded(
                child: ListView(
              children: List.generate(
                  viewModel.earningsList.length,
                  (index) => GestureDetector(
                        onTap: viewModel.earningsList[index].onTap,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.white,
                              border: border(),
                              boxShadow: [boxShadow()]),
                          child: CustomText(
                            title: viewModel.earningsList[index].title,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
            ))
          ],
        ),
      )),
    );
  }
}
