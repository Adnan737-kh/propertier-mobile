import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Payment%20Method/MarketPlace%20Payment/Components/mpp_custom_textfield.dart';
import 'package:propertier/App/Rental/Components/rental_cutom_btn.dart';

import 'package:propertier/constant/AppButton/text_button.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/app_text.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../constant/constant.dart';
import '../ViewModel/marketplace_payment_viewmodel.dart';

class MarketPlacePaymentView extends GetView<MarketPlacePaymentViewModel> {
  const MarketPlacePaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.mPPformKey,
            child: Column(
              children: [
                getHeight(context, 0.080),
                customAppBar(
                  context: context,
                  onTap: () {
                    Get.back();
                  },
                ),
                getHeight(context, 0.043),
                Image.asset(
                  Constant.onboardingIcon,
                  height: context.getSize.height * 0.03,
                ),
                getHeight(context, 0.061),
                rentalCustomButton(
                    title: 'Marketplace',
                    onTap: () {},
                    buttonColor: AppColor.greenColor),
                getHeight(context, 0.056),
                mPPCustomTextfield(
                    context: context,
                    textEditingController: controller.amountController,
                    labelText: "Please enter your ammount",
                    validatorString: "Required your ammount"),
                getHeight(context, 0.018),
                mPPCustomTextfield(
                    context: context,
                    textEditingController:
                        controller.depositPercentageController,
                    labelText: "Your Security Deposit",
                    validatorString: "Required Deposit"),
                getHeight(context, 0.018),
                mPPCustomTextfield(
                    context: context,
                    textEditingController: controller.currentBalanceController,
                    labelText: "Your Current Balance",
                    validatorString: "Required Current Balance"),
                getHeight(context, 0.18),
                customTextButton(
                    title: "Done",
                    buttonColor: AppColor.buttonColor,
                    textColor: AppColor.blackColor,
                    onTap: () {
                      if (controller.mPPformKey.currentState!.validate()) {
                        if (double.parse(controller.amountController.text) >
                            double.parse(
                                controller.currentBalanceController.text)) {
                          Get.defaultDialog(
                              radius: 10,
                              title: "",
                              content: Column(
                                children: [
                                  const Icon(
                                    CupertinoIcons.clear_circled,
                                    size: 70,
                                    color: Color.fromRGBO(207, 14, 0, 1),
                                  ),
                                  CustomText(
                                      title: context.local.oops,
                                      fontSize: 18,
                                      colorOpecity: 0.6,
                                      fontWeight: FontWeight.bold),
                                  getHeight(context, 0.008),
                                  const CustomText(
                                    title:
                                        "You enter amount more \nthen your Current Balance.",
                                    fontSize: 16,
                                    colorOpecity: 0.6,
                                  ),
                                  getHeight(context, 0.008),
                                  GestureDetector(
                                    child: CustomText(
                                        title: context.local.enter_again,
                                        fontSize: 12,
                                        color: AppColor.facebookColor,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ));
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
