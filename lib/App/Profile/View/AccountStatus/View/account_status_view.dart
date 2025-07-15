import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Profile/View/AccountStatus/Model/account_status_model.dart';
import 'package:propertier/App/Profile/View/AccountStatus/View/component/circular_progress_indicator.dart';
import 'package:propertier/App/Profile/View/AccountStatus/ViewModel/account_status_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class AccountStatusView extends StatelessWidget {
  AccountStatusView({super.key});
  final viewModel = Get.find<AccountStatusViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          children: [
            SizedBox(
              height: context.getSize.height * 0.04,
            ),
            customAppBar(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                context: context,
                onTap: () {
                  Get.back();
                },
                title: 'Account Status'),
            getHeight(context, 0.045),
            Expanded(
                child: ListView(
              children: [
                Column(
                  children: List.generate(viewModel.accountStatusList.length,
                      (index) {
                    AccountStatusModel accountStatus =
                        viewModel.accountStatusList[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: index == 3 - 1 ? 0 : 10),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          border: border(),
                          boxShadow: [boxShadow()],
                          borderRadius: BorderRadius.circular(10)),
                      child: ExpansionTile(
                          title: CustomText(
                              textAlign: TextAlign.start,
                              title: accountStatus.title,
                             ),
                          children: index == 2
                              ? [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xff1B1B1B),
                                        boxShadow: [boxShadow()]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                            textAlign: TextAlign.start,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            title:
                                                "Lorem ipsum dolor sit amet consectetur. Est orci sit a risus id faucibus. Nam risus sed velit in. Arcu at sit vitae diam nibh congue. Urna massa risus egestas sagittis.",
                                            color: AppColor.buttonColor),
                                        getHeight(context, 0.010),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                                onTap: () {},
                                                child: CustomText(
                                                    title: context.local.need_help,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.white)),
                                            GestureDetector(
                                              onTap: () {},
                                              child: CustomText(
                                                  title: context.local.contact_support,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.white),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ]
                              : []),
                    );
                  }),
                ),
                getHeight(context, 0.06),
                CustomPaint(
                    painter: CircularProgressPainter(
                      strokeWidth: 30,
                      color: AppColor.buttonColor,
                      value: 100 / 100,
                    ),
                    child: Container(
                      height: context.getSize.height * 0.23,
                      width: context.getSize.height * 0.23,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: const CustomText(
                          title: '60 %',
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                    )),
                getHeight(context, 0.040),
                CustomText(
                    title: context.local.profile_complete,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)
              ],
            ))
          ],
        ),
      )),
    );
  }
}
