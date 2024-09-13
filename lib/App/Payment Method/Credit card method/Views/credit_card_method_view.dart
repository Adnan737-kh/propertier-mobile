import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:info_popup/info_popup.dart';
import 'package:propertier/App/Payment%20Method/Credit%20card%20method/ViewModel/credit_card_method_viewmodel.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/AppButton/text_button.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';

class CreditPaymentMethodView extends GetView<CreditCardMethodViewModel> {
  const CreditPaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                getHeight(context, 0.050),
                customAppBar(
                  context: context,
                  title: "Credit/ Debit Card",
                  onTap: () {
                    Get.back();
                  },
                ),
                getHeight(context, 0.045),
                appText(
                    textAlign: TextAlign.start,
                    title:
                        "Lorem ipsum dolor sit amet consectetur. Diam scelerisque fermentum lectus turpis senectus. Eget sed auctor leo egestas.",
                    context: context,
                    fontSize: 14,
                    colorOpecity: 0.4),
                getHeight(context, 0.026),
                Row(
                  children: [
                    Image.asset(
                      Constant.masterCardIcon,
                      width: 29,
                      height: 13.17,
                    ),
                    const Gap(8),
                    Image.asset(
                      Constant.visaCardIcon,
                      width: 29,
                      height: 13.17,
                    ),
                    const Gap(8),
                    Image.asset(
                      Constant.unioCardIcon,
                      width: 29,
                      height: 13.17,
                    ),
                    const Gap(8),
                  ],
                ),
                getHeight(context, 0.020),
                customTextField(
                  hintText: context.local.card_number,
                  controller: controller.cardNumber,
                  validator: (p0) {
                    if (p0!.isEmpty || p0 == "") {
                      return "Please provide card number";
                    }
                    return null;
                  },
                ),
                getHeight(context, 0.020),
                customTextField(
                  hintText: context.local.name_card,
                  controller: controller.nameOnCard,
                  validator: (p0) {
                    if (p0!.isEmpty || p0 == "") {
                      return "Please provide Name on card";
                    }
                    return null;
                  },
                ),
                getHeight(context, 0.020),
                Row(
                  children: [
                    customTextField(
                      hintText: context.local.expiration,
                      controller: controller.expirationData,
                      width: context.getSize.width * 0.5,
                      validator: (p0) {
                        if (p0!.isEmpty || p0 == "") {
                          return "Please provide Expiration date";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                getHeight(context, 0.020),
                Row(
                  children: [
                    customTextField(
                      hintText: "CVV",
                      controller: controller.cVV,
                      width: context.getSize.width * 0.5,
                      suffix: const InfoPopupWidget(
                        contentTitle:
                            "it's a three digit number\n written with CVV or CVC",
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: 17,
                        ),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty || p0 == "") {
                          return "Please provide CVV number";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                getHeight(context, 0.122),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    appText(title: "Total Amount", context: context),
                    appText(title: "100M", context: context, fontSize: 10),
                  ],
                ),
                getHeight(context, 0.015),
                customTextButton(
                    title: "Pay Now",
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        Get.toNamed(AppRoutes.paymentDoneView);
                      }
                    },
                    buttonColor: AppColor.buttonColor,
                    textColor: AppColor.blackColor)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
