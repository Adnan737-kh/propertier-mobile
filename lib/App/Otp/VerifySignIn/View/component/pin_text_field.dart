import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Otp/VerifySignIn/ViewModel/verify_sigin_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';

import 'package:propertier/extensions/size_extension.dart';

// ignore: must_be_immutable
class VerifySigninPinField extends StatelessWidget {
  final int pinLength;
  final Function(String) onComplete;
  VeifySigninViewModel viewModel;

  VerifySigninPinField(
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
                        color: AppColor.primaryColor.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  viewModel.getSelectedFieldIndex(index);
                },
                // _onDigitPressed(index),
                child: Obx(
                  () => appText(
                    context: context,
                    fontSize: 14,
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
