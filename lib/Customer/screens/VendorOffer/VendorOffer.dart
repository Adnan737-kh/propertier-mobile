import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Customer/screens/VendorOffer/VendorOfferController.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../App/ServicesSearch/View/component/accept_reject_button.dart';
import '../../../Utils/app_text.dart';
import '../../../Utils/border.dart';
import '../../../Utils/box_shadow.dart';
import '../../../Utils/height_width_box.dart';
import '../../../Utils/scrollableText.dart';
import '../../../Utils/textStyle.dart';
import '../../../constant/colors.dart';
import '../../../constant/constant.dart';

class VendorOffer extends GetView<VendorOfferController> {
  const VendorOffer({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.blackColor,
            )),
        title: CustomText(
            title: "Vendor Offers",
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              OfferCard(),
              OfferCard(),
              OfferCard(),
              OfferCard(),
              OfferCard(),
              OfferCard(),
              OfferCard(),
              OfferCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.getSize.height * 0.015),
      decoration: BoxDecoration(
          border: border(),
          boxShadow: [
            boxShadow(),
          ],
          color: const Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColor.white,
                border: border(),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                boxShadow: [boxShadow()]),
            padding: EdgeInsets.symmetric(
                horizontal: context.getSize.width * 0.01,
                vertical: context.getSize.height * 0.007),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // RichText(
                //     text: TextSpan(
                //         style: textStyle(
                //             color: AppColor.blackColor
                //                 .withOpacity(0.6),
                //             context: context,
                //             fontSize: context.fontSize(8),
                //             fontWeight: FontWeight.w500),
                //         text:
                //             "${servicesModel.title} ID:  ",
                //         children: [
                //       TextSpan(
                //           text: '73648A467383',
                //           style: textStyle(
                //               color: AppColor.blackColor
                //                   .withOpacity(0.5),
                //               context: context,
                //               fontSize: context.fontSize(8),
                //               fontWeight: FontWeight.w400))
                //     ])),
                CustomText(
                    colorOpecity: 0.5,
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    title: "12-06-2024",
                     ),
                CustomText(
                    color: AppColor.appleColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    title: "pending",
                     ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getHeight(context, 0.008),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(Constant.dummyImage2),
                        ),
                        getWidth(context, 0.01),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            scrollableText(
                                width: 0.5,
                                context: context,
                                textStyle: textStyle(
                                    context: context,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                title: "Vendor Name"),
                            getHeight(context, 0.005),
                            scrollableText(
                                width: 0.5,
                                context: context,
                                textStyle: textStyle(
                                    context: context,
                                    fontSize: 8,
                                    color: AppColor.blackColor.withOpacity(0.7),
                                    fontWeight: FontWeight.w500),
                                title: "Detail of the vendor/address etc"),
                            getHeight(context, 0.005),
                            scrollableText(
                                width: 0.5,
                                context: context,
                                textStyle: textStyle(
                                    context: context,
                                    fontSize: 14,
                                    color: const Color(0xffC10C00),
                                    fontWeight: FontWeight.w500),
                                title: 'PKR 12050'),
                            getHeight(context, 0.005),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Icon(
                            //     Ionicons.chatbubble_outline,
                            //     color:
                            //     const Color(0xff797979),
                            //     size:
                            //     context.getSize.height *
                            //         0.025,
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        acceptRejectButton(
                            textColor: AppColor.white,
                            color: AppColor.greenColor,
                            radius: 10,
                            textFontSize: 10,
                            context: context,
                            title: context.local.accept,
                            onClick: () async {}),
                        getHeight(context, 0.008),
                        acceptRejectButton(
                            textColor: AppColor.blackColor,
                            color: AppColor.buttonColor,
                            radius: 10,
                            textFontSize: 10,
                            context: context,
                            title: context.local.reject,
                            onClick: () {}),
                        getHeight(context, 0.01),
                        CustomText(
                            title: '00:15',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            )
                      ],
                    )
                  ],
                ),
                getHeight(context, 0.008)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
