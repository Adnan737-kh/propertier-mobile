import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Profile/ViewModel/profile_view_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';

// ignore: must_be_immutable
class ProfilePostsTile extends StatelessWidget {
  ProfileViewModel viewModel;
  ProfilePostsTile({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getHeight(context, 0.005),
        RichText(
            text: TextSpan(
                style: textStyle(
                    context: context,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
                text: "What are you searching for? ",
                children: [
              TextSpan(
                  style: textStyle(
                      fontSize: 12,
                      context: context,
                      fontWeight: FontWeight.w700,
                      color: AppColor.greenColor),
                  text: 'Post Here',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(AppRoutes.whatAreYouSearchingView);
                    })
            ])),
        getHeight(context, 0.01),
        divider(context: context),
        getHeight(context, 0.005),
      ],
    );
  }
}
