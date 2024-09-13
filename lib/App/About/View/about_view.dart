import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../Profile/ViewModel/profile_view_model.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(ProfileViewModel());
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
                title: context.local.about),
            getHeight(context, 0.045),
            ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: context.getSize.width * 0.2,
                      height: context.getSize.height * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(viewModel.profileModel.value
                                          .userProfile!.coverPhotoUrl !=
                                      null
                                  ? viewModel.profileModel.value.userProfile!
                                      .coverPhotoUrl!
                                  : Constant.dumyImage2),
                              fit: BoxFit.cover)),
                    ),
                    getWidth(context, 0.040),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            appText(
                                title: viewModel
                                    .profileModel.value.userProfile!.name!,
                                context: context,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            getWidth(context, 0.010),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.buttonColor),
                              child: Icon(
                                Icons.check,
                                size: context.getSize.width * 0.02,
                                color: AppColor.blackColor,
                              ),
                            )
                          ],
                        ),
                        appText(
                            colorOpecity: 0.6,
                            title: 'Dealer',
                            context: context,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        RatingBarIndicator(
                          rating: 4,
                          unratedColor: AppColor.greenColor,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: context.getSize.width * 0.034,
                          direction: Axis.horizontal,
                        ),
                        appText(
                            color: AppColor.textColorGrey,
                            title: viewModel
                                .profileModel.value.userProfile!.email
                                .toString(),
                            context: context,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ],
                    )
                  ],
                ),
                getHeight(context, 0.020),
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 40, top: 10, bottom: 10),
                  height: context.getSize.height * 0.5,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: [boxShadow()],
                  ),
                  child: appText(
                      color: AppColor.textColorGrey,
                      textAlign: TextAlign.start,
                      title:
                          viewModel.profileModel.value.userProfile!.email ?? "",
                      context: context,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
