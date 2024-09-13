import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Sale%20detail%20Page/ViewModel/sale_detail_viewmodel.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../constant/colors.dart';
import '../../../constant/constant.dart';
import '../../Rental/Components/rental_cutom_btn.dart';
import '../../../Utils/appbar.dart';
import '../../../Utils/height_width_box.dart';
import '../Components/sale_detail_attribute.dart';

class SaleDetailView extends GetView<SaleDetailViewModel> {
  const SaleDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: SingleChildScrollView(
          child: Column(
            children: [
              getHeight(context, 0.050),
              customAppBar(
                context: context,
                onTap: () {
                  Get.back();
                },
              ),
              getHeight(context, 0.045),
              Image.asset(
                Constant.onboardingIcon,
                height: context.getSize.height * 0.03,
              ),
              getHeight(context, 0.045),
              rentalCustomButton(
                  title: context.local.for_sale,
                  buttonColor: AppColor.greenColor,
                  onTap: () {}),
              getHeight(context, 0.008),
              GestureDetector(
                onTap: () {},
                child: appText(
                    title: "Post Your Property",
                    color: AppColor.facebookColor,
                    context: context),
              ),
              getHeight(context, 0.015),
              Container(
                height: 190,
                width: context.width,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(Constant.onboardingImage1),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.darkGreyColor.withOpacity(.3)),
                child: Container(
                  height: 190,
                  width: context.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.darkGreyColor.withOpacity(.25),
                          blurRadius: 4,
                          offset: const Offset(-1, 1),
                        )
                      ],
                      color: AppColor.darkGreyColor.withOpacity(.1)),
                ),
              ),
              getHeight(context, 0.015),
              appText(
                  title: "-05:35:10",
                  context: context,
                  fontSize: 18,
                  colorOpecity: 0.7),
              getHeight(context, 0.015),
              saleDetailAtribute(
                  context: context, title: "House for Sale", data: "5 Marla"),
              getHeight(context, 0.021),
              saleDetailAtribute(
                  context: context, title: "Type", data: "Residential"),
              getHeight(context, 0.021),
              saleDetailAtribute(
                  context: context, title: "Demand", data: "1.7 Crore"),
              getHeight(context, 0.021),
              saleDetailAtribute(
                  context: context,
                  title: "Location",
                  data: "Bahria Town Phase 7 islamabad"),
              getHeight(context, 0.021),
              saleDetailAtribute(
                  context: context, title: "Adjustment Offer", data: "50%"),
              getHeight(context, 0.021),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appText(title: "Last Bid", context: context),
                  appText(
                      title: "1.6 Crore",
                      context: context,
                      color: AppColor.facebookColor,
                      fontSize: 10,
                      colorOpecity: 0.7)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
