import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:propertier/App/ServicesSearch/View/component/accept_reject_button.dart';
import 'package:propertier/App/ServicesSearch/ViewModel/services_search_view_model_2.dart';
import 'package:propertier/App/ServicesSearch/model/VendorResponseModel.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';


class ServicesSearch2View extends GetView<ServicesSearhViewModel2> {
  const ServicesSearch2View({super.key});
  @override
  Widget build(BuildContext context) {
    final day = DateFormat.d().format(DateTime.now());
    final month = DateFormat.M().format(DateTime.now());
    final year = DateFormat.y().format(DateTime.now());
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            Constant.curve,
            width: context.getSize.width,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.09),
            child: Column(
              children: [
                getHeight(context, 0.050),
                customAppBar(
                    context: context,
                    onTap: () {
                      Get.back();
                    }),
                getHeight(context, 0.09),
                // SvgPicture.asset(servicesModel.icon),
                getHeight(context, 0.01),
                SizedBox(
                  width: context.getSize.width * 0.7,
                  child: CustomText(
                    title: context.local.services_search_notification_request_send,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                getHeight(context, 0.015),
                Expanded(
                  child: Obx(() =>ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: controller.offers.length,
                      itemBuilder: (context, index) {
                        VendorOfferModel offer = controller.offers[index];
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: context.getSize.height * 0.015),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                        title: "$day-$month-$year",
                                        ),
                                    CustomText(
                                      color: offer.bidResponse?.status == "accepted"?AppColor.joinAsBtnColor:AppColor.appleColor,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        title: offer.bidResponse?.status??"pending.",
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.getSize.width * 0.01),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    getHeight(context, 0.008),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                  offer.bidResponse?.vendor?.profilePictureUrl??Constant.dummyImage2),
                                            ),
                                            getWidth(context, 0.01),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                scrollableText(
                                                    width: 0.5,
                                                    context: context,
                                                    textStyle: textStyle(
                                                        context: context,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                    title: offer.bidResponse?.vendor?.name??""
                                                ),
                                                getHeight(context, 0.005),
                                                scrollableText(
                                                    width: 0.5,
                                                    context: context,
                                                    textStyle: textStyle(
                                                        context: context,
                                                        fontSize: 8,
                                                        color: AppColor
                                                            .blackColor
                                                            .withOpacity(0.7),
                                                        fontWeight:
                                                        FontWeight.w500),
                                                    title: offer.bidResponse?.vendor?.address??""),
                                                getHeight(context, 0.005),
                                                scrollableText(
                                                    width: 0.5,
                                                    context: context,
                                                    textStyle: textStyle(
                                                        context: context,
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0xffC10C00),
                                                        fontWeight:
                                                        FontWeight.w500),
                                                    title: 'PKR ${offer.bidResponse?.amount??""}'),
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
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            acceptRejectButton(
                                                textColor: AppColor.white,
                                                color: AppColor.greenColor,
                                                radius: 10,
                                                textFontSize: 10,
                                                context: context,
                                                title: context.local.accept,
                                                onClick: () async{
                                                  // Get.toNamed(
                                                  //     AppRoutes.servicesMapView,
                                                  //     arguments: offer);
                                                  controller.finalizeBid(context, offer.bidResponse?.id.toString()??"", "accepted", offer.bidResponse?.vendor?.id.toString()??"");
                                                  bool res = await controller.createOrder(context: context, bidId: offer.bidResponse?.bid.toString()??"", vendorId: offer.bidResponse?.vendor?.id.toString()??"", customerId: GetStorage().read('id').toString(), serviceLocation: "service location", status: "pending", paymentStatus: "pending");
                                                  if(res){
                                                    Get.toNamed(
                                                        AppRoutes.servicesMapView,
                                                        arguments: offer);
                                                  }

                                                }),
                                            getHeight(context, 0.008),
                                            acceptRejectButton(
                                                textColor: AppColor.blackColor,
                                                color: AppColor.buttonColor,
                                                radius: 10,
                                                textFontSize: 10,
                                                context: context,
                                                title: context.local.reject,
                                                onClick: () {
                                                  controller.acceptBid(context, offer.bidResponse?.id.toString()??"", "rejected");
                                                }),
                                            getHeight(context, 0.01),
                                            const CustomText(
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
                      })),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
