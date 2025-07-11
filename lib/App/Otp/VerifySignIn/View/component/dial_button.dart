import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertier/App/Otp/VerifySignIn/ViewModel/verify_sigin_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

GestureDetector dialButton(VerifySignInViewModel viewModel, int index,
    String email, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (index == 11) {
        viewModel.clearPin(viewModel.selectedFieldIndex);
      } else {
        viewModel.updatePin(context, viewModel.numberList[index], email,
            viewModel.selectedFieldIndex);
      }
    },
    child: Container(
      margin: EdgeInsets.all(context.getSize.width * 0.03),
      // height: context.getSize.height * 0.070,
      width: context.getSize.width * 0.24,
      padding: EdgeInsets.symmetric(
          horizontal: context.getSize.width * 0.06,
          vertical: context.getSize.height * 0.01),
      decoration: BoxDecoration(
          color: index == 9 ? Colors.transparent : AppColor.forGroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: index == 11
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                Constant.backArrow,
                height: 18,
              ),
            )
          : CustomText(
              title: viewModel.numberList[index],
              fontSize: 40,
              fontWeight: FontWeight.w400),
    ),
  );
}
