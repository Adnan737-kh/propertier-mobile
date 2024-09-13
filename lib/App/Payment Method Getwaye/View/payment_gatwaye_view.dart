import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:paymob_pakistan/paymob_payment.dart';
import 'package:propertier/App/What%20are%20you%20searching/View/Components/custom_botton_wryf.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/divider.dart';
import '../ViewModel/payment_gatewaye_viewmodel.dart';

class PaymentGatwayeView extends GetView<PaymentGatwayeViewModel> {
  const PaymentGatwayeView({super.key});
  static const _apiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TWpjNU5UVXNJbTVoYldVaU9pSnBibWwwYVdGc0luMC5EdGF6UFRDQmFfNnJHVUJNcTNJSnMtTFRoRzNGejJGcUpjZDkycVRHVXRlTHl2cjFOSnVBV2huSURWSmpzQU9tMVd0WEdxMDBReDBXcjd3dDBkTU9HUQ==';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.getSize.width * 0.036),
          child: Column(
            children: [
              getHeight(context, 0.036),
              customAppBar(
                context: context,
                title: "Feature Ad",
                onTap: () {
                  Get.back();
                },
              ),
              getHeight(context, 0.058),
              selectPaymentMethod(context),
              getHeight(context, 0.010),
              divider(context: context, withOpacity: 0.5),
              getHeight(context, 0.025),
              selectDurationMethod(context),
              getHeight(context, 0.025),
              features(context),
              getHeight(context, 0.035),
              customButton(
                  title: "Submit",
                  onTap: () async {
                    try {
                      if (controller.price != '') {
                        final price =
                            (int.parse(controller.price) * 100).toString();
                        PaymobPakistan.instance
                            .initialize(
                          apiKey: _apiKey,
                          integrationID: 135513,
                          iFrameID: 52288,
                          jazzcashIntegrationId: 135516,
                          easypaisaIntegrationID: 135519,
                        )
                            .then((value) async {
                          PaymentInitializationResult response =
                              await PaymobPakistan.instance.initializePayment(
                            currency: "PKR",
                            amountInCents: price,
                          );
                          String authToken = response.authToken;
                          int orderID = response.orderID;
                          if (controller.seletedBank == "EasyPaisa") {
                            PaymobPakistan.instance.makePayment(
                              context,
                              currency: "PKR",
                              amountInCents: price,
                              paymentType: PaymentType.easypaisa,
                              authToken: authToken,
                              orderID: orderID,
                            );
                          }
                          if (controller.seletedBank == "JazzCash") {
                            PaymobPakistan.instance.makePayment(
                              context,
                              currency: "PKR",
                              amountInCents: price,
                              paymentType: PaymentType.jazzcash,
                              authToken: authToken,
                              orderID: orderID,
                            );
                          }
                          if (controller.seletedBank == "Bank") {
                            PaymobPakistan.instance.makePayment(
                              context,
                              currency: "PKR",
                              amountInCents: price,
                              paymentType: PaymentType.card,
                              authToken: authToken,
                              orderID: orderID,
                            );
                          }
                        });
                      }
                      // PaymentInitializationResult response = await PaymobPakistan.instance.initializePayment(

                      //   currency: "PKR",
                      //   amountInCents: "500",
                      // );

                      // String authToken = response.authToken;
                      // int orderID = response.orderID;

                      // PaymobPakistan.instance.makePayment(context,
                      //     currency: "PKR",
                      //     amountInCents: "100",
                      //     paymentType: PaymentType.jazzcash,
                      //     authToken: authToken,
                      //     orderID: orderID,
                      //     onPayment: (response) => null);
                    } catch (err) {
                      rethrow;
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Obx features(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appText(
                title: "Get your Ad Featured:",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                context: context),
            radioOfFeaturebtns(
              context,
              "Reach up to 10x more buyers.",
              controller.tenXMoreBuyers,
              (p0) {
                controller.onChangeTenXMoreBuyers(p0!);
              },
            ),
            radioOfFeaturebtns(
              context,
              "Show your Ad in top position.",
              controller.adOnTopPostion,
              (p0) {
                controller.onChangeAdOnTopPostion(p0!);
              },
            ),
            radioOfFeaturebtns(
              context,
              "Get noticed with a Feature Ad tag.",
              controller.featureAdTag,
              (p0) {
                controller.onChangeFeatureAdTag(p0!);
              },
            ),
          ],
        ));
  }

  Row radioOfFeaturebtns(BuildContext context, String title, bool isSelect,
      void Function(bool?)? onChanged) {
    return Row(
      children: [
        Checkbox(
          shape: const CircleBorder(),
          activeColor: AppColor.facebookColor,
          value: isSelect,
          onChanged: onChanged,
        ),
        const Gap(4),
        appText(title: title, context: context, colorOpecity: 0.6),
      ],
    );
  }

  Obx selectDurationMethod(BuildContext context) {
    return Obx(() => Column(
          children: [
            selectDurationAd(
              context: context,
              Pkr: "500",
              days: "7 Days",
              isVerification: controller.propertyVerification,
              isVerificationAvil: true,
              selectDays: controller.selectedDuration == "7 Days",
              onChangedRadio: (p0) {
                if (controller.propertyVerification) {
                  controller.onChangePropertyVerification(false);
                } else {
                  controller.onChangePropertyVerification(true);
                }
              },
              onChanged: (p0) {
                controller.onChangeSelectedDuration("7 Days", '500');
              },
            ),
            selectDurationAd(
              context: context,
              Pkr: "1000",
              days: "15 Days",
              isVerificationAvil: false,
              selectDays: controller.selectedDuration == "15 Days",
              onChangedRadio: (p0) {},
              onChanged: (p0) {
                controller.onChangeSelectedDuration("15 Days", '1000');
              },
            ),
            selectDurationAd(
              context: context,
              Pkr: "1500",
              days: "1 Month",
              isVerificationAvil: false,
              selectDays: controller.selectedDuration == "1 Month",
              onChangedRadio: (p0) {},
              onChanged: (p0) {
                controller.onChangeSelectedDuration("1 Month", '1500');
              },
            ),
          ],
        ));
  }

  Column selectDurationAd({
    required BuildContext context,
    required String days,
    required String Pkr,
    required bool selectDays,
    required void Function(bool?)? onChanged,
    required void Function(bool?)? onChangedRadio,
    bool isVerification = true,
    required bool isVerificationAvil,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  activeColor: AppColor.buttonColor,
                  value: selectDays,
                  onChanged: onChanged,
                ),
                const Gap(4),
                appText(title: days, context: context, colorOpecity: 0.6),
              ],
            ),
            appText(
                title: "$Pkr PKR",
                context: context,
                color: AppColor.facebookColor),
          ],
        ),
        isVerificationAvil
            ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Gap(40),
                  Radio(
                    toggleable: true,
                    activeColor: AppColor.buttonColor,
                    value: isVerification,
                    groupValue: true,
                    onChanged: onChangedRadio,
                  ),
                  // const Gap(4),
                  Expanded(
                    child: appText(
                        title:
                            "Propertier property evaluation and verification.",
                        context: context,
                        colorOpecity: 0.5),
                  )
                ],
              )
            : const Gap(0),
        getHeight(context, 0.015),
        divider(context: context, withOpacity: 0.1)
      ],
    );
  }

  Column selectPaymentMethod(BuildContext context) {
    return Column(children: [
      Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectPaymentWayTile(context, "EasyPaisa", Constant.easyPaisaicon,
                  controller.seletedBank == "EasyPaisa", () {
                controller.onChangeBank("EasyPaisa");
              }),
              selectPaymentWayTile(context, "JazzCash", Constant.jassCashicon,
                  controller.seletedBank == "JazzCash", () {
                controller.onChangeBank("JazzCash");
              }),
              selectPaymentWayTile(context, "Bank", Constant.bankicon,
                  controller.seletedBank == "Bank", () {
                controller.onChangeBank("Bank");
              }),
            ],
          ))
    ]);
  }

  InkWell selectPaymentWayTile(BuildContext context, String title, String image,
      bool isSelect, Function()? onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: context.getSize.height * 0.13,
        width: context.getSize.height * 0.13,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 2,
                color: isSelect
                    ? AppColor.facebookColor
                    : AppColor.textColorGrey.withOpacity(0.4))),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                image,
                height: context.getSize.height * 0.04,
              ),
              getHeight(context, 0.01),
              appText(title: title, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
