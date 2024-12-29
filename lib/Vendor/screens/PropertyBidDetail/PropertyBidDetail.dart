import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertier/Vendor/screens/PropertyBidDetail/PropertyBidDetailController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/text_botton.dart';
import '../../../constant/colors.dart';

class PropertyBidDetail extends GetView<PropertyBidDetailController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back,color: AppColor.blackColor,)),
        title: appText(title: "Property Service Bid Detail", context: context,fontSize: 16,fontWeight: FontWeight.w600),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Obx(() => CarouselSlider(
                    options: CarouselOptions(
                      height: Get.height * 0.2,
                      initialPage: controller.carousalIndex.value,
                      autoPlay: false,
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        controller.carousalIndex.value = index;
                      },
                    ),
                    items: controller.album.map<Widget>((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: (){

                            },
                            onDoubleTap: (){},
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: i??"",
                                  width: Get.width,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => SizedBox(width: Get.width,
                                    height: Get.height * 0.4,),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  )),
                  Obx(() =>  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: AnimatedSmoothIndicator(
                      activeIndex: controller.carousalIndex.value,
                      count: controller.album.length,  // Number of items in your slider
                      effect: WormEffect(
                        dotHeight: 7,
                        dotWidth: 7,
                        spacing: 5,
                        activeDotColor: Colors.white,
                        dotColor: AppColor.blackColor,
                      ),
                    ),
                  ))
                ],
              ),
              Divider(),
              Align(
                alignment: Alignment.center,
                child: appText(title: "Order Detail", context: context,fontWeight: FontWeight.w600,fontSize: 16),
              ),
              ListTile(
                title: appText(title: "Work Overview", context: context,fontWeight: FontWeight.w600,fontSize: 14, textAlign: TextAlign.start),
                subtitle: appText(title: "want to design an architecture for my form house.", context: context,fontWeight: FontWeight.w500,fontSize: 14, textAlign: TextAlign.start),
              ),
              ListTile(
                title: appText(title: "Property Address", context: context,fontWeight: FontWeight.w600,fontSize: 14, textAlign: TextAlign.start),
                subtitle: appText(title: "G7 street No 5, House No 11, Islamabad", context: context,fontWeight: FontWeight.w500,fontSize: 14, textAlign: TextAlign.start),
              ),
              ListTile(
                title: appText(title: "Description", context: context,fontWeight: FontWeight.w600,fontSize: 14, textAlign: TextAlign.start),
                subtitle: appText(title: "Description Iron frames for the piston dei. dummy text for the order.", context: context,fontWeight: FontWeight.w500,fontSize: 14, textAlign: TextAlign.start),
              ),
              ListTile(
                title: appText(title: "Order Date & Time", context: context,fontWeight: FontWeight.w600,fontSize: 14, textAlign: TextAlign.start),
                subtitle: appText(title: "10-10-2025 12:30 pm", context: context,fontWeight: FontWeight.w500,fontSize: 14, textAlign: TextAlign.start),
              ),
              Divider(),
              SizedBox(
                height: 250,
                width: Get.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GoogleMap(
                    onMapCreated: (cnt) => controller.mapController = cnt,
                    initialCameraPosition: CameraPosition(
                      target: controller.endLatLng,
                      zoom: 6,
                    ),
                    markers: controller.markers,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: textButton(
                          textFontSize: 20,
                          textFontWeight: FontWeight.w500,
                          context: context,
                          title: 'Reject',
                          textColor: AppColor.white,
                          buttonColor: AppColor.googleColor,
                          onClick: () {
                            // showPriceDialog(context);
                          }),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: textButton(
                          textFontSize: 20,
                          textFontWeight: FontWeight.w500,
                          context: context,
                          title: 'Accept',
                          onClick: () {

                          }),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}