import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../constant/colors.dart';

import '../../../../Utils/height_width_box.dart';
import '../ViewModel/number_verification_view_model.dart';
import 'components/number_verify_tile.dart';

class NumberVerificationView extends StatelessWidget {
  NumberVerificationView({super.key});
  final editProfileVM = Get.find<NumberVerificationViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: AppColor.blackColor,
        ),
        title: const Text(
          "Number Verification",
          style: TextStyle(
            color: AppColor.blackColor,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.060),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  numberVerifyTile(
                      title: "Your Number is not verified", isVerify: false),
                  const Gap(5),
                  getHeight(context, 0.06),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
