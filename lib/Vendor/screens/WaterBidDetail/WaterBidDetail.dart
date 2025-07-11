import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../Utils/app_text.dart';
import '../../../Utils/text_botton.dart';
import '../../../constant/colors.dart';
import 'WaterBidDetailController.dart';

class WaterBidDetail extends GetView<WaterBidDetailController> {
  const WaterBidDetail({super.key});

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
            title: "Water Bid Detail",
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                                onTap: () {},
                                onDoubleTap: () {},
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: i,
                                      width: Get.width,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          SizedBox(
                                        width: Get.width,
                                        height: Get.height * 0.4,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )),
                  Obx(() => Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: AnimatedSmoothIndicator(
                          activeIndex: controller.carousalIndex.value,
                          count: controller
                              .album.length, // Number of items in your slider
                          effect: const WormEffect(
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
              const Divider(),
              Align(
                alignment: Alignment.center,
                child: CustomText(
                    title: "Order Detail",
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              ListTile(
                title: CustomText(
                    title: "Water Type",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    textAlign: TextAlign.start),
                subtitle: CustomText(
                    title: "Drinking Water",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    textAlign: TextAlign.start),
              ),
              ListTile(
                title: CustomText(
                    title: "Delivery Service",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    textAlign: TextAlign.start),
                subtitle: CustomText(
                    title: "By Water Provider",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    textAlign: TextAlign.start),
              ),
              ListTile(
                title: CustomText(
                    title: "Packing Type",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    textAlign: TextAlign.start),
                subtitle: CustomText(
                    title: "200 liter container",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    textAlign: TextAlign.start),
              ),
              ListTile(
                title: CustomText(
                    title: "Description",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    textAlign: TextAlign.start),
                subtitle: CustomText(
                    title:
                        "Description Iron frames for the piston dei. dummy text for the order.",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    textAlign: TextAlign.start),
              ),
              ListTile(
                title: CustomText(
                    title: "Order Date & Time",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    textAlign: TextAlign.start),
                subtitle: CustomText(
                    title: "10-10-2025 12:30 pm",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    textAlign: TextAlign.start),
              ),
              const Divider(),
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
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
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
                      padding: const EdgeInsets.all(5),
                      child: textButton(
                          textFontSize: 20,
                          textFontWeight: FontWeight.w500,
                          context: context,
                          title: 'Accept',
                          onClick: () {}),
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
