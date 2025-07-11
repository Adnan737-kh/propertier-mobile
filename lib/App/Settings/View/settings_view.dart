import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Settings/ViewModel/settings_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final viewModel = Get.find<SettingsViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          children: [
            getHeight(context, 0.04),
            customAppBar(
                context: context,
                onTap: () {
                  Get.back();
                },
                title: context.local.settings),
            getHeight(context, 0.045),
            ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                  viewModel.settingsList.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: GestureDetector(
                          onTap: viewModel.settingsList[index].onTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.white,
                                border: border(),
                                boxShadow: [boxShadow()]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  title: viewModel.settingsList[index].title,
                                ),
                                const Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ),
                        ),
                      )),
            )
          ],
        ),
      )),
    );
  }
}
