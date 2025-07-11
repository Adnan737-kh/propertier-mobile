import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';

import 'package:propertier/extensions/size_extension.dart';

import '../../ViewModel/number_otp_confirm_ViewModel.dart';

// ignore: must_be_immutable
class OTPVerifyPinField extends StatelessWidget {
  final int pinLength;
  final Function(String) onComplete;
  NumberOTPViewModel viewModel;

  OTPVerifyPinField(
      {super.key,
      required this.viewModel,
      required this.pinLength,
      required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(pinLength, (index) {
            return SizedBox(
              width: context.getSize.width * 0.12,
              height: context.getSize.height * 0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.backgroundColor,
                    side: BorderSide(
                        width: 3,
                        color: AppColor.primaryColor.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  viewModel.getSelectedFieldIndex(index);
                },
                // _onDigitPressed(index),
                child: Obx(
                  () => CustomText(
                    fontSize: 20,
                    title: viewModel.pin[index].isNotEmpty
                        ? viewModel.pin[index]
                        : '-',
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
