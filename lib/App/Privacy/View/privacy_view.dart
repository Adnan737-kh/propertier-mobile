import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Privacy/ViewModel/privacy_viewmodel.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/divider.dart';
import '../../../constant/colors.dart';
import '../Components/privacy_tile.dart';

class PrivacyView extends GetView<PrivacyViewModel> {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    var light = false.obs;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getHeight(context, 0.065),
                customAppBar(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    context: context,
                    onTap: () {
                      Get.back();
                    },
                    title: 'Privacy'),
                getHeight(context, 0.045),
                getHeight(context, 0.010),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lock_outline_sharp,
                          color: AppColor.blackColor.withOpacity(0.6),
                          size: 17,
                        ),
                        getWidth(context, 0.005),
                        appText(
                            title: "Private Account",
                            context: context,
                            fontSize: 14,
                            colorOpecity: 0.6,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    Obx(() => Switch.adaptive(
                          // Don't use the ambient CupertinoThemeData to style this switch.
                          applyCupertinoTheme: false,
                          activeColor: AppColor.buttonColor,
                          value: light.value,
                          onChanged: (bool value) {
                            light.value = value;
                          },
                        )),
                  ],
                ),
                getHeight(context, 0.015),
                divider(context: context),
                privacyTile(context: context, title: "Comment"),
                getHeight(context, 0.015),
                privacyTile(context: context, title: "Posts"),
                getHeight(context, 0.015),
                privacyTile(context: context, title: "Account You Follow"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
