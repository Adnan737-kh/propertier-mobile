import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Files/File%20detail/ViewModel/files_detail_viewmodel.dart';
import 'package:propertier/App/Files/File%20detail/Views/Components/files_detail_table.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/logo_tile.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../constant/AppButton/text_button.dart';
import '../../../../constant/colors.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/appbar.dart';

class FilesDetailView extends GetView<FilesDetailViewModel> {
  const FilesDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
              logoTile(context),
              getHeight(context, 0.056),
              getHeight(context, 0.015),
              customTextButton(
                  title: context.local.files_for_sale,
                  onTap: () {},
                  buttonColor: AppColor.greenColor,
                  textColor: AppColor.white),
              getHeight(context, 0.015),
              CustomText(
                textAlign: TextAlign.start,
                title: context.local.post_your_property,

                fontSize: 14,
                color: AppColor.facebookColor,
              ),
              getHeight(context, 0.015),
              Container(
                width: context.getSize.width,
                height: 200,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/map.png")),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              getHeight(context, 0.015),
              const FilesDetailTable(data: [
                {
                  'Files': "5 Marla",
                  'Category': "Residential",
                  '#Of File': "70",
                  "Asking Price": "50K Each",
                  "Paid Price": "1 lac Each",
                  "Total Paid": "70 loc"
                },
                {
                  'Files': "10 Marla",
                  'Category': "Residential",
                  '#Of File': "10",
                  "Asking Price": "1 lac Each",
                  "Paid Price": "2 lac Each",
                  "Total Paid": "140 loc"
                },
                {
                  'Files': "20 Marla",
                  'Category': "Residential",
                  '#Of File': "10",
                  "Asking Price": "2 lac Each",
                  "Paid Price": "4 lac Each",
                  "Total Paid": "560 loc"
                },
                {
                  'Files': "3 Marla",
                  'Category': "Commercial",
                  '#Of File': "10",
                  "Asking Price": "11.50 lac Each",
                  "Paid Price": "23 lac Each",
                  "Total Paid": "230 loc"
                },
                {
                  'Files': "",
                  'Category': "",
                  '#Of File': "= 100",
                  "Asking Price": "",
                  "Paid Price": "=18,00000000",
                  "Total Paid": "= 100 M"
                },
              ]),
              divider(context: context),
              getHeight(context, 0.015),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      title: context.local.location,
                      fontSize: 12),
                  getHeight(context, 0.008),
                  const CustomText(
                      title:
                          "Bahria Town Sector F, near main Masjid, Street # 32",
                      fontSize: 12,

                      colorOpecity: 0.7),
                  divider(context: context),
                ],
              ),
              getHeight(context, 0.015),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      title: context.local.facilities,
                      fontSize: 12,
                     ),
                  getHeight(context, 0.008),
                  const CustomText(
                      title: "Electricity, gas, Water etc",
                      fontSize: 12,

                      colorOpecity: 0.7),
                  divider(context: context),
                ],
              ),
              getHeight(context, 0.015),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      title: context.local.develop_satiation,
                      fontSize: 12,),
                  getHeight(context, 0.008),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          title: "NOC(Approved From CDA)",
                          fontSize: 12,

                          colorOpecity: 0.7),
                      CustomText(
                          title: "0651",
                          fontSize: 12,
                          colorOpecity: 0.7),
                    ],
                  ),
                  divider(context: context),
                ],
              ),
              getHeight(context, 0.018),
              customTextButton(
                  title: "Book Now",
                  onTap: () {
                    Get.toNamed(AppRoutes.selectPaymentMethodView);
                  },
                  height: 25,
                  width: 100,
                  buttonColor: AppColor.greenColor),
              getHeight(context, 0.018),
            ],
          ),
        ),
      ),
    ));
  }
}
