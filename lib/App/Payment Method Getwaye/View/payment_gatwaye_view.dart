import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/App/Payment%20Method%20Getwaye/Services/services.dart';
// import 'package:paymob_pakistan/paymob_payment.dart';
import 'package:propertier/App/What%20are%20you%20searching/View/Components/custom_botton_wryf.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Features/Featured Pakages/Controller/featured_pakages_controller.dart';
import '../../../Features/Featured Pakages/Views/featured_pakages_view.dart';
// import '../../../Utils/divider.dart';
import '../../../Features/Payment Method/Services/service.dart';
import '../../../Features/Payment Method/Sockets/sockets.dart';
import '../../../Network/api_urls.dart';
import '../ViewModel/payment_gatewaye_viewmodel.dart';

class PaymentGatwayeView extends GetView<PaymentGatwayeViewModel> {
  const PaymentGatwayeView({super.key});
  // static const _apiKey =
  //     'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TWpjNU5UVXNJbTVoYldVaU9pSnBibWwwYVdGc0luMC5EdGF6UFRDQmFfNnJHVUJNcTNJSnMtTFRoRzNGejJGcUpjZDkycVRHVXRlTHl2cjFOSnVBV2huSURWSmpzQU9tMVd0WEdxMDBReDBXcjd3dDBkTU9HUQ==';
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
                title: "Select Ad Duration Pakage ",
                onTap: () {
                  Get.back();
                },
              ),
              getHeight(context, 0.025),
              FeaturedPakagesView(),
              const Spacer(),
              features(context),
              getHeight(context, 0.035),
              Row(
                children: [
                  appText(
                      title: "Total",
                      style: context.textTheme.titleMedium,
                      context: context),
                  const Spacer(),
                  Obx(() {
                    return appText(
                        title:
                            "${Get.find<FeaturedPakagesController>().selectedFeaturedPakages.value.price ?? ""} PKR",
                        style: context.textTheme.titleMedium,
                        context: context);
                  })
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(()=> customButton(
            title: controller.isLoading.value? "Loading...": "Payment",
            onTap: () async {
              // PaymentStatusSocketService().connect(
              //     "${Finance.paymentStatusSocket}${GetStorage().read("id").toString()}/");
              // PaymentApiService().payMobIntention("1", "ABCD");
              try{
                if(controller.isLoading.value){
                  return;
                }
                String? featureId = Get.find<FeaturedPakagesController>().selectedFeaturedPakages.value.id.toString();
                print(featureId);
                print(controller.propertyId);
                if(featureId == null || featureId == "" || controller.propertyId == null || controller.propertyId == ""){
                  Get.rawSnackbar(message: 'Please Select Package and Property');
                  return;
                }
                controller.isLoading.value = true;
                print(controller.featuredItem);
                bool res = false;
                if(controller.featuredItem == "Profile"){
                  res = await FeaturedService().buyFeaturedProfileAd(GetStorage().read("id").toString(), featureId, "active", controller.image!);
                }
                else{
                  res = await FeaturedService().buyFeaturedAd(featureId, controller.propertyId, "active", controller.image);
                }
                controller.isLoading.value = false;
                if(res){
                  Get.rawSnackbar(message: 'Featured Ad Purchased Successfully.');
                }
                else{
                  Get.rawSnackbar(message: 'Could not succeed!');
                }
              }
              catch(e){
                print("error: $e");
              }
            })),
      ),
    );
  }

  Column features(BuildContext context) {
    return Column(
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
          true,
          (p0) {
            // controller.onChangeTenXMoreBuyers(p0!);
          },
        ),
        radioOfFeaturebtns(
          context,
          "Show your Ad in top position.",
          true,
          (p0) {
            // controller.onChangeAdOnTopPostion(p0!);
          },
        ),
        radioOfFeaturebtns(
          context,
          "Get noticed with a Feature Ad tag.",
          true,
          (p0) {
            // controller.onChangeFeatureAdTag(p0!);
          },
        ),
      ],
    );
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
