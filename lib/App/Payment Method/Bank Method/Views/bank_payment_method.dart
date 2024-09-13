import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Payment%20Method/Bank%20Method/ViewModel/bank_payment_method_viewmodel.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/AppButton/text_button.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';

class BankPaymentMethodView extends GetView<BankPaymentMethodViewModel> {
  const BankPaymentMethodView({super.key});

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
                  title: "Bank ALflah",
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
                getHeight(context, 0.020),
                customTextField(
                  hintText: "Account number",
                  controller: controller.accountNumber,
                  validator: (p0) {
                    if (p0!.isEmpty || p0 == "") {
                      return "Please provide Account number";
                    }
                    return null;
                  },
                ),
                getHeight(context, 0.020),
                customTextField(
                  hintText: "CNIC NO",
                  controller: controller.cNiCNo,
                  validator: (p0) {
                    if (p0!.isEmpty || p0 == "") {
                      return "Please provide CNIC NO";
                    }
                    return null;
                  },
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
